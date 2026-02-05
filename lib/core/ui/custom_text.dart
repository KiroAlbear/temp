import 'package:flutter/material.dart';

import '../dto/modules/custom_text_style_module.dart';

class CustomText extends StatelessWidget {
  final String text;
  final TextAlign textAlign;
  final bool softWrap;
  final CustomTextStyleModule customTextStyle;
  final int? maxLines;
  const CustomText(
      {super.key, required this.text,
        required this.customTextStyle,
        this.textAlign = TextAlign.start,
        this.softWrap = true,
        this.maxLines});

  @override
  Widget build(BuildContext context) => customText;

  Text get customText => Text(
    text,
    textAlign: textAlign,
    style: customTextStyle.getStyle(),
    softWrap: softWrap,
    maxLines: maxLines,
    overflow: TextOverflow.ellipsis,
    textScaler: const TextScaler.linear(1.0),
  );
}
