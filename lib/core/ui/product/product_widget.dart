import 'dart:ui';

import 'package:deel/deel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_loader/image_helper.dart';
import 'package:intl/intl.dart' show NumberFormat;
import 'package:just_the_tooltip/just_the_tooltip.dart';

class ProductWidget extends StatefulWidget {
  final ProductMapper productMapper;
  final ProductCategoryBloc productCategoryBloc;
  final CartBloc? cartBloc;
  final Function(int)? onProductRemoved;
  final int index;
  final Function(bool favourite, ProductMapper productMapper)? onTapFavourite;
  final Function(ProductMapper productMapper)? onAddToCart;
  final bool isCartProduct;
  final Function(ProductMapper productMapper)? onDeleteClicked;
  final Function(ProductMapper productMapper)? onIncrementClicked;
  final Function(ProductMapper productMapper)? onDecrementClicked;

  ProductWidget({
    super.key,
    required this.productMapper,
    required this.productCategoryBloc,
    this.cartBloc,
    this.onAddToCart,
    this.onTapFavourite,
    this.onProductRemoved,
    this.onDeleteClicked,
    this.isCartProduct = false,
    this.onIncrementClicked,
    this.onDecrementClicked,
    required this.index,
  }) {
    if (!isCartProduct &&
        (onTapFavourite == null || onAddToCart == null)) {
      assert(
        false,
        'isCartProduct is false, onTapFavourite and addToCart should be provided',
      );
    }
    if (isCartProduct && onDeleteClicked == null) {
      assert(
        false,
        'isCartProduct is true, onDeleteClicked should be provided',
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
  ValueNotifier<bool> toolTipVisibility = ValueNotifier<bool>(true);

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
    String formattedPrice = NumberFormat("#,##0.00").format(price);
    priceTextToShow = '$formattedPrice ${widget.productMapper.currency}';

    super.initState();
  }

  bool isTwoLinesOrMore({
    required String text,
    required TextStyle style,
    required double maxWidth,
    required TextOverflow overflow,
    required bool isCartProduct,
    required int maxLines, // optional if you already limit it
    TextDirection textDirection = TextDirection.ltr,
    TextScaler textScaler = const TextScaler.linear(1.0),
  }) {
    final tp = TextPainter(
      text: TextSpan(text: text, style: style),
      textDirection: textDirection,
      maxLines: maxLines,
      ellipsis: overflow == TextOverflow.ellipsis ? '…' : null,
      textScaler: textScaler,
    )..layout(maxWidth: maxWidth +(isCartProduct?180:80));


    bool isOverflowed = tp.didExceedMaxLines;


    // If you DON'T set maxLines, estimate the line count from height.
    final lineCount = (tp.size.height / tp.preferredLineHeight).ceil();



    return lineCount >= 2 || isOverflowed;
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
                  ? const SizedBox()
                  : SizedBox(height: 4.h),
              widget.productMapper.description.isEmpty
                  ? const SizedBox()
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
            padding: EdgeInsetsDirectional.only(top: 8.h, start: 16.w),
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
                        ? const SizedBox()
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
                if (widget.productMapper.discountPercentage > 0)
                  Positioned(top: 0, left: 0, child: _discountWidget),
              ],
            ),
            SizedBox(height: 8.h),
            Padding(
              padding: EdgeInsetsDirectional.only(bottom: 8.h, end: 16.w),
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
          color: Colors.red.withAlpha((0.5 * 255).round()),
          borderRadius: BorderRadius.circular(5.r),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 2.h),
          child: CustomText(
            text: Loc.of(context)!.productIsNotAvailable,
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
                ? const SizedBox(
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
        topLeft: Radius.circular(4.w),

        bottomRight: Radius.circular(4.w),
        topRight: Radius.circular(4.w),
      ),
    ),
    child: CustomText(
      text: discount('${widget.productMapper.discountPercentage}%'),
      customTextStyle: RegularStyle(color: whiteColor, fontSize: 10.sp),
    ),
  );

  String discount(Object percent) {
    return '${Loc.of(context)!.discount} $percent';
  }

  Widget get _favouriteIcon => ImageHelper(
    image: widget.productMapper.isFavourite
        ? Assets.svg.icFavouriteFilled
        : Assets.svg.icFavourite,
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
    child: Row(
      children: [
        Expanded(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final String text = widget.productMapper.name;
              final CustomTextStyleModule style = widget.isCartProduct
                  ? BoldStyle(color: lightBlackColor, fontSize: 14.sp)
                  : MediumStyle(color: lightBlackColor, fontSize: 12.sp);
              final TextScaler scale = MediaQuery.textScalerOf(context);
              const int maxLines = 2;
              final twoOrMore = isTwoLinesOrMore(
                text: text,
                style: style.getStyle(),
                maxWidth: constraints.maxWidth,
                textScaler: scale,
                overflow: TextOverflow.ellipsis,
                maxLines: maxLines,
                isCartProduct: widget.isCartProduct
              );
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (twoOrMore) {
                  toolTipVisibility.value = true;
                } else {
                  toolTipVisibility.value = false;
                }
              });

              return CustomText(
                text: text,
                textAlign: TextAlign.start,
                customTextStyle: style,
                maxLines: maxLines,
              );
            },
          ),
        ),
        const SizedBox(width: 5,),
        ValueListenableBuilder(
          valueListenable: toolTipVisibility,
          builder: (context, value, child) {
            return JustTheTooltip(
              offset: -40,
              tailBaseWidth: 0,
              isModal: true,
              margin: EdgeInsetsDirectional.fromSTEB(
                (widget.index % 2 > 0 && widget.isCartProduct == false) ? 10 : 200,
                0,
                0,
                0,
              ),
              content: Container(
                color: tooltipColor,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 150,
                    child: Text(widget.productMapper.name),
                  ),
                ),
              ),
              child: value
                  ? Material(
                      color: const Color(0xff00457A).withAlpha(25),
                      shape: const CircleBorder(),
                      child: const Padding(
                        padding: EdgeInsets.all(4.0),
                        child: Icon
                          (Icons.remove_red_eye_outlined,
                          size: 15,
                          color: Color(0xff00457A),
                        ),
                      ),
                    )
                  : const SizedBox(),
            );
          },
        ),
      ],
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
          confirmMessage: Loc.of(context)!.ok,
          onConfirm: () {},
        );
      },
    );
  }

  void _showDeleteAlertDialog(String message, String qty) {
    showModalBottomSheet(
      context: context,
      useRootNavigator: true,
      builder: (context) {
        return DialogWidget(
          message: "$message $qty",
          confirmMessage: Loc.of(context)!.ok,
          cancelMessage: Loc.of(context)!.cancel,
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
                    Loc.of(context)!.cartMaximumProductsReached,
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
          SizedBox(
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
                  _showDeleteAlertDialog(
                    Loc.of(context)!.cartDeleteMessage,
                    "",
                  );
                }
              },
              child: SizedBox(
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
                                image: Assets.svg.icDelete,
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
          text: Loc.of(context)!.addToCart,
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
