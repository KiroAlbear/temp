import 'package:deel/deel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_loader/image_helper.dart';

class CartOrderDetailsIconItem extends StatelessWidget {
  final String title;
  final double iconSize;
  final double space;
  final CartOrderDetailsIconType iconType;

  const CartOrderDetailsIconItem(
      {required this.iconType,
      required this.title,
      this.iconSize = 30,
      this.space = 3,
      super.key});

  String get _icon {
    switch (iconType) {
      case CartOrderDetailsIconType.date:
        return Assets.svg.icDate;
      case CartOrderDetailsIconType.total:
        return Assets.svg.icTotal;
    }
  }

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
                    SizedBox(
                      width: iconSize,
                      height: iconSize,
                      child: ImageHelper(
                        image: _icon,
                        color: secondaryColor,
                        imageType: ImageType.svg,
                      ),
                    ),
                    space.horizontalSpace,
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
            ],
          ),
        ],
      ),
    );
  }
}

enum CartOrderDetailsIconType { date, total }
