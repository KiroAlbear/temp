import 'dart:ui';

import 'package:deel/core/Utils/firebase_analytics_events_names.dart';
import 'package:deel/core/Utils/firebase_analytics_utl.dart';
import 'package:deel/deel.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_loader/image_helper.dart';
import 'package:intl/intl.dart';
import '../../generated/l10n.dart';

class ProductWidget extends StatefulWidget {
  final ProductMapper productMapper;
  final ProductCategoryBloc productCategoryBloc;
  final String? favouriteIcon;
  final String? favouriteIconFilled;
  final String? icDelete;
  final CartBloc? cartBloc;
  final Function(int)? onProductRemoved;

  final Function(bool favourite, ProductMapper productMapper)? onTapFavourite;
  final Function(ProductMapper productMapper)? onAddToCart;
  final bool isCartProduct;
  final Function(ProductMapper productMapper)? onDeleteClicked;
  final Function(ProductMapper productMapper)? onIncrementClicked;
  final Function(ProductMapper productMapper)? onDecrementClicked;
  ProductWidget({
    Key? key,
    required this.productMapper,
    required this.productCategoryBloc,
    this.cartBloc,
    this.icDelete,
    this.onAddToCart,
    this.favouriteIconFilled,
    this.favouriteIcon,
    this.onTapFavourite,
    this.onProductRemoved,
    this.onDeleteClicked,
    this.isCartProduct = false,
    this.onIncrementClicked,
    this.onDecrementClicked,
  }) : super(key: key) {
    if (!isCartProduct &&
        (favouriteIcon == null ||
            onTapFavourite == null && onAddToCart == null)) {
      assert(
        false,
        'isCartProduct is false, favouriteIcon, onTapFavourite and addToCart should be provided',
      );
    }
    if (isCartProduct && (icDelete == null || onDeleteClicked == null)) {
      assert(
        false,
        'isCartProduct is true, icDelete and onDeleteClicked should be provided',
      );
    }
  }

  @override
  State<ProductWidget> createState() => _ProductWidgetState();
}

class _ProductWidgetState extends State<ProductWidget> {
  final ValueNotifier<bool> isAddingToFavSucess = ValueNotifier(true);
  final double buttonWidth = 145.w;
  final double buttonHeight = 30.h;
  final double plusMinusIconSize = 18.sp;
  final double plusMinusIconHeight = 30.h;

  String priceTextToShow = "";
  ValueNotifier<int> qtyValueNotifier = ValueNotifier<int>(0);

  @override
  void initState() {
    if (widget.isCartProduct) {
      qtyValueNotifier.value = widget.productMapper.quantity.round();
    } else {
      qtyValueNotifier.value = widget.productMapper.cartUserQuantity.round();
    }

    double price = widget.isCartProduct
        ? widget.productMapper.cartFinalUnitPrice ?? 0
        : widget.productMapper.finalPrice;
    String FormatedPrice = NumberFormat("#,##0.00").format(price);
    priceTextToShow = '$FormatedPrice ${widget.productMapper.currency}';

    super.initState();
  }

  @override
  Widget build(BuildContext context) => Padding(
    padding: widget.isCartProduct
        ? EdgeInsets.symmetric(horizontal: 16.w)
        : EdgeInsets.zero,
    child: Container(
      decoration: BoxDecoration(
        color: productCardColor,
        borderRadius: BorderRadius.circular(16.w),
      ),
      child: widget.isCartProduct
          ? _getCartProductWidget()
          : _getProductWidget(),
    ),
  );

  Widget _getProductWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // SizedBox(
        //   height: 12.h,
        // ),
        Padding(
          padding: EdgeInsetsDirectional.only(start: 14.w, top: 14.w),
          child: Stack(
            children: [
              _productImage,
              SizedBox(height: 4.h),
              _favouriteRow,
            ],
          ),
        ),
        Padding(
          padding: EdgeInsetsDirectional.only(start: 14.w, end: 14.w),
          child: Column(
            children: [
              SizedBox(height: 5.h),
              ImageFiltered(
                imageFilter: SharedPrefModule().userId == null
                    ? ImageFilter.blur(sigmaX: 4, sigmaY: 4)
                    : ImageFilter.blur(sigmaX: 0, sigmaY: 0),
                child: _priceRow,
              ),
              SizedBox(height: 2.h),
              _productName,

              widget.productMapper.description.isEmpty
                  ? SizedBox()
                  : SizedBox(height: 4.h),
              widget.productMapper.description.isEmpty
                  ? SizedBox()
                  : _productDescription,
              SizedBox(height: 0.h),

              // Center(child: _addCartButton),
              Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: ValueListenableBuilder(
                  valueListenable: qtyValueNotifier,
                  builder: (context, value, child) {
                    return value == 0
                        ? Center(child: _addCartButton)
                        : Center(child: _incrementDecrementButton());
                  },
                ),
              ),
            ],
          ),
        ),

        // SizedBox(
        //   height: 10.h,
        // )
      ],
    );
  }

  _getCartProductWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Padding(
            padding: EdgeInsetsDirectional.only(
              top: 8.h,
              start: 16.w,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [Expanded(child: _productName)],
                    ),
                    SizedBox(height: 8.h),
                    widget.productMapper.isAvailable
                        ? SizedBox()
                        : _notAvailableProduct(),
                  ],
                ),
                _priceRow,
              ],
            ),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Stack(
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.only(
                    top: 10.h,
                    end: 29.w,
                    start: 16.w,
                  ),
                  child: _productImage,
                ),
                // SizedBox(height: 19.h),
                if (widget.productMapper.discountPercentage > 0) Positioned(
                    top: 0,
                    left: 0,
                    child: _discountWidget),
              ],
            ),
            SizedBox(height: 8.h),
            Padding(
              padding: EdgeInsetsDirectional.only(
                bottom: 8.h,
                end: 16.w,
              ),
              child: _incrementDecrementButton(),
            ),
          ],
        ),
      ],
    );
  }

  Widget _notAvailableProduct() {
    return Padding(
      padding: EdgeInsetsDirectional.only(start: 0.w),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.red.withOpacity(.5),
          borderRadius: BorderRadius.circular(5.r),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 2.h),
          child: CustomText(
            text: S.of(context).productIsNotAvailable,
            customTextStyle: RegularStyle(
              color: lightBlackColor,
              fontSize: 8.sp,
            ),
          ),
        ),
      ),
    );
  }

  Widget get _favouriteRow => Row(
    children: [
      if (SharedPrefModule().bearerToken?.isNotEmpty ?? false)
        ValueListenableBuilder(
          valueListenable: isAddingToFavSucess,
          builder: (context, value, child) {
            return !value
                ? SizedBox(
                    height: 18,
                    width: 18,
                    child: CircularProgressIndicator(),
                  )
                : InkWell(
                    onTap: () {
                      if (SharedPrefModule().bearerToken?.isEmpty ?? true) {
                        Apputils.showNeedToLoginBottomSheet(context);
                      } else {
                        widget.onTapFavourite!(
                          !widget.productMapper.isFavourite,
                          widget.productMapper,
                        );

                        if (widget.productMapper.isFavourite) {
                          widget.productCategoryBloc
                              .removeProductFromFavourite(
                                productId: widget.productMapper.id,
                                clientId: int.parse(
                                  SharedPrefModule().userId ?? '0',
                                ),
                              )
                              .listen((event) {
                                if (widget.onProductRemoved != null &&
                                    event.response != null &&
                                    event.response!) {
                                  widget.onProductRemoved!(
                                    widget.productMapper.id,
                                  );
                                }
                                _handleFavouriteIcon(event, false);
                                FirebaseAnalyticsUtil().logEvent(
                                  FirebaseAnalyticsEventsNames
                                      .remove_from_wishlist,
                                );
                              });
                        } else {
                          widget.productCategoryBloc
                              .addProductToFavourite(
                                productId: widget.productMapper.id,
                                clientId: int.parse(
                                  SharedPrefModule().userId ?? '0',
                                ),
                              )
                              .listen((event) {
                                _handleFavouriteIcon(event, true);
                              });
                          FirebaseAnalyticsUtil().logEvent(
                            FirebaseAnalyticsEventsNames.add_to_wishlist,
                          );
                        }
                      }
                    },
                    child: _favouriteIcon,
                  );
          },
        ),
      const Spacer(),
      if (widget.productMapper.discountPercentage > 0) _discountWidget,
    ],
  );

  void _handleFavouriteIcon(ApiState<bool> event, bool isAdded) {
    if (event is SuccessState) {
      widget.productMapper.isFavourite = isAdded;
      isAddingToFavSucess.value = true;
    } else if (event is LoadingState) {
      isAddingToFavSucess.value = false;
    } else if (event is! LoadingState && event is! SuccessState) {
      isAddingToFavSucess.value = true;
    }
  }

  Widget get _discountWidget => Container(
    padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 7.w),
    decoration: BoxDecoration(
      color: redColor,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular( 4.w ),

        bottomRight: Radius.circular(
           4.w,
        ),
        topRight: Radius.circular( 4.w),
      ),
    ),
    child: CustomText(
      text: S
          .of(context)
          .discount('${widget.productMapper.discountPercentage}%'),
      customTextStyle: RegularStyle(color: whiteColor, fontSize: 10.sp),
    ),
  );

  Widget get _favouriteIcon => ImageHelper(
    image: widget.productMapper.isFavourite
        ? widget.favouriteIconFilled!
        : widget.favouriteIcon!,
    imageType: ImageType.svg,
    color: redColor,
    width: 24.w,
    height: 24.h,
  );

  Widget get _productImage => Center(
    child: ImageHelper(
            image: widget.productMapper.image,
            imageType: ImageType.network,
            height: widget.isCartProduct ? 50.h : 90.h,
            width: widget.isCartProduct ? 50.w : 90.w,
          ),
  );

  Widget get _productName => SizedBox(
    height: 40,
    child: CustomText(
      text: widget.productMapper.name,
      textAlign: TextAlign.start,
      customTextStyle: widget.isCartProduct
          ? BoldStyle(color: lightBlackColor, fontSize: 14.sp)
          : MediumStyle(color: lightBlackColor, fontSize: 12.sp),
      maxLines: 2,
    ),
  );

  Widget get _priceRow => Row(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Expanded(
        flex: widget.isCartProduct ? 0 : 1,
        child: CustomText(
          text: priceTextToShow,
          textAlign: TextAlign.start,
          customTextStyle: BoldStyle(
            fontSize: widget.isCartProduct ? 16.sp : 14.sp,
            color: secondaryColor,
          ),
        ),
      ),
      SizedBox(width: widget.productMapper.hasDiscount ? 10.w : 0),
      if (widget.productMapper.hasDiscount)
        CustomText(
          text:
              '${widget.isCartProduct ? widget.productMapper.cartOriginalUnitPrice.toString() : widget.productMapper.productOriginalPrice.toString()} ${widget.productMapper.currency}',
          customTextStyle: BoldStyle(
            color: redColor,
            fontSize: 10.sp,
            textDecoration: TextDecoration.lineThrough,
          ),
        ),
    ],
  );

  Widget get _productDescription => CustomText(
    text: widget.productMapper.description,
    customTextStyle: RegularStyle(fontSize: 12.sp, color: greyColor),
    maxLines: 2,
  );

  void _showMaximumAlertDialog(String message, String qty) {
    showModalBottomSheet(
      context: context,
      useRootNavigator: true,
      builder: (context) {
        return DialogWidget(
          sameButtonsColor: false,
          message: "$message $qty",
          confirmMessage: S.of(context).ok,
          onConfirm: () {},
        );
      },
    );
    // AlertModule().showDialog(
    //   context: context,
    //   message: "$message $qty",
    //   confirmMessage: S.of(context).ok,
    //   onConfirm: () {},
    // );
  }

  void _showDeleteAlertDialog(String message, String qty) {
    showModalBottomSheet(
      context: context,
      useRootNavigator: true,
      builder: (context) {
        return DialogWidget(
          message: "$message $qty",
          confirmMessage: S.of(context).ok,
          cancelMessage: S.of(context).cancel,
          sameButtonsColor: false,
          onCancel: () {},
          onConfirm: () {
            qtyValueNotifier.value = 0;
            widget.onDeleteClicked!(widget.productMapper);
            FirebaseAnalyticsUtil().logEvent(
              FirebaseAnalyticsEventsNames.remove_from_cart,
            );
          },
        );
      },
    );
    // AlertModule().showDialog(
    //   context: context,
    //   message: "$message $qty",
    //   confirmMessage: S.of(context).ok,
    //   cancelMessage: S.of(context).cancel,
    //   onCancel: () {},
    //   onConfirm: () {
    //     qtyValueNotifier.value=0;
    //     widget.onDeleteClicked!(widget.productMapper);
    //   },
    // );
  }

  Widget _incrementDecrementButton() {
    final double horizontalSpace = 10.w;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.r),
        color: widget.isCartProduct ? lightGrey2ColorDarkMode : primaryColor,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            // color: Colors.red,
            height: plusMinusIconHeight,
            padding: EdgeInsetsDirectional.only(start: horizontalSpace),
            child: InkWell(
              onTap: () {
                if (widget.isCartProduct &&
                    widget.productMapper.maxQuantity ==
                        widget.productMapper.minQuantity &&
                    widget.productMapper.maxQuantity == 0) {
                  widget.productMapper.maxQuantity = widget
                      .productMapper
                      .availableQuantity
                      .toDouble();
                } else if (widget.isCartProduct == false &&
                    widget.productMapper.maxQuantity ==
                        widget.productMapper.minQuantity &&
                    widget.productMapper.maxQuantity == 0) {
                  widget.productMapper.maxQuantity =
                      widget.productMapper.quantity;
                }

                if (qtyValueNotifier.value < widget.productMapper.maxQuantity) {
                  qtyValueNotifier.value++;
                  widget.productMapper.cartUserQuantity = qtyValueNotifier.value
                      .toDouble();
                  widget.onIncrementClicked!(widget.productMapper);

                  FirebaseAnalyticsUtil().logEvent(
                    FirebaseAnalyticsEventsNames.update_cart_quantity,
                  );
                } else {
                  _showMaximumAlertDialog(
                    S.of(context).cartMaximumProductsReached,
                    widget.productMapper.maxQuantity.round().toString(),
                  );
                }
              },
              child: Icon(
                Icons.add,
                weight: 10,
                size: plusMinusIconSize,
                color: cartSuccessBlueColor,
              ),
            ),
          ),
          Container(
            height: 20.h,
            width: 20.w,
            child: ValueListenableBuilder(
              valueListenable: qtyValueNotifier,
              builder: (context, value, child) {
                return Center(
                  child: CustomText(
                    text: value.toString(),
                    textAlign: TextAlign.center,
                    customTextStyle: MediumStyle(
                      color: cartSuccessBlueColor,
                      fontSize: 14.sp,
                      lineHeight: 0.7,
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            // color: Colors.red,
            padding: EdgeInsetsDirectional.only(end: horizontalSpace),
            child: InkWell(
              onTap: () {
                if (qtyValueNotifier.value > widget.productMapper.minQuantity &&
                    qtyValueNotifier.value > 1) {
                  qtyValueNotifier.value--;
                  widget.productMapper.cartUserQuantity = qtyValueNotifier.value
                      .toDouble();

                  widget.onDecrementClicked!(widget.productMapper);
                  FirebaseAnalyticsUtil().logEvent(
                    FirebaseAnalyticsEventsNames.update_cart_quantity,
                  );
                } else {
                  _showDeleteAlertDialog(S.of(context).cartDeleteMessage, "");
                }
              },
              child: Container(
                height: plusMinusIconHeight,
                child: Center(
                  child: ValueListenableBuilder(
                    valueListenable: qtyValueNotifier,
                    builder: (context, value, child) {
                      return (value == widget.productMapper.minQuantity ||
                              value <= 1)
                          ? SizedBox(
                              height: 24.h,
                              width: 24.w,
                              child: ImageHelper(
                                image: widget.icDelete!,
                                imageType: ImageType.svg,
                              ),
                            )
                          : Icon(
                              Icons.remove,
                              size: plusMinusIconSize,
                              color: cartSuccessBlueColor,
                            );
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget get _addCartButton => InkWell(
    onTap: () async {
      if (SharedPrefModule().bearerToken?.isEmpty ?? true) {
        await Apputils.showNeedToLoginBottomSheet(context);
      } else {
        if (widget.productMapper.canAddToCart()) //TODO: uncomment this line
        {
          widget.onAddToCart!(widget.productMapper);
          qtyValueNotifier.value = widget.productMapper.minQuantity == 0
              ? 1
              : widget.productMapper.minQuantity.toInt();
          if (widget.cartBloc != null) {
            widget.cartBloc!.getMyCart();
          }
          FirebaseAnalyticsUtil().logEvent(
            FirebaseAnalyticsEventsNames.add_to_cart,
          );
        }
      }
    },
    child: Container(
      alignment: Alignment.center,
      width: buttonWidth,
      height: buttonHeight,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.r),
        color: (SharedPrefModule().userId == null)
            ? disabledButtonColorLightMode
            : widget.productMapper.canAddToCart()
            ? primaryColor
            : disabledButtonColorLightMode,
      ),
      child: Center(
        child: CustomText(
          text: S.of(context).addToCart,
          customTextStyle: RegularStyle(
            color: (SharedPrefModule().userId == null)
                ? disabledButtonTextColorLightMode
                : widget.productMapper.canAddToCart()
                ? secondaryColor
                : disabledButtonTextColorLightMode,
            fontSize: 12.sp,
          ),
        ),
      ),
    ),
  );
}
