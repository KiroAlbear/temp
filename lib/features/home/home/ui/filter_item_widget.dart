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
  final bool withBorders;

  const FilterItemWidget(
      {super.key, this.imageUrl,
      this.isSelected = false,
      this.textColor = lightBlackLightMode,
      this.withBorders = false,
      required this.onTap,
      required this.title});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: isSelected
          ? secondaryColor.withAlpha((0.1 * 255).round())
          : withBorders
              ? Colors.transparent
              : productCardColor,
      shape: RoundedRectangleBorder(
        side: withBorders
            ? const BorderSide(color: greyBorderColorLightMode, width: 1)
            : BorderSide.none,
        borderRadius: BorderRadius.circular(_borderRadious),
      ),
      child: InkWell(
        onTap: () => onTap(),
        borderRadius: BorderRadius.circular(_borderRadious),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              imageUrl == null
                  ? const SizedBox()
                  : ImageHelper(
                      width: 30,
                      height: 25,
                      image: imageUrl!,
                      imageType: ImageType.network),
              imageUrl == null ? const SizedBox() : const SizedBox(width: 10),
              Padding(
                padding: const EdgeInsets.only(bottom: 5.0),
                child: CustomText(
                    text: title,
                    textAlign: TextAlign.center,
                    customTextStyle: RegularStyle(
                      color: textColor,
                      fontSize: 16.sp,
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
