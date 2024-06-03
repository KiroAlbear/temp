import 'package:core/core.dart';
import 'package:core/dto/modules/app_color_module.dart';
import 'package:core/dto/modules/app_provider_module.dart';
import 'package:core/dto/modules/custom_text_style_module.dart';
import 'package:core/generated/l10n.dart';
import 'package:core/ui/custom_button_widget.dart';
import 'package:core/ui/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:core/dto/models/product/product_mapper.dart';

class ProductWidget extends StatefulWidget {
  final ProductMapper productMapper;
  final String favouriteIcon;
  final Function(bool favourite, ProductMapper productMapper) onTapFavourite;
  final Function(ProductMapper productMapper) addToCart;
  const ProductWidget(
      {super.key,
      required this.productMapper,
      required this.addToCart,
      required this.favouriteIcon,
      required this.onTapFavourite});

  @override
  State<ProductWidget> createState() => _ProductWidgetState();
}

class _ProductWidgetState extends State<ProductWidget> {
  @override
  Widget build(BuildContext context) => Container(
      decoration: BoxDecoration(
        color: productCardColor,
        borderRadius: BorderRadius.circular(16.w),
      ),
      child: Column(
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
          Center(child: _addCartButton),
          SizedBox(
            height: 10.h,
          )
        ],
      ),
    );

  Widget get _favouriteAndDiscountRow => Row(
        children: [
          SizedBox(
            width: 12.w,
          ),
          _favouriteIcon,
          const Spacer(),
          if (widget.productMapper.discountPercentage > 0) _discountWidget,
        ],
      );

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

  Widget get _favouriteIcon => InkWell(
        onTap: () {
          widget.onTapFavourite(
              !widget.productMapper.isFavourite, widget.productMapper);
        },
        child: ImageHelper(
          image: widget.favouriteIcon,
          imageType: ImageType.svg,
          width: 18.w,
          height: 18.h,
          color: widget.productMapper.isFavourite ? redColor : secondaryColor,
        ),
      );

  Widget get _productImage => Center(
        child: ImageHelper(
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
            customTextStyle:
                MediumStyle(color: lightBlackColor, fontSize: 12.sp),maxLines: 1,),
      );

  Widget get _priceRow => Padding(
        padding: EdgeInsets.symmetric(horizontal: 14.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            CustomText(
                text:
                    '${widget.productMapper.getPrice().toString()} ${widget.productMapper.currency}',
                customTextStyle:
                    MediumStyle(fontSize: 14.sp, color: secondaryColor)),
            SizedBox(width: 10.w,),
            if (widget.productMapper.discountPercentage > 0)
              CustomText(
                text: '${widget.productMapper.price.toString()} ${widget.productMapper.currency}',
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

  Widget get _addCartButton => InkWell(
        onTap: () {
          if (widget.productMapper.addToCart()) {
            widget.addToCart(widget.productMapper);
          }
        },
        child: Container(
          alignment: Alignment.center,
          width: 89.w,
          height: 25.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.r),
            color: widget.productMapper.isAvailable ? primaryColor : greyColor,
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
