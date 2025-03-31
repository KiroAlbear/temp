import 'package:deel/deel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/generated/l10n.dart';

class CartScreen extends BaseStatefulWidget {

  final String icDelete;
  final CartBloc cartBloc;

  final ProductCategoryBloc productCategoryBloc;

  CartScreen(
      {required this.cartBloc,
      required this.icDelete,
      required this.productCategoryBloc,
      super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends BaseState<CartScreen> {
  ValueNotifier<bool> isLoading = ValueNotifier(false);

  @override
  PreferredSizeWidget? appBar() => null;

  @override
  bool canPop() => false;

  @override
  bool isSafeArea() => true;

  @override
  Color? statusBarColor() => secondaryColor;


  @override
  Color? systemNavigationBarColor() => secondaryColor;

  @override
  void initState() {
    widget.cartBloc.getMyCart();
    super.initState();
  }

  @override
  Widget getBody(BuildContext context) {
    return Column(
      children: [
        AppTopWidget(
          title: S.of(context).cartTitle,
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
                      onSuccess: snapshot.data!.response?.isEmpty ?? true
                          ? CartEmptyWidget()
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _cartHeader(context),
                                16.verticalSpace,
                                _productList(),
                                _bottomWidget(context)
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

  Container _bottomWidget(BuildContext context) {
    return Container(
      color: whiteColor,
      child: Padding(
        padding: EdgeInsetsDirectional.only(
            start: 16.w, end: 16.w, top: 16.h, bottom: 26.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                StreamBuilder(
                  stream: widget.cartBloc.cartTotalBehaviour.stream,
                  builder: (context, snapshot) {
                    return CustomText(
                        text: snapshot.data ?? '',
                        textAlign: TextAlign.start,
                        customTextStyle: BoldStyle(
                            color: darkSecondaryColor, fontSize: 14.sp));
                  },
                ),
                StreamBuilder(
                  stream: widget.cartBloc.cartTotalDeliveryBehaviour.stream,
                  builder: (context, snapshot) {
                    return CustomText(
                        text: snapshot.data ?? '',
                        textAlign: TextAlign.start,
                        customTextStyle:
                        RegularStyle(color: lightBlackColor, fontSize: 14.sp));
                  },
                ),
              ],
            ),
            CustomButtonWidget(
                width: 200.w,
                height: 48.h,
                borderRadius: 8,
                idleText: S.of(context).cartOrderNow,
                textStyle: MediumStyle(color: darkSecondaryColor, fontSize: 16.sp)
                    .getStyle(),
                onTap: () async {
                  if (widget.cartBloc.totalSum <=
                      widget.cartBloc.cartMinimumOrderBehaviour.value) {
                    AlertModule().showMessage(
                      context: context,
                      message:
                          "${S.of(context).cartMinimumOrder} ${widget.cartBloc.cartMinimumOrderBehaviour.value} ${widget.cartBloc.cartMinimumOrderCurrencyBehaviour.value}.",
                    );
                  }
                  else if(widget.cartBloc.isAnyProductOutOfStock) {
                    AlertModule().showMessage(
                      context: context,
                      message:S.of(context).cartProductsNotAvailable,
                    );
                  }
                  else if(widget.cartBloc.productsOfMoreThanAvailable.isNotEmpty) {
                    AlertModule().showMessage(
                      context: context,
                      message: "${widget.cartBloc.productsOfMoreThanAvailable.first.name} ${S.of(context).cartProductQuantityNotAvailable} ${widget.cartBloc.productsOfMoreThanAvailable.first.quantity}.",
                    );
                  }
                  else {
                    showModalBottomSheet(
                        barrierColor: bottomSheetBarrierColor,
                        backgroundColor: whiteColor,
                        useRootNavigator: true,
                        constraints: BoxConstraints(
                            maxHeight:
                                MediaQuery.of(context).size.height * 0.26),
                        context: context,
                        builder: (context) {
                          return CartBottomSheet(
                            cartBloc: widget.cartBloc,
                          );
                        });
                  }
                }),

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
                  itemCount: snapshot.data!.response!.length,
                  itemBuilder: (context, index) {
                    return ProductWidget(
                      isCartProduct: true,
                      icDelete: widget.icDelete,
                      productMapper: snapshot.data!.response![index],
                      productCategoryBloc: widget.productCategoryBloc,
                      onDecrementClicked: (ProductMapper productMapper) {
                        isLoading.value = true;
                        CartCommonFunctions()
                            .editCart(
                          cartBloc: widget.cartBloc,
                          cartItemId: snapshot.data!.response![index].id,
                          productId: snapshot.data!.response![index].productId,
                          quantity:
                              snapshot.data!.response![index].cartUserQuantity,
                          price: snapshot.data!.response![index].finalPrice,
                          state: CartState.decrement,
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
                        CartCommonFunctions()
                            .editCart(
                          cartBloc: widget.cartBloc,
                          cartItemId: snapshot.data!.response![index].id,
                          productId: snapshot.data!.response![index].productId,
                          quantity:
                              snapshot.data!.response![index].cartUserQuantity,
                          price: snapshot.data!.response![index].finalPrice,
                          state: CartState.increment,
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
                        CartCommonFunctions()
                            .editCart(
                          cartBloc: widget.cartBloc,
                          cartItemId: snapshot.data!.response![index].id,
                          productId: snapshot.data!.response![index].productId,
                          quantity: 0,
                          price: snapshot.data!.response![index].finalPrice,
                          state: CartState.decrement,
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

  // void editCart(
  //     {required int id,
  //     required int productId,
  //     required double quantity,
  //     required double price,
  //     required CartState state,
  //     bool isDelete = false}) {
  //   isLoading.value = true;
  //   widget.cartBloc
  //       .editCart(
  //     cartItemId: id,
  //     productId: productId,
  //     price: price,
  //     cartState: state,
  //     quantity: quantity.toInt(),
  //   )
  //       .listen((event) {
  //     if (event is SuccessState && isDelete) {
  //       // widget.cartBloc.getMyCart();
  //       isLoading.value = false;
  //     } else if (event is SuccessState && !isDelete) {
  //       isLoading.value = false;
  //     }
  //   });
  // }

  Widget _cartHeader(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 14.verticalSpace,
          CustomText(
              text: S.of(context).cartProductDetails,
              customTextStyle:
                  BoldStyle(color: darkSecondaryColor, fontSize: 18.sp)),
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
                              text:
                              "${S.of(context).cartMinimumOrder} ",
                              textAlign: TextAlign.center,
                              customTextStyle:
                              RegularStyle(color: whiteColor, fontSize: 12.sp),
                            ),
                            CustomText(
                              text:
                                  "${snapshot.data.toString()} ${widget.cartBloc.cartMinimumOrderCurrencyBehaviour.value}.",
                              textAlign: TextAlign.center,
                              customTextStyle:
                                  BoldStyle(color: whiteColor, fontSize: 12.sp),
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
