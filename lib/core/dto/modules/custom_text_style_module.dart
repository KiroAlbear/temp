import 'package:deel/core/Utils/AppConstants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_provider_module.dart';

abstract class CustomTextStyleModule {
  final double fontSize;
  final Color color;
  final TextDecoration textDecoration;
  final double? lineHeight;
  CustomTextStyleModule(
      {this.fontSize = 15.0,
      this.color = Colors.white,
      this.lineHeight,
      this.textDecoration = TextDecoration.none});


  TextStyle englishFont(FontWeight fontWeight) =>
      TextStyle(
          color: color,
          fontWeight: fontWeight,
          fontSize: fontSize,
          decoration: textDecoration,
          decorationColor: color,
          height: lineHeight,
          fontFamily: AppConstants.DINNextFont
      );

      // GoogleFonts.rubik(
      // color: color,
      // fontWeight: fontWeight,
      // fontSize: fontSize,
      // decoration: textDecoration,
      // decorationColor: color);

  TextStyle arabicFont(FontWeight fontWeight) =>
      TextStyle(color: color,
          fontWeight: fontWeight,
          fontSize: fontSize - 4,
          decoration: textDecoration,
          decorationColor: color,
          fontFamily: AppConstants.DINNextFont
      );


      // GoogleFonts.rubik(
      // color: color,
      // fontWeight: fontWeight,
      // fontSize: fontSize - 4,
      // decoration: textDecoration,
      // decorationColor: color);

  bool get isEnglish => AppProviderModule().locale == "en";

  TextStyle getStyle();
}

class LightStyle extends CustomTextStyleModule {
  @override
  TextStyle getStyle() =>
      isEnglish ? englishFont(FontWeight.w300) : arabicFont(FontWeight.w300);

  LightStyle({super.fontSize, super.color, super.textDecoration,super.lineHeight});
}

class RegularStyle extends CustomTextStyleModule {
  @override
  TextStyle getStyle() =>
      isEnglish ? englishFont(FontWeight.w400) : arabicFont(FontWeight.w400);

  RegularStyle({super.fontSize, super.color, super.textDecoration,super.lineHeight});
}

class MediumStyle extends CustomTextStyleModule {
  @override
  TextStyle getStyle() =>
      isEnglish ? englishFont(FontWeight.w500) : arabicFont(FontWeight.w500);

  MediumStyle({super.fontSize, super.color, super.textDecoration,super.lineHeight});
}

class SemiBoldStyle extends CustomTextStyleModule {
  @override
  TextStyle getStyle() =>
      isEnglish ? englishFont(FontWeight.w600) : arabicFont(FontWeight.w600);

  SemiBoldStyle({super.fontSize, super.color, super.textDecoration,super.lineHeight});
}

class BoldStyle extends CustomTextStyleModule {
  @override
  TextStyle getStyle() =>
      isEnglish ? englishFont(FontWeight.w700) : arabicFont(FontWeight.w700);

  BoldStyle({super.fontSize, super.color, super.textDecoration,super.lineHeight});
}

class SemiUltraBoldStyle extends CustomTextStyleModule {
  @override
  TextStyle getStyle() =>
      isEnglish ? englishFont(FontWeight.w800) : arabicFont(FontWeight.w800);

  SemiUltraBoldStyle({super.fontSize, super.color, super.textDecoration,super.lineHeight});
}

class UltraBoldStyle extends CustomTextStyleModule {
  @override
  TextStyle getStyle() =>
      isEnglish ? englishFont(FontWeight.w900) : arabicFont(FontWeight.w900);

  UltraBoldStyle({super.fontSize, super.color, super.textDecoration,super.lineHeight});
}
