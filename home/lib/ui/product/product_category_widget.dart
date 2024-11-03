import 'package:cart/ui/cart_bloc.dart';
import 'package:cart/utilities/cart_common_functions.dart';
import 'package:core/core.dart';
import 'package:core/dto/models/baseModules/api_state.dart';
import 'package:core/dto/models/brand/brand_mapper.dart';
import 'package:core/dto/models/home/category_mapper.dart';
import 'package:core/dto/models/product/product_mapper.dart';
import 'package:core/dto/modules/shared_pref_module.dart';
import 'package:core/generated/l10n.dart';
import 'package:core/ui/app_top_widget.dart';
import 'package:core/ui/bases/base_state.dart';
import 'package:core/ui/contactUs/contact_us_bloc.dart';
import 'package:core/ui/product/product_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:home/ui/home/filter_item_widget.dart';
import 'package:home/ui/home/home_bloc.dart';
import 'package:home/ui/home/offer_item.dart';
import 'package:home/ui/product/empty_favourite_products.dart';
import 'package:home/ui/product/product_category_bloc.dart';

import '../home/hero_banner_item.dart';

class ProductCategoryWidget extends BaseStatefulWidget {
  final String favouriteIcon;
  final String favouriteIconFilled;
  final String homeLogo;
  final String supportIcon;
  final String notificationIcon;
  final String scanIcon;
  final String searchIcon;
  final String deleteIcon;
  final String emptyFavouriteScreen;
  final String productNotFoundIcon;
  final HomeBloc homeBloc;
  final ContactUsBloc contactUsBloc;
  final String backIcon;
  static int cateogryId = 1;
  static int categoryProductsCount = 0;
  static const String filterAllText = "All";

  final ProductCategoryBloc productCategoryBloc;
  final CartBloc cartBloc;
  ValueNotifier<int> selectedCategoryIndex = ValueNotifier(0);
  ValueNotifier<int> selectedBrandIndex = ValueNotifier(0);
  // ValueNotifier<bool> isLoading = ValueNotifier(false);
  ValueNotifier<bool> showOverlayLoading = ValueNotifier(false);
  // bool isLoadingWidgetBuilt = false;

  ProductCategoryWidget(
      {super.key,
      required this.emptyFavouriteScreen,
      required this.favouriteIcon,
      required this.favouriteIconFilled,
      required this.backIcon,
      required this.homeBloc,
      required this.homeLogo,
      required this.notificationIcon,
      required this.scanIcon,
      required this.searchIcon,
      required this.deleteIcon,
      required this.supportIcon,
      required this.productNotFoundIcon,
      required this.cartBloc,
      required this.contactUsBloc,
      required this.productCategoryBloc});

  @override
  State<ProductCategoryWidget> createState() => _ProductCategoryWidgetState();
}

class _ProductCategoryWidgetState extends BaseState<ProductCategoryWidget> {
  @override
  PreferredSizeWidget? appBar() => null;

  @override
  bool canPop() {
    return (widget.productCategoryBloc.isForFavourite &&
            widget.productCategoryBloc.isNavigatingFromMore == false)
        ? false
        : true;
  }

  @override
  void onPopInvoked(didPop) {
    ProductCategoryWidget.cateogryId = 1;
    widget.productCategoryBloc.categoryId = 1;
    widget.productCategoryBloc.isNavigatingFromMore = false;
    widget.homeBloc.selectedOffer = null;
    widget.homeBloc.selectedOfferIndex = null;
    // widget.homeBloc.selectedOfferCategoryId = null;
    // widget.homeBloc.selectedOfferBrandId = null;
    // widget.homeBloc.selectedOfferProductId = null;
    super.onPopInvoked(didPop);
  }

  @override
  bool isSafeArea() => true;

  @override
  void initState() {
    if (widget.homeBloc.selectedOffer != null) {
      if (widget.homeBloc.selectedOffer!.link.toLowerCase().trim() ==
          "category") {
        widget.productCategoryBloc.categoryId =
            widget.homeBloc.selectedOffer!.relatedItemId;
        widget.productCategoryBloc.getProductWithSubcategoryBrand(
            widget.productCategoryBloc.categoryId, null, null);
      } else if (widget.homeBloc.selectedOffer!.link.toLowerCase().trim() ==
          "product") {
        widget.productCategoryBloc
            .getProductById(widget.homeBloc.selectedOffer!.relatedItemId);
      } else if (widget.homeBloc.selectedOffer!.link.toLowerCase().trim() ==
          "brand") {
        widget.productCategoryBloc.brandId =
            widget.homeBloc.selectedOffer!.relatedItemId;
        widget.productCategoryBloc.getProductWithSubcategoryBrand(
            null, widget.productCategoryBloc.brandId, null);
      }
    } else if (ProductCategoryWidget.categoryProductsCount > 0) {
      widget.productCategoryBloc.getProductWithSubcategoryBrand(
          ProductCategoryWidget.cateogryId, null, null);
    } else {
      widget.productCategoryBloc.categoryId = ProductCategoryWidget.cateogryId;
      widget.productCategoryBloc.isLoading = widget.showOverlayLoading;
      widget.productCategoryBloc.reset();
      widget.productCategoryBloc.loadMore();
    }

    // get arguments

    super.initState();
  }

  void _loadProducts(bool isFirstTime, Function? onGettingProducts) {
    widget.showOverlayLoading.value = isFirstTime;
    widget.productCategoryBloc.getProductWithSubcategoryBrand(
        widget.productCategoryBloc.subcategoryId,
        widget.productCategoryBloc.brandId,
        onGettingProducts);
  }

  bool isFavouriteOrSearchOrCategory() {
    return widget.productCategoryBloc.isForFavourite ||
        ProductCategoryBloc.searchValue != null ||
        ProductCategoryWidget.categoryProductsCount > 0;
  }

  bool isNavigatedFromBannersOrOffers() {
    return (widget.homeBloc.isBanner == true ||
        widget.homeBloc.selectedOffer != null);
  }

  final double topPadding = 110.h;
  @override
  Widget getBody(BuildContext context) => Stack(
        alignment: Alignment.topCenter,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Column(
                children: [
                  AppTopWidget(
                    notificationIcon: widget.notificationIcon,
                    homeLogo: widget.homeLogo,
                    scanIcon: widget.scanIcon,
                    searchIcon: widget.searchIcon,
                    supportIcon: widget.supportIcon,
                    contactUsBloc: widget.contactUsBloc,
                    doSearch: () => widget.homeBloc
                        .doSearch(widget.homeBloc.searchBloc.value),
                    textFiledControllerStream:
                        widget.homeBloc.searchBloc.textFormFiledStream,
                    onChanged: (value) =>
                        widget.homeBloc.searchBloc.updateStringBehaviour(value),
                    backIcon: (widget.productCategoryBloc.isForFavourite &&
                            widget.productCategoryBloc.isNavigatingFromMore ==
                                false)
                        ? ''
                        : widget.backIcon,
                    title: isNavigatedFromBannersOrOffers()
                        ? " "
                        : widget.productCategoryBloc.isForFavourite
                            ? S.of(context).favourites
                            : S.of(context).products,
                    hideTop: widget.productCategoryBloc.isForFavourite
                        ? true
                        : false,
                  ),
                ],
              ),
              Expanded(
                child: Stack(
                  children: [
                    Column(
                      children: [
                        SizedBox(
                          height: 10.h,
                        ),
                        widget.homeBloc.selectedOffer == null
                            ? SizedBox()
                            : SizedBox(
                                height: 50.h,
                              ),
                        (isFavouriteOrSearchOrCategory() ||
                                widget.homeBloc.selectedOffer != null)
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
                                              return !snapshot.hasData
                                                  ? Container()
                                                  : Row(
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
                                                                          ProductCategoryWidget
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
                                                                  isSelected:
                                                                      index ==
                                                                          value,
                                                                  onTap: () {
                                                                    widget.selectedCategoryIndex
                                                                            .value =
                                                                        index;
                                                                    widget.productCategoryBloc
                                                                            .subcategoryId =
                                                                        snapshot
                                                                            .data!
                                                                            .response![index]
                                                                            .id;
                                                                    widget
                                                                        .productCategoryBloc
                                                                        .reset();
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
                                                                  // imageUrl:
                                                                  imageUrl: snapshot
                                                                      .data!
                                                                      .response![
                                                                          index]
                                                                      .image);
                                                              // "https://lh3.googleusercontent.com/86arOE_jc_FYR6_mPbeXrzWB4LwvgCRWPGXbbftgG4_zAjY05ajbmq3xiG0Xc_uYCoTccikGvLdo5WIlofH5pmySn1VRejqngh2pwDLquiLJYayCOJKUrZKFnOwmSxKzQqqOM1y5o42TPk6LYR1vbPjrEPx3dQIUEwS4IPRjzt3JdPZT32TkqCECm-PoQtsBAPnyN6g46PbiyD9fblgzuBcT2xuO1AaZgOkR53bom8ATCBkDgcYT_mnsxWuxLGp6cNFUR4lWBFKyYkYJWJY--KmIVCWDDoJ3SxwjimGjwRG-X2Qu3AP4wa6tRazHuBo3a8IOofm6f5arSRdpVy4AaXoacTPz8TSkcofA0YaIttHpek1Gi5v1yMSbi5mHV6Mfv4lyczXPp8c5iNR7IFPvgMz1BiCETTxNwSvDjb2JCN94_256Fzejrs-Dk-kMYeCCYQh2Zd_lt9xiEQDgZ5gufdpxxM9xDiP447vrOqKbBMcAS_6hu43EwRi97ILAhBpS3QLP-4WhKf4GHauWqML_EcBvhszB-6T1iGeCWvpAT9jZVDVgekalBvLZiZNoy5Ow9QlnHA=w1827-h711-no-tmp.jpg");
                                                            },
                                                          ),
                                                        ),
                                                      ],
                                                    );
                                            },
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
                        (isFavouriteOrSearchOrCategory() ||
                                widget.homeBloc.selectedOffer != null)
                            ? SizedBox()
                            : StreamBuilder<ApiState<List<BrandMapper>>>(
                                stream: widget.productCategoryBloc
                                    .brandBySubcategoryStream,
                                builder: (context, snapshot) {
                                  return !snapshot.hasData
                                      ? Container()
                                      : SizedBox(
                                          height: 40.h,
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
                                                                    ProductCategoryWidget
                                                                        .filterAllText
                                                                ? S
                                                                    .of(context)
                                                                    .productsFilterAll
                                                                : snapshot
                                                                    .data!
                                                                    .response![
                                                                        index]
                                                                    .name,
                                                            isSelected:
                                                                index == value,
                                                            onTap: () {
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
                                                              widget
                                                                  .productCategoryBloc
                                                                  .reset();
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
                                        );
                                },
                              ),
                        (isFavouriteOrSearchOrCategory() ||
                                widget.homeBloc.selectedOffer != null)
                            ? SizedBox()
                            : SizedBox(
                                height: 10.h,
                              ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 16.w, vertical: 18.h),
                            child: StreamBuilder<ApiState<List<ProductMapper>>>(
                              stream:
                                  widget.productCategoryBloc.loadedListStream,
                              initialData: LoadingState(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  // handle empty states for both favourite and normal product
                                  if (snapshot.data!.response != null &&
                                      snapshot.data!.response!.isEmpty) {
                                    if (widget
                                        .productCategoryBloc.isForFavourite) {
                                      return EmptyFavouriteProducts(
                                          emptyFavouriteScreen:
                                              widget.emptyFavouriteScreen);
                                    } else {
                                      return Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          ImageHelper(
                                            image: widget.productNotFoundIcon,
                                            imageType: ImageType.svg,
                                          ),
                                        ],
                                      );
                                    }
                                  }
                                }
                                // if (widget.isLoadingWidgetBuilt) {
                                //   widget.isLoading.value = true;
                                // }

                                return checkResponseStateWithLoadingWidget(
                                    onSuccessFunction: () {},
                                    snapshot.data ??
                                        LoadingState<List<ProductMapper>>(),
                                    context,
                                    onSuccess: ProductListWidget(
                                      deleteIcon: widget.deleteIcon,
                                      emptyFavouriteScreen:
                                          widget.emptyFavouriteScreen,
                                      cartBloc: widget.cartBloc,
                                      productCategoryBloc:
                                          widget.productCategoryBloc,
                                      productList:
                                          snapshot.data?.response ?? [],
                                      favouriteIcon: widget.favouriteIcon,
                                      favouriteIconFilled:
                                          widget.favouriteIconFilled,
                                      onAddToCart: (productMapper) {
                                        widget.showOverlayLoading.value = true;
                                        widget.cartBloc
                                            .saveToCart(productMapper.id, 1)
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
                                        widget.showOverlayLoading.value = true;
                                        CartCommonFunctions()
                                            .editCart(
                                          cartBloc: widget.cartBloc,
                                          cartItemId: productMapper.productId,
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
                                        ;
                                      },
                                      onDecrementClicked: (productMapper) {
                                        widget.showOverlayLoading.value = true;

                                        CartCommonFunctions()
                                            .editCart(
                                          cartBloc: widget.cartBloc,
                                          cartItemId: productMapper.productId,
                                          productId: productMapper.id,
                                          quantity:
                                              productMapper.cartUserQuantity,
                                          price: productMapper.finalPrice,
                                          state: CartState.decrement,
                                        )
                                            .listen((event) {
                                          if (event is SuccessState) {
                                            // widget.cartBloc.getMyCart();
                                            // widget.cartBloc
                                            //     .addCartInfoToProducts(
                                            //         snapshot.data?.response ??
                                            //             []);
                                            widget.showOverlayLoading.value =
                                                false;
                                          }
                                        });
                                      },
                                      onIncrementClicked: (productMapper) {
                                        widget.showOverlayLoading.value = true;

                                        CartCommonFunctions()
                                            .editCart(
                                          cartBloc: widget.cartBloc,
                                          cartItemId: productMapper.productId,
                                          productId: productMapper.id,
                                          quantity:
                                              productMapper.cartUserQuantity,
                                          price: productMapper.finalPrice,
                                          state: CartState.increment,
                                        )
                                            .listen(
                                          (event) {
                                            if (event is SuccessState) {
                                              // widget.cartBloc.getMyCart();
                                              if (productMapper
                                                      .cartUserQuantity ==
                                                  1) {
                                                widget.cartBloc
                                                    .addCartInfoToProducts(
                                                        snapshot.data
                                                                ?.response ??
                                                            []);
                                              }

                                              widget.showOverlayLoading.value =
                                                  false;
                                            }
                                          },
                                        );
                                      },
                                      onTapFavourite:
                                          (favourite, productMapper) {
                                        // widget.productCategoryBloc.addProductToFavourite();
                                      },
                                      loadMore: (Function func) {
                                        if (widget
                                            .productCategoryBloc.isForFavourite)
                                          widget.productCategoryBloc.loadMore();
                                        else
                                          _loadProducts(false, func);
                                      },
                                    ));
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    ValueListenableBuilder(
                      valueListenable: widget.showOverlayLoading,
                      builder: (context, value, child) {
                        // widget.isLoadingWidgetBuilt = true;
                        return !value
                            ? SizedBox()
                            : Container(
                                color: Colors.black.withOpacity(0.3),
                              );
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
          (widget.homeBloc.isBanner == true &&
                  widget.homeBloc.selectedOffer != null)
              ? Padding(
                  padding: EdgeInsets.only(top: topPadding),
                  child: HeroBannerItem(
                    index: widget.homeBloc.selectedOfferIndex!,
                    item: widget.homeBloc.selectedOffer!,
                    homeBloc: widget.homeBloc,
                    isClickable: false,
                  ),
                )
              : SizedBox(),
          (widget.homeBloc.isBanner == false &&
                  widget.homeBloc.selectedOffer != null)
              ? Padding(
                  padding: EdgeInsets.only(top: topPadding),
                  child: OfferItem(
                    isInProductPage: true,
                    isMainPage: false,
                    index: widget.homeBloc.selectedOfferIndex!,
                    item: widget.homeBloc.selectedOffer!,
                    homeBloc: widget.homeBloc,
                    isClickable: false,
                  ),
                )
              : SizedBox()
        ],
      );
}
