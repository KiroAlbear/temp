import 'package:deel/deel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_loader/image_helper.dart';

class CartOrderDetailsItem extends StatelessWidget {
  final String? icon;
  final String title;
  final int? count;
  final double iconSize;
  final double space;

  const CartOrderDetailsItem(
      {this.icon,
      required this.title,
      this.count,
      this.iconSize = 30,
      this.space = 3,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 5.h),
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
                    icon == null
                        ? SizedBox(
                            width: iconSize,
                            height: iconSize,
                          )
                        : SizedBox(
                            width: iconSize,
                            height: iconSize,
                            child: ImageHelper(
                              image: icon!,
                              imageType: ImageType.svg,
                            )),
                    space.horizontalSpace,
                    Flexible(
                      child: CustomText(
                          text: title,
                          textAlign: TextAlign.center,
                          customTextStyle: RegularStyle(
                              color: lightBlackColor, fontSize: 16.sp)),
                    ),
                  ],
                ),
              ),
              count == null
                  ? Container()
                  : CustomText(
                      text: "(X ${count.toString()})",
                      textAlign: TextAlign.center,
                      customTextStyle: RegularStyle(
                          color: lightBlackColor, fontSize: 16.sp)),
            ],
          ),
        ],
      ),
    );
  }
}
