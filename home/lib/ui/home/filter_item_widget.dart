import 'package:core/core.dart';
import 'package:core/dto/modules/app_color_module.dart';
import 'package:core/dto/modules/custom_text_style_module.dart';
import 'package:core/ui/custom_text.dart';
import 'package:flutter/material.dart';

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
