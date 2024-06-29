import 'package:core/core.dart';
import 'package:core/dto/modules/app_color_module.dart';
import 'package:core/dto/modules/custom_text_style_module.dart';
import 'package:core/ui/custom_text.dart';
import 'package:flutter/material.dart';

class OrderItemGreyText extends StatelessWidget {
  final String text;
  final CustomTextStyleModule subtitleTextStyle =
      RegularStyle(color: greyColor, fontSize: 12.sp);

  OrderItemGreyText({required this.text});

  @override
  Widget build(BuildContext context) {
    return CustomText(text: text, customTextStyle: subtitleTextStyle);
  }
}
