import 'package:deel/deel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_loader/image_helper.dart';

class HomePage extends BaseStatefulWidget {
  final HomeBloc homeBloc;
  final CartBloc cartBloc;
  final ProductCategoryBloc productCategoryBloc;

  final UpdateProfileBloc updateProfileBloc;
  final ContactUsBloc contactUsBloc;
  final ValueNotifier<bool> showOverlayLoading = ValueNotifier(false);

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

    if (SharedPrefModule().isLoggedIn ?? false) {
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
      _buildHeroBannerSpace(),
      SliverToBoxAdapter(child: HeroBannersWidget(homeBloc: widget.homeBloc)),
      _buildHeroBannerSpace(),
      (SharedPrefModule().isLoggedIn ?? false)
          ? SliverToBoxAdapter(child: _recommendedProducts())
          : SliverToBoxAdapter(child: SizedBox()),

      _buildOfferSpace(),

      SliverToBoxAdapter(
        child: OffersListingWidget(
          homeBloc: widget.homeBloc,
          isMainPage: false,
        ),
      ),
      _buildOfferSpace(),
      SliverToBoxAdapter(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: CustomText(
            text: Loc.of(context)!.browseSections,
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

  SliverToBoxAdapter _buildOfferSpace() {
    return SliverToBoxAdapter(
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
    );
  }

  Widget _buildHeroBannerSpace() {
    return SliverToBoxAdapter(
      child: StreamBuilder<ApiState<List<OfferMapper>>>(
        stream: widget.homeBloc.heroBannersStream,
        builder: (context, snapshot) =>
            (snapshot.hasData &&
                snapshot.data!.response != null &&
                snapshot.data!.response!.isEmpty)
            ? SizedBox(height: 0)
            : SizedBox(height: 10.h),
      ),
    );
  }

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
          title: Loc.of(context)!.mostSelling,
          child: checkResponseStateWithLoadingWidget(
            onSuccessFunction: () {},
            snapshot.data ?? LoadingState<List<ProductMapper>>(),
            context,
            onSuccess: ProductListWidget(
              scrollPhysics: NeverScrollableScrollPhysics(),
              isForFavourite: false,
              cartBloc: widget.cartBloc,
              productCategoryBloc: getIt<ProductCategoryBloc>(),
              productList: snapshot.data?.response ?? [],
              isHorizontalListView: true,
              onTapFavourite: (favourite, productMapper) {},
              loadMore: (Function func) {
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
        if ((snapshot.hasData &&
            snapshot.data!.response != null &&
            snapshot.data!.response!.isEmpty)) {
          return SizedBox(height: 0.h);
        }
        if (snapshot.data is FailedState) {
          return SizedBox();
        }

        return NewSectionWidget(
          title: Loc.of(context)!.recommendedForYourStore,
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
    isHavingHomeLogo: true,
    isHavingSearch: true,
    isHavingSupport: true,
    focusNode: _focusNode,
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
