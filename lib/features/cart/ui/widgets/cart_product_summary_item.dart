import 'package:deel/deel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_loader/image_helper.dart';

class CartProductSummaryItem extends StatelessWidget {
  final String title;
  final int count;
  final String priceText;

  const CartProductSummaryItem({required this.title, required this.count, required this.priceText, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsetsDirectional.only(top: 5.h,start: 5.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CustomText(
                        text: count.toString(),
                        textAlign: TextAlign.center,
                        customTextStyle: BoldStyle(
                            color: lightBlackColor, fontSize: 14.sp)),
                    5.horizontalSpace,
                    Flexible(
                      child: CustomText(
                          text: title,
                          textAlign: TextAlign.center,
                          customTextStyle: RegularStyle(
                              color: lightBlackColor, fontSize: 14.sp)),
                    ),
                  ],
                ),
              ),
              CustomText(
                  text: priceText,
                  textAlign: TextAlign.center,
                  customTextStyle: BoldStyle(
                      color: lightBlackColor, fontSize: 14.sp)),
            ],
          ),
        ],
      ),
    );
  }
}
