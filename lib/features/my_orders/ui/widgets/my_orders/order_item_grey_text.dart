
import 'package:deel/deel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderItemGreyText extends StatelessWidget {
  final String text;
  final CustomTextStyleModule subtitleTextStyle =
      RegularStyle(color: greyOrderGreyTextColorLightMode, fontSize: 12.sp);

  OrderItemGreyText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return CustomText(
        textAlign: TextAlign.end,
        text: text,
        customTextStyle: subtitleTextStyle);
  }
}
