import 'package:deel/core/ui/not_logged_in_widget.dart';
import 'package:deel/deel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_loader/image_helper.dart';

class CartPage extends BaseStatefulWidget {
  final CartBloc cartBloc;

  final ProductCategoryBloc productCategoryBloc;

  CartPage({
    required this.cartBloc,
    required this.productCategoryBloc,
    super.key,
  });

  @override
  State<CartPage> createState() => _CartScreenState();
}

class _CartScreenState extends BaseState<CartPage> {
  ValueNotifier<bool> isLoading = ValueNotifier(false);

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
    // super.onPopInvoked(didPop);
  }

  @override
  void initState() {
    widget.cartBloc.getMyCart();
    super.initState();
  }

  @override
  Widget getBody(BuildContext context) {
    return (SharedPrefModule().userId ?? '').isEmpty
        ? NotLoggedInWidget(
            title: Loc.of(context)!.cartTitle,
            image: Assets.png.icGuestCart.path,
            imageType: ImageType.asset,
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
                        if (snapshot.data == null)
                          return Container();
                        else
                          return checkResponseStateWithLoadingWidget(
                            snapshot.data!,
                            context,
                            onSuccess:
                                snapshot.data!.response?.getFirst.isEmpty ??
                                    true
                                ? CartEmptyWidget()
                                : Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      _cartHeader(context),
                                      16.verticalSpace,
                                      _productList(),
                                      _bottomWidget(context),
                                    ],
                                  ),
                          );
                      },
                    ),
                    OverlayLoadingWidget(showOverlayLoading: isLoading),
                  ],
                ),
              ),
            ],
          );
  }

  Widget _seperator() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
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
                  "إجمالي قبل الخصم",
                  snapshot.data ?? '',
                );
                CustomText(
                  text: snapshot.data ?? '',
                  textAlign: TextAlign.start,
                  customTextStyle: BoldStyle(
                    color: secondaryColor,
                    fontSize: 14.sp,
                  ),
                );
              },
            ),
            StreamBuilder(
              stream: widget.cartBloc.cartTotaDiscountStringBehaviour.stream,
              builder: (context, snapshot) {
                return (snapshot.hasData == false || snapshot.data == "")
                    ? SizedBox()
                    : _bottomCalculationsWidget(
                        "إجمالي الخصم",
                        snapshot.data ?? '',
                        color: redColor,
                      );
                CustomText(
                  text: snapshot.data.toString() ?? '',
                  textAlign: TextAlign.start,
                  customTextStyle: BoldStyle(
                    color: secondaryColor,
                    fontSize: 14.sp,
                  ),
                );
              },
            ),
            StreamBuilder(
              stream: widget.cartBloc.cartTotalDeliveryStringBehaviour.stream,
              builder: (context, snapshot) {
                return _bottomCalculationsWidget(
                  "مصاريف التوصيل",
                  snapshot.data ?? '',
                );
                CustomText(
                  text: snapshot.data ?? '',
                  textAlign: TextAlign.start,
                  customTextStyle: RegularStyle(
                    color: lightBlackColor,
                    fontSize: 14.sp,
                  ),
                );
              },
            ),
            _seperator(),
            StreamBuilder(
              stream: widget.cartBloc.cartTotalAfterDiscountBehaviour.stream,
              builder: (context, snapshot) {
                return _bottomTotalWidget("إجمالي", snapshot.data ?? '');
                CustomText(
                  text: snapshot.data ?? '',
                  textAlign: TextAlign.start,
                  customTextStyle: RegularStyle(
                    color: lightBlackColor,
                    fontSize: 14.sp,
                  ),
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
            ? SizedBox()
            : Expanded(
                child: ListView.separated(
                  separatorBuilder: (context, index) => 16.verticalSpace,
                  shrinkWrap: true,
                  itemCount: snapshot.data!.response!.getFirst.length,
                  itemBuilder: (context, index) {
                    return ProductWidget(
                      isCartProduct: true,
                      icDelete: Assets.svg.icDelete,
                      productMapper: snapshot.data!.response!.getFirst[index],
                      productCategoryBloc: widget.productCategoryBloc,
                      onDecrementClicked: (ProductMapper productMapper) {
                        isLoading.value = true;
                        widget.cartBloc
                            .editCart(
                              cartItemId:
                                  snapshot.data!.response!.getFirst[index].id,
                              productId: snapshot
                                  .data!
                                  .response!
                                  .getFirst[index]
                                  .productId,
                              quantity: snapshot
                                  .data!
                                  .response!
                                  .getFirst[index]
                                  .cartUserQuantity
                                  .toInt(),
                              price: snapshot
                                  .data!
                                  .response!
                                  .getFirst[index]
                                  .finalPrice,
                            )
                            .listen((event) {
                              if (event is SuccessState) {
                                // widget.cartBloc.getMyCart();
                                isLoading.value = false;
                              }
                            });
                      },
                      onIncrementClicked: (productMapper) {
                        isLoading.value = true;
                        widget.cartBloc
                            .editCart(
                              cartItemId:
                                  snapshot.data!.response!.getFirst[index].id,
                              productId: snapshot
                                  .data!
                                  .response!
                                  .getFirst[index]
                                  .productId,
                              quantity: snapshot
                                  .data!
                                  .response!
                                  .getFirst[index]
                                  .cartUserQuantity
                                  .toInt(),
                              price: snapshot
                                  .data!
                                  .response!
                                  .getFirst[index]
                                  .finalPrice,
                            )
                            .listen((event) {
                              if (event is SuccessState) {
                                // widget.cartBloc.getMyCart();
                                isLoading.value = false;
                              }
                            });
                        ;
                      },
                      onDeleteClicked: (productMapper) {
                        isLoading.value = true;
                        widget.cartBloc
                            .editCart(
                              cartItemId:
                                  snapshot.data!.response!.getFirst[index].id,
                              productId: snapshot
                                  .data!
                                  .response!
                                  .getFirst[index]
                                  .productId,
                              quantity: 0,
                              price: snapshot
                                  .data!
                                  .response!
                                  .getFirst[index]
                                  .finalPrice,
                            )
                            .listen((event) {
                              if (event is SuccessState) {
                                // widget.cartBloc.getMyCart();
                                isLoading.value = false;
                              }
                            });
                      },
                    );
                  },
                ),
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
          // 14.verticalSpace,
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
                  : SizedBox();
            },
          ),

          // CustomButtonWidget(
          //     enableClick: false,
          //     buttonColor: redColor,
          //     idleText: "الحد الأدنى للطلب !  1500 ر.ي.",
          //     textStyle: MediumStyle(color: whiteColor, fontSize: 14.sp)
          //         .getStyle(),
          //     height: 31,
          //     onTap: () {}),
        ],
      ),
    );
  }
}
