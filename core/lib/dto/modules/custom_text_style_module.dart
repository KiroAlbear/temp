import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_color_module.dart';
import 'app_provider_module.dart';

abstract class CustomTextStyleModule {
  final double fontSize;
  final Color color;
  final TextDecoration textDecoration;

  CustomTextStyleModule(
      {this.fontSize = 15.0,
      this.color = Colors.white,
      this.textDecoration = TextDecoration.none});

  TextStyle englishFont(FontWeight fontWeight) => GoogleFonts.tajawal(
      color: color,
      fontWeight: fontWeight,
      fontSize: fontSize,
      decoration: textDecoration);

  TextStyle arabicFont(FontWeight fontWeight) => GoogleFonts.tajawal(
      color: color,
      fontWeight: fontWeight,
      fontSize: fontSize - 4,
      decoration: textDecoration);

  bool get isEnglish => AppProviderModule().locale == "en";

  TextStyle getStyle();
}

class LightStyle extends CustomTextStyleModule {
  @override
  TextStyle getStyle() =>
      isEnglish ? englishFont(FontWeight.w300) : arabicFont(FontWeight.w300);

  LightStyle(
      {double fontSize = 15,
      Color color = Colors.white,
      TextDecoration textDecoration = TextDecoration.none})
      : super(color: color, fontSize: fontSize, textDecoration: textDecoration);
}

class RegularStyle extends CustomTextStyleModule {
  @override
  TextStyle getStyle() =>
      isEnglish ? englishFont(FontWeight.w400) : arabicFont(FontWeight.w400);

  RegularStyle(
      {double fontSize = 15,
      Color color = Colors.white,
      TextDecoration textDecoration = TextDecoration.none})
      : super(color: color, fontSize: fontSize, textDecoration: textDecoration);
}

class MediumStyle extends CustomTextStyleModule {
  @override
  TextStyle getStyle() =>
      isEnglish ? englishFont(FontWeight.w500) : arabicFont(FontWeight.w500);

  MediumStyle(
      {double fontSize = 15,
      Color color = Colors.white,
      TextDecoration textDecoration = TextDecoration.none})
      : super(color: color, fontSize: fontSize, textDecoration: textDecoration);
}

class SemiBoldStyle extends CustomTextStyleModule {
  @override
  TextStyle getStyle() =>
      isEnglish ? englishFont(FontWeight.w600) : arabicFont(FontWeight.w600);

  SemiBoldStyle(
      {double fontSize = 15,
      Color color = Colors.white,
      TextDecoration textDecoration = TextDecoration.none})
      : super(color: color, fontSize: fontSize, textDecoration: textDecoration);
}

class BoldStyle extends CustomTextStyleModule {
  @override
  TextStyle getStyle() =>
      isEnglish ? englishFont(FontWeight.w700) : arabicFont(FontWeight.w700);

  BoldStyle(
      {double fontSize = 15,
      Color color = Colors.white,
      TextDecoration textDecoration = TextDecoration.none})
      : super(color: color, fontSize: fontSize, textDecoration: textDecoration);
}

class SemiUltraBoldStyle extends CustomTextStyleModule {
  @override
  TextStyle getStyle() =>
      isEnglish ? englishFont(FontWeight.w800) : arabicFont(FontWeight.w800);

  SemiUltraBoldStyle(
      {double fontSize = 15,
        Color color = Colors.white,
        TextDecoration textDecoration = TextDecoration.none})
      : super(color: color, fontSize: fontSize, textDecoration: textDecoration);
}

class UltraBoldStyle extends CustomTextStyleModule {
  @override
  TextStyle getStyle() =>
      isEnglish ? englishFont(FontWeight.w900) : arabicFont(FontWeight.w900);

  UltraBoldStyle(
      {double fontSize = 15,
      Color color = Colors.white,
      TextDecoration textDecoration = TextDecoration.none})
      : super(color: color, fontSize: fontSize, textDecoration: textDecoration);
}
