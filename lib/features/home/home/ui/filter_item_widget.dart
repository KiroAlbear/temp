
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_loader/image_helper.dart';

import '../../../../../deel.dart';

class FilterItemWidget extends StatelessWidget {
  final String? imageUrl;
  final String title;
  final bool isSelected;
  final Function() onTap;
  final double _borderRadious = 10;

  const FilterItemWidget(
      {this.imageUrl,
      this.isSelected = false,
      required this.onTap,
      required this.title});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: isSelected ? filterItemColor : productCardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(_borderRadious),
      ),
      child: InkWell(
        onTap: () => onTap(),
        borderRadius: BorderRadius.circular(_borderRadious),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              imageUrl == null
                  ? SizedBox()
                  : ImageHelper(
                      width: 30,
                      height: 30,
                      image: imageUrl!,
                      imageType: ImageType.network),
              SizedBox(width: 10),
              CustomText(
                  text: title,
                  customTextStyle:
                      RegularStyle(color: lightBlackColor, fontSize: 16.sp)),
            ],
          ),
        ),
      ),
    );
  }
}
