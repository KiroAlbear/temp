import 'package:deel/core/ui/not_logged_in_widget.dart';
import 'package:deel/deel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_loader/image_helper.dart';

import '../../../../core/generated/l10n.dart';

class ProductCategoryPage extends BaseStatefulWidget {
  final HomeBloc homeBloc;
  final ContactUsBloc contactUsBloc;
  static int cateogryId = 1;
  static int categoryProductsCount = 0;
  static const String filterAllText = "All";

  final ProductCategoryBloc productCategoryBloc;
  final CartBloc cartBloc;
  ValueNotifier<int> selectedCategoryIndex = ValueNotifier(0);
  ValueNotifier<int> selectedBrandIndex = ValueNotifier(0);
  ValueNotifier<bool> showOverlayLoading = ValueNotifier(false);

  static final String isForFavouriteKey = 'isForFavouriteKey';
  static final String isFavouriteValue = 'isFavouriteValue';
  static final String isNotFavouriteValue = 'isNotFavouriteValue';
  final bool isForFavourite;

  ProductCategoryPage(
      {super.key,
      required this.homeBloc,
      required this.contactUsBloc,
      required this.productCategoryBloc,
      required this.cartBloc,
      required this.isForFavourite});

  @override
  State<ProductCategoryPage> createState() => _ProductCategoryWidgetState();
}

class _ProductCategoryWidgetState extends BaseState<ProductCategoryPage> {
  final double filterHorizontalPadding = 15.h;

  @override
  PreferredSizeWidget? appBar() => null;

  @override
  bool canPop() {
    return false;
  }

  @override
  void onPopInvoked(didPop) {
    ProductCategoryPage.cateogryId = 1;
    widget.productCategoryBloc.categoryId = 1;
    widget.productCategoryBloc.isNavigatingFromMore = false;
    widget.homeBloc.selectedOffer = null;
    changeSystemNavigationBarColor(secondaryColor);
    super.onPopInvoked(didPop);
  }

  @override
  bool isSafeArea() => true;

  @override
  bool isBottomSafeArea() => false;

  @override
  Color? systemNavigationBarColor() {
    return secondaryColor;
  }

  @override
  void initState() {
    if (widget.productCategoryBloc.isNavigationFromNotifications) {
      widget.productCategoryBloc.getProductWithSubcategoryBrand(
          widget.productCategoryBloc.categoryId, null, null);
    } else {
      if (widget.homeBloc.selectedOffer != null) {
        if (widget.homeBloc.selectedOffer!.link.toLowerCase().trim() ==
            "category") {
          widget.productCategoryBloc.categoryId =
              widget.homeBloc.selectedOffer!.relatedItemId[0];
          widget.productCategoryBloc.getProductWithSubcategoryBrand(
              widget.productCategoryBloc.categoryId, null, null);
        } else if (widget.homeBloc.selectedOffer!.link.toLowerCase().trim() ==
            "product") {
          widget.productCategoryBloc
              .getProductById(widget.homeBloc.selectedOffer!.relatedItemId[0]);
        } else if (widget.homeBloc.selectedOffer!.link.toLowerCase().trim() ==
            "brand") {
          widget.productCategoryBloc.brandId =
              widget.homeBloc.selectedOffer!.relatedItemId[0];
          widget.productCategoryBloc
              .getProductsByBrandId(widget.productCategoryBloc.brandId!);
        }
      } else if (ProductCategoryPage.categoryProductsCount > 0) {
        widget.productCategoryBloc.getProductWithSubcategoryBrand(
            ProductCategoryPage.cateogryId, null, null);
      } else {
        widget.productCategoryBloc.categoryId = ProductCategoryPage.cateogryId;
        widget.productCategoryBloc.isLoading = widget.showOverlayLoading;
        // widget.productCategoryBloc.reset();

        widget.productCategoryBloc.loadMore(widget.isForFavourite, null);
      }
    }

    super.initState();
  }

  @override
  void dispose() {
    widget.homeBloc.reset();
    widget.productCategoryBloc.disposeReset();
    super.dispose();
  }

  void _loadProducts(bool isFirstTime, Function? onGettingProducts) {
    widget.showOverlayLoading.value = isFirstTime;
    widget.productCategoryBloc.getProductWithSubcategoryBrand(
        widget.productCategoryBloc.subcategoryId,
        widget.productCategoryBloc.brandId,
        onGettingProducts);
  }

  bool isFavouriteOrSearchOrCategory() {
    return widget.isForFavourite ||
        ProductCategoryBloc.searchValue != null ||
        ProductCategoryPage.categoryProductsCount > 0;
  }

  bool isNavigatedFromBannersOrOffers() {
    return (widget.homeBloc.isBanner == true ||
        widget.homeBloc.selectedOffer != null);
  }

  final double topPadding = 90.h;

  bool isBannersOrOffersExist() {
    return (widget.homeBloc.isBanner == true &&
            widget.homeBloc.selectedOffer != null) ||
        (widget.homeBloc.isBanner == false &&
            widget.homeBloc.selectedOffer != null);
  }

  @override
  Widget getBody(BuildContext context) => ((SharedPrefModule().userId ?? '')
              .isEmpty &&
          widget.isForFavourite)
      ? NotLoggedInWidget(
          title: S.of(context).favourite,
          image: Assets.svg.imgGuestFavourite,
          imageType: ImageType.svg,
        )
      : Column(
          children: [
            AppTopWidget(
              notificationIcon: Assets.svg.icNotification,
              scanIcon: Assets.svg.icScan,
              searchIcon: Assets.svg.icSearch,
              isHavingSupport: true,
              onBackPressed: () {
                if (Navigator.canPop(context)) {
                  Navigator.pop(context);
                } else {
                  Routes.navigateToScreen(
                      Routes.homePage, NavigationType.goNamed, context);
                }
              },
              doSearch: () => widget.homeBloc
                  .doSearch(widget.homeBloc.searchBloc.value, context),
              textFiledControllerStream:
                  widget.homeBloc.searchBloc.textFormFiledStream,
              onChanged: (value) =>
                  widget.homeBloc.searchBloc.updateStringBehaviour(value),
              isHavingBack: (widget.isForFavourite &&
                      widget.productCategoryBloc.isNavigatingFromMore == false)
                  ? false
                  : true,
              title: isNavigatedFromBannersOrOffers()
                  ? " "
                  : widget.isForFavourite
                      ? S.of(context).favourites
                      : widget.homeBloc.selectedCategoryText,
            ),
            Expanded(
              child: Stack(
                children: [
                  Column(
                    children: [
                      (isFavouriteOrSearchOrCategory() ||
                              widget.homeBloc.selectedOffer != null ||
                              widget.productCategoryBloc
                                  .isNavigationFromNotifications)
                          ? SizedBox()
                          : StreamBuilder<ApiState<List<CategoryMapper>>>(
                              stream: widget.productCategoryBloc
                                  .subCategoryByCategoryStream,
                              builder: (context, snapshot) {
                                return !snapshot.hasData
                                    ? Container()
                                    : SizedBox(
                                        height: 40.h,
                                        child: ValueListenableBuilder<int>(
                                          valueListenable:
                                              widget.selectedCategoryIndex,
                                          builder: (context, value, child) {
                                            return (!snapshot.hasData ||
                                                    snapshot.data == null ||
                                                    snapshot.data?.response ==
                                                        null)
                                                ? Container()
                                                : Padding(
                                                    padding: EdgeInsets.symmetric(
                                                        horizontal:
                                                            filterHorizontalPadding),
                                                    child: Row(
                                                      children: [
                                                        Expanded(
                                                          child: ListView
                                                              .separated(
                                                            separatorBuilder:
                                                                (context,
                                                                        index) =>
                                                                    SizedBox(
                                                                        width: 8
                                                                            .w),
                                                            scrollDirection:
                                                                Axis.horizontal,
                                                            shrinkWrap: true,
                                                            itemCount: snapshot
                                                                .data!
                                                                .response!
                                                                .length,
                                                            itemBuilder:
                                                                (context,
                                                                    index) {
                                                              return FilterItemWidget(
                                                                  title: snapshot
                                                                              .data!
                                                                              .response![
                                                                                  index]
                                                                              .name ==
                                                                          ProductCategoryPage
                                                                              .filterAllText
                                                                      ? S
                                                                          .of(
                                                                              context)
                                                                          .productsFilterAll
                                                                      : snapshot
                                                                          .data!
                                                                          .response![
                                                                              index]
                                                                          .name,
                                                                  textColor:
                                                                      secondaryColor,
                                                                  withBorders:
                                                                      false,
                                                                  isSelected:
                                                                      index ==
                                                                          value,
                                                                  onTap: () {
                                                                    widget
                                                                        .productCategoryBloc
                                                                        .reset();
                                                                    widget.selectedCategoryIndex
                                                                            .value =
                                                                        index;
                                                                    widget.productCategoryBloc
                                                                            .subcategoryId =
                                                                        snapshot
                                                                            .data!
                                                                            .response![index]
                                                                            .id;

                                                                    widget.productCategoryBloc.getBrandBy(widget
                                                                            .productCategoryBloc
                                                                            .subcategoryId ??
                                                                        widget
                                                                            .productCategoryBloc
                                                                            .categoryId);
                                                                    widget
                                                                        .selectedBrandIndex
                                                                        .value = 0;
                                                                  },
                                                                  imageUrl: index ==
                                                                          0
                                                                      ? null
                                                                      : snapshot
                                                                          .data!
                                                                          .response![
                                                                              index]
                                                                          .image);
                                                            },
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                          },
                                        ),
                                      );
                              },
                            ),
                      (isFavouriteOrSearchOrCategory() ||
                              widget.homeBloc.selectedOffer != null ||
                              widget.productCategoryBloc
                                  .isNavigationFromNotifications)
                          ? SizedBox()
                          : SizedBox(
                              height: 14.h,
                            ),
                      (isFavouriteOrSearchOrCategory() ||
                              widget.homeBloc.selectedOffer != null ||
                              widget.productCategoryBloc
                                  .isNavigationFromNotifications)
                          ? SizedBox()
                          : StreamBuilder<ApiState<List<BrandMapper>>>(
                              stream: widget
                                  .productCategoryBloc.brandBySubcategoryStream,
                              builder: (context, snapshot) {
                                return !snapshot.hasData
                                    ? Container()
                                    : Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal:
                                                filterHorizontalPadding),
                                        child: SizedBox(
                                          height: 30.h,
                                          child: ValueListenableBuilder<int>(
                                            valueListenable:
                                                widget.selectedBrandIndex,
                                            builder: (context, value, child) {
                                              return Row(
                                                children: [
                                                  Expanded(
                                                    child: ListView.separated(
                                                      separatorBuilder:
                                                          (context, index) =>
                                                              SizedBox(
                                                                  width: 8.w),
                                                      scrollDirection:
                                                          Axis.horizontal,
                                                      shrinkWrap: true,
                                                      itemCount: snapshot
                                                              .data
                                                              ?.response
                                                              ?.length ??
                                                          0,
                                                      itemBuilder:
                                                          (context, index) {
                                                        return FilterItemWidget(
                                                            title: snapshot
                                                                        .data!
                                                                        .response![
                                                                            index]
                                                                        .name ==
                                                                    ProductCategoryPage
                                                                        .filterAllText
                                                                ? S
                                                                    .of(context)
                                                                    .productsFilterAll
                                                                : snapshot
                                                                    .data!
                                                                    .response![
                                                                        index]
                                                                    .name,
                                                            withBorders: true,
                                                            isSelected:
                                                                index == value,
                                                            onTap: () {
                                                              widget
                                                                  .productCategoryBloc
                                                                  .reset();
                                                              widget
                                                                  .selectedBrandIndex
                                                                  .value = index;
                                                              widget.productCategoryBloc
                                                                      .brandId =
                                                                  snapshot
                                                                      .data!
                                                                      .response![
                                                                          index]
                                                                      .id;

                                                              _loadProducts(
                                                                  true, null);
                                                            });
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              );
                                            },
                                          ),
                                        ),
                                      );
                              },
                            ),
                      (isFavouriteOrSearchOrCategory() ||
                              widget.homeBloc.selectedOffer != null)
                          ? SizedBox()
                          : SizedBox(
                              height: 10.h,
                            ),
                      isBannersOrOffersExist()
                          ? SizedBox()
                          : SizedBox(height: widget.isForFavourite ? 0 : 10.h),
                      Expanded(
                        child: CustomScrollView(
                          slivers: [
                            SliverToBoxAdapter(
                              child: (widget.homeBloc.isBanner == true &&
                                      widget.homeBloc.selectedOffer != null)
                                  ? Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: HeroBannerItem(
                                        item: widget.homeBloc.selectedOffer!,
                                        homeBloc: widget.homeBloc,
                                        isMainPage: true,
                                        isClickable: false,
                                      ),
                                    )
                                  : SizedBox(),
                            ),
                            SliverToBoxAdapter(
                              child: (widget.homeBloc.isBanner == false &&
                                      widget.homeBloc.selectedOffer != null)
                                  ? Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: OfferItem(
                                        isInProductPage: true,
                                        isMainPage: true,
                                        item: widget.homeBloc.selectedOffer!,
                                        homeBloc: widget.homeBloc,
                                        isClickable: false,
                                      ),
                                    )
                                  : SizedBox(),
                            ),
                            SliverToBoxAdapter(
                              child: isBannersOrOffersExist()
                                  ? Padding(
                                      padding: EdgeInsetsDirectional.only(
                                          start: 15, top: 5),
                                      child: CustomText(
                                        text: S.of(context).promoItems,
                                        textAlign: TextAlign.start,
                                        customTextStyle: BoldStyle(
                                            color: secondaryColor,
                                            fontSize: 18.sp),
                                      ),
                                    )
                                  : SizedBox(),
                            ),
                            SliverFillRemaining(
                              hasScrollBody: true,
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16.w,
                                    vertical: widget.isForFavourite ? 0 : 18.h),
                                child: StreamBuilder<
                                    ApiState<List<ProductMapper>>>(
                                  stream: widget
                                      .productCategoryBloc.loadedListStream,
                                  initialData: LoadingState(),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      if (snapshot.data!.response != null &&
                                          snapshot.data!.response!.isEmpty) {
                                        if (widget.isForFavourite) {
                                          return EmptyFavouriteProducts(
                                              emptyFavouriteScreen:
                                                  Assets.svg.emptyFavourite);
                                        } else {
                                          return Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            children: [
                                              ImageHelper(
                                                image: Assets.svg.icNotFound,
                                                imageType: ImageType.svg,
                                              ),
                                            ],
                                          );
                                        }
                                      }
                                    }
                                    return checkResponseStateWithLoadingWidget(
                                        onSuccessFunction: () {},
                                        snapshot.data ??
                                            LoadingState<List<ProductMapper>>(),
                                        context,
                                        onSuccess: ProductListWidget(
                                          isForFavourite: widget.isForFavourite,
                                          deleteIcon: Assets.svg.icDelete,
                                          emptyFavouriteScreen:
                                              Assets.svg.emptyFavourite,
                                          cartBloc: widget.cartBloc,
                                          productCategoryBloc:
                                              widget.productCategoryBloc,
                                          productList:
                                              snapshot.data?.response ?? [],
                                          favouriteIcon: Assets.svg.icFavourite,
                                          favouriteIconFilled:
                                              Assets.svg.icFavouriteFilled,
                                          onAddToCart: (productMapper) {
                                            widget.showOverlayLoading.value =
                                                true;
                                            widget.cartBloc
                                                .saveToCart(
                                                    productMapper.id,
                                                    productMapper.minQuantity ==
                                                            0
                                                        ? 1
                                                        : productMapper
                                                            .minQuantity
                                                            .toInt())
                                                .listen((event) {
                                              if (event is SuccessState) {
                                                widget.cartBloc.orderId =
                                                    event.response!;
                                                SharedPrefModule().orderId =
                                                    event.response!;
                                                widget.cartBloc.getMyCart(
                                                  onGettingCart: () {
                                                    widget.showOverlayLoading
                                                        .value = false;
                                                    widget.cartBloc
                                                        .addCartInfoToProducts(
                                                            snapshot.data
                                                                    ?.response ??
                                                                []);
                                                  },
                                                );
                                              }
                                            });
                                          },
                                          onDeleteClicked: (productMapper) {
                                            widget.showOverlayLoading.value =
                                                true;
                                            CartCommonFunctions()
                                                .editCart(
                                              cartBloc: widget.cartBloc,
                                              cartItemId:
                                                  productMapper.productId,
                                              productId: productMapper.id,
                                              quantity: 0,
                                              price: productMapper.finalPrice,
                                              state: CartState.decrement,
                                            )
                                                .listen((event) {
                                              if (event is SuccessState) {
                                                widget.cartBloc.getMyCart(
                                                  onGettingCart: () {
                                                    widget.showOverlayLoading
                                                        .value = false;
                                                    widget.cartBloc
                                                        .addCartInfoToProducts(
                                                            snapshot.data
                                                                    ?.response ??
                                                                []);
                                                    setState(() {});
                                                  },
                                                );
                                              }
                                            });
                                          },
                                          onDecrementClicked: (productMapper) {
                                            widget.showOverlayLoading.value =
                                                true;
                                            CartCommonFunctions()
                                                .editCart(
                                              cartBloc: widget.cartBloc,
                                              cartItemId:
                                                  productMapper.productId,
                                              productId: productMapper.id,
                                              quantity: productMapper
                                                  .cartUserQuantity,
                                              price: productMapper.finalPrice,
                                              state: CartState.decrement,
                                            )
                                                .listen((event) {
                                              if (event is SuccessState) {
                                                widget.showOverlayLoading
                                                    .value = false;
                                              }
                                            });
                                          },
                                          onIncrementClicked: (productMapper) {
                                            widget.showOverlayLoading.value =
                                                true;
                                            CartCommonFunctions()
                                                .editCart(
                                              cartBloc: widget.cartBloc,
                                              cartItemId:
                                                  productMapper.productId,
                                              productId: productMapper.id,
                                              quantity: productMapper
                                                  .cartUserQuantity,
                                              price: productMapper.finalPrice,
                                              state: CartState.increment,
                                            )
                                                .listen((event) {
                                              if (event is SuccessState) {
                                                if (productMapper
                                                        .cartUserQuantity ==
                                                    1) {
                                                  widget.cartBloc
                                                      .addCartInfoToProducts(
                                                          snapshot.data
                                                                  ?.response ??
                                                              []);
                                                }
                                                widget.showOverlayLoading
                                                    .value = false;
                                              }
                                            });
                                          },
                                          onTapFavourite:
                                              (favourite, productMapper) {},
                                          loadMore: (Function func) {
                                            if (widget.isForFavourite)
                                              widget.productCategoryBloc
                                                  .loadMore(true, func);
                                            else
                                              _loadProducts(false, func);
                                          },
                                        ));
                                  },
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: OverlayLoadingWidget(
                      showOverlayLoading: widget.showOverlayLoading,
                    ),
                  ),
                ],
              ),
            )
          ],
        );
}
