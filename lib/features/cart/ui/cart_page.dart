import 'dart:async';

import 'package:deel/deel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_loader/image_helper.dart';

class CartPage extends BaseStatefulWidget {
  final CartBloc cartBloc;

  final ProductCategoryBloc productCategoryBloc;

  const CartPage({
    required this.cartBloc,
    required this.productCategoryBloc,
    super.key,
  });

  @override
  State<CartPage> createState() => _CartScreenState();
}

class _CartScreenState extends BaseState<CartPage> {
  ValueNotifier<bool> isLoading = ValueNotifier(false);
  ValueNotifier<bool> isUndoVisible = ValueNotifier(false);
  Timer? _undoHideTimer;

  @override
  PreferredSizeWidget? appBar() => null;

  @override
  bool canPop() => false;

  @override
  bool isSafeArea() => true;

  @override
  Color? statusBarColor() => Colors.white;

  @override
  Color? systemNavigationBarColor() => secondaryColor;

  @override
  void onPopInvoked(didPop) {
    Routes.navigateToScreen(Routes.homePage, NavigationType.goNamed, context);
  }

  @override
  void initState() {
    widget.cartBloc.getPaymentVisibility();
    widget.cartBloc.getMyCart();
    super.initState();
  }

  @override
  void dispose() {
    _undoHideTimer?.cancel();
    isLoading.dispose();
    isUndoVisible.dispose();
    super.dispose();
  }

  @override
  Widget getBody(BuildContext context) {
    return (SharedPrefModule().userId ?? '').isEmpty
        ? NotLoggedInWidget(
            title: Loc.of(context)!.cartTitle,
            imageVariant: NotLoggedInImageVariant.cart,
          )
        : Column(
            children: [
              AppTopWidget(
                title: Loc.of(context)!.cartTitle,
                isHavingSupport: true,
              ),
              Expanded(
                child: Stack(
                  children: [
                    StreamBuilder(
                      stream: widget.cartBloc.cartProductsBehavior.stream,
                      builder: (context, snapshot) {
                        if (snapshot.data == null) {
                          return Container();
                        } else {
                          return checkResponseStateWithLoadingWidget(
                            snapshot.data!,
                            context,
                            onSuccess:
                                snapshot.data!.response?.getFirst.isEmpty ??
                                    true
                                ? const CartEmptyWidget()
                                : SizedBox.expand(
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        _cartHeader(context),
                                        16.verticalSpace,
                                        Expanded(
                                          child: Stack(
                                            children: [
                                              _productList(),
                                              ValueListenableBuilder<bool>(
                                                valueListenable: isUndoVisible,
                                                builder: (context, visible, _) {
                                                  if (!visible) {
                                                    return const SizedBox.shrink();
                                                  }
                                                  return Positioned(
                                                    bottom: 0,
                                                    left: 10,
                                                    right: 10,
                                                    child: _undoWidget(context),
                                                  );
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                        _bottomWidget(context),
                                      ],
                                    ),
                                ),
                          );
                        }
                      },
                    ),
                    OverlayLoadingWidget(showOverlayLoading: isLoading),
                  ],
                ),
              ),
            ],
          );
  }

  Widget _undoWidget(BuildContext context) {
    return Card(
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4.r),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                ImageHelper(
                  image: Assets.svg.icDelete,
                  imageType: ImageType.svg,
                  color: secondaryColor,
                ),
                8.horizontalSpace,
                CustomText(
                  text: Loc.of(context)!.cartProductRemovedFromCart,
                  customTextStyle: RegularStyle(fontSize: 12.sp, color: black),
                ),
              ],
            ),
            InkWell(
              onTap: () {
                _hideUndoWidget();
                if (widget.cartBloc.lastDeletedProduct != null) {
                  isLoading.value = true;
                  widget.cartBloc.onAddToCart(
                    widget.cartBloc.lastDeletedProduct!,
                    widget.productCategoryBloc.loadedListBehaviour.value.response,
                    () {
                      isLoading.value = false;
                    },
                  );
                }
              },
              child: Text(
                Loc.of(context)!.cartAddAgain,
                style: BoldStyle(
                  fontSize: 12.sp,
                  color: secondaryColor,
                ).getStyle().copyWith(decoration: TextDecoration.underline),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _seperator() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Divider(
        color: lightGreyColorLightMode,
        thickness: 0.5,
        height: 24.h,
      ),
    );
  }

  Widget _bottomCalculationsWidget(String title, String value, {Color? color}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 4.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 20,
            child: CustomText(
              text: title,
              customTextStyle: MediumStyle(
                color: greyOrderGreyTextColorLightMode,
                fontSize: 14.sp,
              ),
            ),
          ),
          Expanded(
            flex: 7,
            child: CustomText(
              text: value,
              customTextStyle: RegularStyle(
                color: color ?? black,
                fontSize: 14.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _bottomTotalWidget(String title, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 0.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 20,
            child: CustomText(
              text: title,
              customTextStyle: BoldStyle(
                color: secondaryColor,
                fontSize: 16.sp,
              ),
            ),
          ),
          Expanded(
            flex: 7,
            child: CustomText(
              text: value,
              customTextStyle: BoldStyle(
                color: secondaryColor,
                fontSize: 16.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container _bottomWidget(BuildContext context) {
    return Container(
      color: whiteColor,
      child: Padding(
        padding: EdgeInsetsDirectional.only(
          start: 16.w,
          end: 16.w,
          top: 4.h,
          bottom: 26.h,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _seperator(),
            StreamBuilder(
              stream: widget.cartBloc.cartTotalBeforeDiscountBehaviour.stream,
              builder: (context, snapshot) {
                return _bottomCalculationsWidget(
                  Loc.of(context)!.totalBeforeDiscount,
                  snapshot.data ?? '',
                );
              },
            ),
            StreamBuilder(
              stream: widget.cartBloc.cartTotaDiscountStringBehaviour.stream,
              builder: (context, snapshot) {
                return (snapshot.hasData == false || snapshot.data == "")
                    ? const SizedBox()
                    : _bottomCalculationsWidget(
                        Loc.of(context)!.totalDiscount,
                        snapshot.data ?? '',
                        color: redColor,
                      );
              },
            ),
            StreamBuilder(
              stream: widget.cartBloc.cartTotalDeliveryStringBehaviour.stream,
              builder: (context, snapshot) {
                return _bottomCalculationsWidget(
                  Loc.of(context)!.deliveryFees,
                  snapshot.data ?? '',
                );
              },
            ),
            _seperator(),
            StreamBuilder(
              stream: widget.cartBloc.cartTotalAfterDiscountBehaviour.stream,
              builder: (context, snapshot) {
                return _bottomTotalWidget(
                  Loc.of(context)!.total,
                  snapshot.data ?? '',
                );
              },
            ),
            SizedBox(height: 12.h),
            CustomButtonWidget(
              width: 200.w,
              height: 48.h,
              borderRadius: 8,
              idleText: Loc.of(context)!.next,
              textStyle: MediumStyle(
                color: secondaryColor,
                fontSize: 16.sp,
              ).getStyle(),
              onTap: () async {
                if (widget.cartBloc.totalSum <=
                    widget.cartBloc.cartMinimumOrderBehaviour.value) {
                  AlertModule().showMessage(
                    context: context,
                    message:
                        "${Loc.of(context)!.cartMinimumOrder} ${widget.cartBloc.cartMinimumOrderBehaviour.value} ${widget.cartBloc.cartMinimumOrderCurrencyBehaviour.value}.",
                  );
                } else if (widget.cartBloc.isAnyProductOutOfStock) {
                  AlertModule().showMessage(
                    context: context,
                    message: Loc.of(context)!.cartProductsNotAvailable,
                  );
                } else if (widget
                    .cartBloc
                    .productsOfMoreThanAvailable
                    .isNotEmpty) {
                  AlertModule().showMessage(
                    context: context,
                    message:
                        "${widget.cartBloc.productsOfMoreThanAvailable.first.name} ${Loc.of(context)!.cartProductQuantityNotAvailable} ${widget.cartBloc.productsOfMoreThanAvailable.first.quantity}.",
                  );
                } else {
                  showModalBottomSheet(
                    barrierColor: bottomSheetBarrierColor,
                    backgroundColor: whiteColor,
                    useRootNavigator: true,
                    isScrollControlled: false,
                    useSafeArea: true,
                    context: context,
                    builder: (context) {
                      return CartBottomSheet(cartBloc: widget.cartBloc);
                    },
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _productList() {
    return StreamBuilder(
      stream: widget.cartBloc.cartProductsBehavior.stream,
      builder: (context, snapshot) {
        return !snapshot.hasData
            ? const SizedBox()
            : ListView.separated(
              separatorBuilder: (context, index) => 16.verticalSpace,
              shrinkWrap: true,
              itemCount: snapshot.data!.response!.getFirst.length,
              padding: EdgeInsets.zero,
              itemBuilder: (context, index) {
                return ProductWidget(
                  isCartProduct: true,
                  index: index,
                  productMapper: snapshot.data!.response!.getFirst[index],
                  productCategoryBloc: widget.productCategoryBloc,
                  onDecrementClicked: (ProductMapper productMapper) {
                    isLoading.value = true;
                    widget.cartBloc.onDecrementIncrement(productMapper, widget.productCategoryBloc.loadedListBehaviour.value.response, () {
                      isLoading.value = false;
                    });
                  },
                  onIncrementClicked: (productMapper) {
                    isLoading.value = true;
                    widget.cartBloc.onDecrementIncrement(productMapper, widget.productCategoryBloc.loadedListBehaviour.value.response, () {
                      isLoading.value = false;
                    });
                  },
                  onDeleteClicked: (productMapper) {
                    isLoading.value = true;
                    widget.cartBloc.onDeleteFromCart(
                      productMapper,
                      widget.productCategoryBloc.loadedListBehaviour.value.response,
                      () {
                        isLoading.value = false;
                        _showUndoWidgetFor3Seconds();
                      },
                    );
                  },
                );
              },
            );
      },
    );
  }

  void _showUndoWidgetFor3Seconds() {
    isUndoVisible.value = true;
    _undoHideTimer?.cancel();
    _undoHideTimer = Timer(const Duration(seconds: 3), _hideUndoWidget);
  }

  void _hideUndoWidget() {
    _undoHideTimer?.cancel();
    isUndoVisible.value = false;
  }

  void _deleteAllCart() {
    final List<ProductMapper> products =
        widget.cartBloc.cartProductsBehavior.value.response?.getFirst ?? [];

    isLoading.value = true;
    widget.cartBloc.onDeleteProductListFromCart(
      productMappers: products,
      onGettingCart: (products) {
        isLoading.value = false;
      },
    );
  }

  void _showDeleteAllConfirmation() async {
    await showModalBottomSheet(
      context: Routes.rootNavigatorKey.currentContext!,
      isScrollControlled: false,
      useRootNavigator: true,
      useSafeArea: true,
      builder: (context2) {
        return DialogWidget(
          message: Loc.of(context)!.cartRemoveAllProductsConfirmation,
          cancelMessage: "${Loc.of(context)!.no}, ${Loc.of(context)!.cancel}",
          confirmMessage:
              "${Loc.of(context)!.yes}, ${Loc.of(context)!.cartRemoveAllProducts}",
          onConfirm: () {
            _deleteAllCart();
          },
        );
      },
    );
  }

  Widget _cartHeader(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            text: Loc.of(context)!.cartProductDetails,
            customTextStyle: BoldStyle(color: secondaryColor, fontSize: 18.sp),
          ),
          10.verticalSpace,
          StreamBuilder(
            stream: widget.cartBloc.cartMinimumOrderBehaviour.stream,
            builder: (context, snapshot) {
              return (snapshot.hasData && snapshot.data != null)
                  ? Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: redColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 5.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomText(
                              text: "${Loc.of(context)!.cartMinimumOrder} ",
                              textAlign: TextAlign.center,
                              customTextStyle: RegularStyle(
                                color: whiteColor,
                                fontSize: 12.sp,
                              ),
                            ),
                            CustomText(
                              text:
                                  "${snapshot.data.toString()} ${widget.cartBloc.cartMinimumOrderCurrencyBehaviour.value}.",
                              textAlign: TextAlign.center,
                              customTextStyle: BoldStyle(
                                color: whiteColor,
                                fontSize: 12.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : const SizedBox();
            },
          ),
          16.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                onTap: () async {
                  _showDeleteAllConfirmation();
                },
                child: Text(
                  Loc.of(context)!.cartRemoveAllProducts,
                  style: BoldStyle(
                    color: redColor,
                    fontSize: 14.sp,
                  ).getStyle().copyWith(decoration: TextDecoration.underline),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
