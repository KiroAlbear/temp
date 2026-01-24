import 'dart:io';

import 'package:deel/deel.dart';
import 'package:deel/features/most_selling/bloc/most_selling_bloc.dart';
import 'package:deel/features/recommended_items/bloc/recommended_items_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_loader/image_helper.dart';
import '../../../../../core/generated/l10n.dart';
import '../../../../core/Utils/firebase_analytics_events_names.dart';
import '../../../../core/Utils/firebase_analytics_utl.dart';
import 'dart:math' as math;

import '../../../../core/ui/new_section_widget.dart';
import '../../../recommended_items/ui/widget/recommended_item_widget.dart';
import 'skeletons/recommended_items_skeleton.dart';

class HomePage extends BaseStatefulWidget {
  final HomeBloc homeBloc;
  final CartBloc cartBloc;
  final ProductCategoryBloc productCategoryBloc;

  final UpdateProfileBloc updateProfileBloc;
  final ContactUsBloc contactUsBloc;
  ValueNotifier<bool> showOverlayLoading = ValueNotifier(false);

  HomePage({
    super.key,
    required this.homeBloc,
    required this.cartBloc,
    required this.productCategoryBloc,
    required this.updateProfileBloc,
    required this.contactUsBloc,
  });

  @override
  State<HomePage> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends BaseState<HomePage> {
  final ScrollController _scrollController = ScrollController();
  final FocusNode _focusNode = FocusNode();

  @override
  PreferredSizeWidget? appBar() => null;

  @override
  bool canPop() => false;

  @override
  bool isSafeArea() => false;

  @override
  void initState() {
    super.initState();
    customBackgroundColor = Colors.white;

    if (SharedPrefModule().isLoggedIn) {
      widget.cartBloc.getMyCart(
        onGettingCart: () {
          getIt<MostSellingBloc>().getMostSelling();
          getIt<RecommendedItemsBloc>().getRecommendedItems();
        },
      );
    } else {
      getIt<MostSellingBloc>().getMostSelling();
    }

    widget.homeBloc.loadData();

    widget.updateProfileBloc.loadDeliveryAddress(
      SharedPrefModule().userId ?? '0',
    );
  }

  @override
  Widget getBody(BuildContext context) => CustomScrollView(
    controller: _scrollController,
    shrinkWrap: true,
    slivers: [
      SliverToBoxAdapter(child: _topWidget),
      SliverToBoxAdapter(
        child: StreamBuilder<ApiState<List<OfferMapper>>>(
          stream: widget.homeBloc.heroBannersStream,
          builder: (context, snapshot) =>
              (snapshot.hasData &&
                  snapshot.data!.response != null &&
                  snapshot.data!.response!.isEmpty)
              ? SizedBox(height: 0)
              : SizedBox(height: 10.h),
        ),
      ),
      SliverToBoxAdapter(child: HeroBannersWidget(homeBloc: widget.homeBloc)),
      SliverToBoxAdapter(child: SizedBox(height: 16.h)),
      SharedPrefModule().isLoggedIn
          ? SliverToBoxAdapter(child: _recommendedProducts())
          : SliverToBoxAdapter(child: SizedBox()),
      SliverToBoxAdapter(child: SizedBox(height: 20.h)),
      SliverToBoxAdapter(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: CustomText(
            text: S.of(context).lastOffers,
            customTextStyle: BoldStyle(color: secondaryColor, fontSize: 20.sp),
          ),
        ),
      ),

      SliverToBoxAdapter(
        child: StreamBuilder<ApiState<List<OfferMapper>>>(
          stream: widget.homeBloc.offersStream,
          builder: (context, snapshot) {
            if (snapshot.hasData &&
                snapshot.data != null &&
                snapshot.data!.response != null) {
              if (snapshot.data!.response!.isNotEmpty) {
                return SizedBox(height: 11.h);
              } else {
                return SizedBox();
              }
            } else {
              return SizedBox();
            }
          },
        ),
      ),
      SliverToBoxAdapter(
        child: OffersListingWidget(
          homeBloc: widget.homeBloc,
          isMainPage: false,
        ),
      ),
      SliverToBoxAdapter(child: SizedBox(height: 20.h)),
      SliverToBoxAdapter(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: CustomText(
            text: S.of(context).browseSections,
            customTextStyle: BoldStyle(color: secondaryColor, fontSize: 20.sp),
          ),
        ),
      ),
      SliverToBoxAdapter(child: SizedBox(height: 16.h)),
      SliverToBoxAdapter(
        child: CategoryWidget(
          homeBloc: widget.homeBloc,
          scrollController: _scrollController,
        ),
      ),
      SliverToBoxAdapter(child: SizedBox(height: 16.h)),
      SliverToBoxAdapter(child: _mostSellingProducts()),
    ],
  );

  Widget _mostSellingProducts() {
    return StreamBuilder<ApiState<List<ProductMapper>>>(
      stream: getIt<MostSellingBloc>().mostSellingBehaviour.stream,
      initialData: LoadingState(),
      builder: (context, snapshot) {
        if ((snapshot.hasData &&
            snapshot.data!.response != null &&
            snapshot.data!.response!.isEmpty)) {
          return SizedBox(height: 90.h);
        }
        if (snapshot.data is FailedState) {
          return SizedBox();
        }

        return NewSectionWidget(
          title: "الأكثر طلباً",
          child: checkResponseStateWithLoadingWidget(
            onSuccessFunction: () {},
            snapshot.data ?? LoadingState<List<ProductMapper>>(),
            context,
            onSuccess: ProductListWidget(
              scrollPhysics: NeverScrollableScrollPhysics(),
              isForFavourite: false,
              deleteIcon: Assets.svg.icDelete,
              emptyFavouriteScreen: Assets.svg.emptyFavourite,
              cartBloc: widget.cartBloc,
              productCategoryBloc: getIt<ProductCategoryBloc>(),
              productList: snapshot.data?.response ?? [],
              isHorizontalListView: true,
              favouriteIcon: Assets.svg.icFavourite,
              favouriteIconFilled: Assets.svg.icFavouriteFilled,
              onTapFavourite: (favourite, productMapper) {},
              loadMore: (Function func) {
                // _loadProducts(false, func);
              },
            ),
          ),
          onViewAllTapped: () {
            Routes.navigateToScreen(
              Routes.mostSellingPage,
              NavigationType.goNamed,
              context,
              setBottomNavigationTab: true,
            );
          },
        );
      },
    );
  }

  Widget _recommendedProducts() {
    return StreamBuilder<ApiState<List<ProductMapper>>>(
      stream: getIt<RecommendedItemsBloc>().recommendedItemsBehaviour.stream,
      initialData: LoadingState(),
      builder: (context, snapshot) {
        // if ((snapshot.hasData &&
        //     snapshot.data!.response != null &&
        //     snapshot.data!.response!.isEmpty)) {
        //   return SizedBox(height: 0.h);
        // }
        // if (snapshot.data is FailedState) {
        //   return SizedBox();
        // }

        return NewSectionWidget(
          title: "خصيصاً لمتجرك",
          child: checkResponseStateWithLoadingWidget(
            onSuccessFunction: () {},
            snapshot.data ?? LoadingState<List<ProductMapper>>(),
            context,
            loadingWidget: RecommendedItemsSkeleton(),
            onSuccess: Padding(
              padding: const EdgeInsets.only(bottom: 28.0),
              child: SizedBox(
                height: 75.h,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: ListView.separated(
                        separatorBuilder: (context, index) {
                          return SizedBox(width: 10.w);
                        },
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data?.response?.length ?? 0,
                        itemBuilder: (context, index) {
                          return RecommendedItemWidget(
                            product: snapshot.data!.response![index],
                            isFirstItem: index == 0,
                            isLastItem:
                                index == snapshot.data!.response!.length - 1,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          onViewAllTapped: () {
            Routes.navigateToScreen(
              Routes.recommendedItemsPage,
              NavigationType.pushNamed,
              context,
              setBottomNavigationTab: true,
            );
          },
        );
      },
    );
  }

  Widget get _topWidget => AppTopWidget(
    notificationIcon: Assets.svg.icNotification,
    isHavingHomeLogo: true,
    isHavingSearch: true,
    isHavingSupport: true,
    scanIcon: Assets.svg.icScan,
    focusNode: _focusNode,
    searchIcon: Assets.svg.icSearch,
    onChanged: (value) {
      widget.homeBloc.searchBloc.updateStringBehaviour(value);
    },
    textFiledControllerStream: widget.homeBloc.searchBloc.textFormFiledStream,
    doSearch: () {
      widget.homeBloc.doSearch(widget.homeBloc.searchBloc.value, context);
      widget.homeBloc.searchBloc.textFormFiledBehaviour.sink.add(
        TextEditingController(text: ''),
      );
      widget.homeBloc.searchBloc.updateStringBehaviour('');
      FocusScope.of(context).requestFocus(new FocusNode());
      FirebaseAnalyticsUtil().logEvent(FirebaseAnalyticsEventsNames.search);
    },
  );

  @override
  Widget? customFloatActionButton() => FloatingActionButton(
    onPressed: () {
      _scrollController.jumpTo(0);
      FocusScope.of(context).requestFocus(_focusNode);
    },
    backgroundColor: secondaryColor,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.w)),
    child: ImageHelper(
      image: Assets.svg.icSearch,
      imageType: ImageType.svg,
      color: whiteColor,
      width: 26.w,
      height: 26.h,
    ),
  );

  @override
  void dispose() {
    widget.homeBloc.searchBloc.textFormFiledBehaviour.sink.add(
      TextEditingController(text: ''),
    );
    widget.homeBloc.searchBloc.updateStringBehaviour('');
    _scrollController.dispose();
    _focusNode.dispose();
    super.dispose();
  }
}
