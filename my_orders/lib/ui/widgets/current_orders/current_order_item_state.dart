import 'package:core/core.dart';
import 'package:core/dto/modules/app_color_module.dart';
import 'package:core/dto/modules/custom_text_style_module.dart';
import 'package:core/ui/custom_text.dart';
import 'package:flutter/material.dart';

class CurrentOrderItemState extends StatelessWidget {
  final String date;
  final String title;
  final String icon;
  const CurrentOrderItemState({
    required this.date,
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ImageHelper(
              image: icon, imageType: ImageType.svg, width: 32, height: 32),
          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: title,
                customTextStyle:
                    MediumStyle(color: lightBlackColor, fontSize: 18.sp),
              ),
              CustomText(
                text: date,
                customTextStyle:
                    RegularStyle(color: greyColor, fontSize: 12.sp),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
