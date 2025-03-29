
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_loader/image_helper.dart';

import '../../../../../deel.dart';

class FilterItemWidget extends StatelessWidget {
  final String? imageUrl;
  final String title;
  final bool isSelected;
  final Function() onTap;
  final double _borderRadious = 5;
  final Color textColor;
  final withBorders;

  const FilterItemWidget(
      {this.imageUrl,
      this.isSelected = false,
      this.textColor = lightBlackLightMode,
        this.withBorders = false,
      required this.onTap,
      required this.title});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: isSelected ? darkSecondaryColor.withOpacity(0.1) : withBorders?Colors.transparent:productCardColor,
      shape: RoundedRectangleBorder(
        side: withBorders ? BorderSide(color: greyBorderColorLightMode, width: 1) : BorderSide.none,
        borderRadius: BorderRadius.circular(_borderRadious),
      ),
      child: InkWell(
        onTap: () => onTap(),
        borderRadius: BorderRadius.circular(_borderRadious),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              imageUrl == null
                  ? SizedBox()
                  : ImageHelper(
                      width: 30,
                      height: 25,
                      image: imageUrl!,
                      imageType: ImageType.network),
              imageUrl == null
                  ? SizedBox(): SizedBox(width: 10),
              CustomText(
                  text: title,
                  customTextStyle:
                      RegularStyle(color: textColor, fontSize: 16.sp)),
            ],
          ),
        ),
      ),
    );
  }
}
