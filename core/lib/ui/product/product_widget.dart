import 'package:cart/ui/cart_bloc.dart';
import 'package:core/Utils/AppUtils.dart';
import 'package:core/core.dart';
import 'package:core/dto/models/baseModules/api_state.dart';
import 'package:core/dto/models/product/product_mapper.dart';
import 'package:core/dto/modules/alert_module.dart';
import 'package:core/dto/modules/app_color_module.dart';
import 'package:core/dto/modules/app_provider_module.dart';
import 'package:core/dto/modules/custom_text_style_module.dart';
import 'package:core/dto/modules/shared_pref_module.dart';
import 'package:core/generated/l10n.dart';
import 'package:core/ui/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:home/ui/product/product_category_bloc.dart';

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
    super.key,
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
  }) {
    if (!isCartProduct &&
        (favouriteIcon == null ||
            onTapFavourite == null && onAddToCart == null)) {
      assert(false,
          'isCartProduct is false, favouriteIcon, onTapFavourite and addToCart should be provided');
    }
    if (isCartProduct && (icDelete == null || onDeleteClicked == null)) {
      assert(false,
          'isCartProduct is true, icDelete and onDeleteClicked should be provided');
    }
  }

  @override
  State<ProductWidget> createState() => _ProductWidgetState();
}

class _ProductWidgetState extends State<ProductWidget> {
  final ValueNotifier<bool> isAddingToFavSucess = ValueNotifier(true);
  final double buttonWidth = 89.w;
  final double buttonHeight = 25.h;
  ValueNotifier<int> qtyValueNotifier = ValueNotifier<int>(0);

  @override
  void initState() {
    if (widget.isCartProduct) {
      qtyValueNotifier.value = widget.productMapper.quantity.round();
    } else {
      qtyValueNotifier.value = widget.productMapper.cartUserQuantity.round();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Container(
        decoration: BoxDecoration(
          color: productCardColor,
          borderRadius: BorderRadius.circular(16.w),
        ),
        child: widget.isCartProduct
            ? _getCartProductWidget()
            : _getProductWidget(),
      );

  Widget _getProductWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 12.h,
        ),
        _favouriteAndDiscountRow,
        SizedBox(
          height: 4.h,
        ),
        _productImage,
        SizedBox(
          height: 5.h,
        ),
        _productName,
        SizedBox(
          height: 4.h,
        ),
        _priceRow,
        SizedBox(
          height: 4.h,
        ),
        _productDescription,
        SizedBox(
          height: 9.h,
        ),
        // Center(child: _addCartButton),

        ValueListenableBuilder(
          valueListenable: qtyValueNotifier,
          builder: (context, value, child) {
            return value == 0
                ? Center(child: _addCartButton)
                : Center(
                    child: _incrementDecrementButton(),
                  );
          },
        ),

        SizedBox(
          height: 10.h,
        )
      ],
    );
  }

  _getCartProductWidget() {
    return Padding(
      padding: EdgeInsetsDirectional.only(top: 8.h, bottom: 8.h, end: 16.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  widget.isCartProduct
                      ? Row(
                          children: [
                            ConstrainedBox(
                                constraints: BoxConstraints(maxWidth: 280.w),
                                child: _productName),
                          ],
                        )
                      : _productName,
                  SizedBox(
                    height: 4.h,
                  ),
                  _priceRow,
                  SizedBox(
                    height: 4.h,
                  ),
                ],
              ),
              SizedBox(
                height: 8.h,
              ),
              widget.productMapper.isAvailable
                  ? SizedBox()
                  : _notAvailableProduct()
            ],
          ),
          Column(
            children: [
              _productImage,
              SizedBox(
                height: 8.h,
              ),
              _incrementDecrementButton(),
            ],
          )
        ],
      ),
    );
  }

  Widget _notAvailableProduct() {
    return Padding(
      padding: EdgeInsetsDirectional.only(start: 16.w),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.red.withOpacity(.5),
          borderRadius: BorderRadius.circular(5.r),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 2.h),
          child: CustomText(
            text: S.of(context).productIsNotAvailable,
            customTextStyle:
                RegularStyle(color: lightBlackColor, fontSize: 8.sp),
          ),
        ),
      ),
    );
  }

  Widget get _favouriteAndDiscountRow => Row(
        children: [
          SizedBox(
            width: 12.w,
          ),
          ValueListenableBuilder(
            valueListenable: isAddingToFavSucess,
            builder: (context, value, child) {
              return !value
                  ? SizedBox(
                      height: 18, width: 18, child: CircularProgressIndicator())
                  : InkWell(
                      onTap: () {
                        if (SharedPrefModule().bearerToken?.isEmpty ?? true) {
                          Apputils.showNeedToLoginDialog(context);
                          return;
                        } else {
                          widget.onTapFavourite!(
                              !widget.productMapper.isFavourite,
                              widget.productMapper);

                          if (widget.productMapper.isFavourite) {
                            widget.productCategoryBloc
                                .removeProductFromFavourite(
                              productId: widget.productMapper.id,
                              clientId:
                                  int.parse(SharedPrefModule().userId ?? '0'),
                            )
                                .listen((event) {
                              if (widget.onProductRemoved != null &&
                                  event.response != null &&
                                  event.response!) {
                                widget
                                    .onProductRemoved!(widget.productMapper.id);
                              }
                              _handleFavouriteIcon(event, false);
                            });
                          } else {
                            widget.productCategoryBloc
                                .addProductToFavourite(
                              productId: widget.productMapper.id,
                              clientId:
                                  int.parse(SharedPrefModule().userId ?? '0'),
                            )
                                .listen((event) {
                              _handleFavouriteIcon(event, true);
                            });
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
                topLeft: Radius.circular(
                    AppProviderModule().locale == 'ar' ? 4.w : 0),
                bottomLeft: Radius.circular(
                    AppProviderModule().locale == 'ar' ? 4.w : 0),
                bottomRight: Radius.circular(
                    AppProviderModule().locale == 'ar' ? 0 : 4.w),
                topRight: Radius.circular(
                    AppProviderModule().locale == 'ar' ? 0 : 4.w))),
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
        width: 18.w,
        height: 18.h,
        color: widget.productMapper.isFavourite ? null : secondaryColor,
      );

  Widget get _productImage => Center(
        child: widget.productMapper.image.isEmpty
            ? SizedBox()
            : ImageHelper(
                image: widget.productMapper.image,
                imageType: ImageType.network,
                height: 55.h,
                width: 55.w,
              ),
      );

  Widget get _productName => Padding(
        padding: EdgeInsets.symmetric(horizontal: 14.w),
        child: CustomText(
          text: widget.productMapper.name,
          customTextStyle: MediumStyle(color: lightBlackColor, fontSize: 12.sp),
          maxLines: 1,
        ),
      );

  Widget get _priceRow => Padding(
        padding: EdgeInsets.symmetric(horizontal: 14.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            CustomText(
                text:
                    '${widget.isCartProduct ? widget.productMapper.price_reduce_taxinc : widget.productMapper.getPrice().toString()} ${widget.productMapper.currency}',
                customTextStyle:
                    MediumStyle(fontSize: 14.sp, color: secondaryColor)),
            SizedBox(
              width: 10.w,
            ),
            if (widget.productMapper.discountPercentage > 0)
              CustomText(
                text:
                    '${widget.productMapper.price.toString()} ${widget.productMapper.currency}',
                customTextStyle: MediumStyle(
                    color: redColor,
                    fontSize: 10.sp,
                    textDecoration: TextDecoration.lineThrough),
              )
          ],
        ),
      );

  Widget get _productDescription => Padding(
        padding: EdgeInsets.symmetric(horizontal: 14.w),
        child: CustomText(
          text: widget.productMapper.description,
          customTextStyle: RegularStyle(fontSize: 12.sp, color: greyColor),
          maxLines: 2,
        ),
      );

  void _showMaximumAlertDialog(String message, String qty) {
    AlertModule().showDialog(
      context: context,
      message: "$message $qty",
      confirmMessage: S.of(context).ok,
      onConfirm: () {},
    );
  }

  void _showDeleteAlertDialog(String message, String qty) {
    AlertModule().showDialog(
      context: context,
      message: "$message $qty",
      confirmMessage: S.of(context).ok,
      cancelMessage: S.of(context).cancel,
      onCancel: () {},
      onConfirm: () {
        qtyValueNotifier.value--;
        widget.onDeleteClicked!(widget.productMapper);
      },
    );
  }

  Widget _incrementDecrementButton() {
    final SizedBox horizontalSpace = 10.horizontalSpace;
    final SizedBox spacing = 0.horizontalSpace;
    return Container(
      // width: isProductPage ? buttonWidth : null,
      // height: isProductPage ? buttonHeight : null,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.r),
        color: primaryColor,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          horizontalSpace,
          Container(
            height: 20.h,
            width: 20.w,
            child: InkWell(
              onTap: () {
                if (qtyValueNotifier.value < widget.productMapper.maxQuantity) {
                  qtyValueNotifier.value++;
                  widget.productMapper.cartUserQuantity =
                      qtyValueNotifier.value.toDouble();
                  widget.onIncrementClicked!(widget.productMapper);
                } else {
                  _showMaximumAlertDialog(
                      S.of(context).cartMaximumProductsReached,
                      widget.productMapper.maxQuantity.round().toString());
                }
              },
              child: CustomText(
                text: '+',
                customTextStyle:
                    MediumStyle(color: cartSuccessBlueColor, fontSize: 14.sp),
              ),
            ),
          ),
          spacing,
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
                        color: cartSuccessBlueColor, fontSize: 14.sp),
                  ),
                );
              },
            ),
          ),
          spacing,
          InkWell(
            onTap: () {
              if (qtyValueNotifier.value > widget.productMapper.minQuantity &&
                  qtyValueNotifier.value > 1) {
                qtyValueNotifier.value--;
                widget.productMapper.cartUserQuantity =
                    qtyValueNotifier.value.toDouble();

                widget.onDecrementClicked!(widget.productMapper);
              }
              // else if (qtyValueNotifier.value ==
              //         widget.productMapper.minQuantity &&
              //     widget.productMapper.minQuantity > 1) {
              //   _showMaximumAlertDialog(
              //       S.of(context).cartMinimumProductsReached,
              //       widget.productMapper.minQuantity.round().toString());
              // }
              else {
                _showDeleteAlertDialog(S.of(context).cartDeleteMessage, "");
              }
            },
            child: Container(
              height: 30.h,
              width: 20.w,
              child: Center(
                child: ValueListenableBuilder(
                  valueListenable: qtyValueNotifier,
                  builder: (context, value, child) {
                    return (value == widget.productMapper.minQuantity ||
                            value <= 1)
                        ? ImageHelper(
                            image: widget.icDelete!, imageType: ImageType.svg)
                        : CustomText(
                            text: '-',
                            textAlign: TextAlign.center,
                            customTextStyle: MediumStyle(
                                color: cartSuccessBlueColor, fontSize: 14.sp),
                          );
                  },
                ),
              ),
            ),
          ),
          horizontalSpace
        ],
      ),
    );
  }

  Widget get _addCartButton => InkWell(
        onTap: () async {
          if (widget.productMapper.canAddToCart()) //TODO: uncomment this line
          {
            widget.onAddToCart!(widget.productMapper);
            qtyValueNotifier.value = 1;
            if (widget.cartBloc != null) {
              widget.cartBloc!.getMyCart();
            }
          }
        },
        child: Container(
          alignment: Alignment.center,
          width: buttonWidth,
          height: buttonHeight,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.r),
            color:
                widget.productMapper.canAddToCart() ? primaryColor : greyColor,
          ),
          child: Center(
            child: CustomText(
                text: S.of(context).addToCart,
                customTextStyle:
                    MediumStyle(color: lightBlackColor, fontSize: 10.sp)),
          ),
        ),
      );
}
