import 'package:core/dto/modules/shared_pref_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app_color_module.dart';
import 'app_provider_module.dart';
import 'custom_text_style_module.dart';

class CustomTheme {
  ThemeData get lightTheme => ThemeData(
      scaffoldBackgroundColor: whiteColor,
      primaryColor: primaryColorLightMode,
      dividerColor: greyColorLightMode,
      bottomNavigationBarTheme: _whiteBottomNavigationBarThemeData,
      hoverColor: primaryColorLightMode,
      highlightColor: primaryColorLightMode,
      colorScheme: ColorScheme(
        brightness: Brightness.light,
        primary: primaryColorLightMode,
        onPrimary: primaryColorLightMode.withOpacity(0.8),
        secondary: secondaryLightMode,
        onSecondary: secondaryLightMode.withOpacity(0.8),
        error: redColorLightMode,
        onError: redColorLightMode.withOpacity(0.8),
        errorContainer: redColorLightMode.withOpacity(0.8),
        background: whiteColor,
        onBackground: whiteColor.withOpacity(0.8),
        surface: lightGreyColorLightMode.withOpacity(0.4),
        onSurface: lightGreyColorLightMode.withOpacity(0.4),
      ));

  ThemeData get darkTheme => ThemeData(
      scaffoldBackgroundColor: secondaryLightMode,
      primaryColor: primaryColorDarkMode,
      dividerColor: greyColorDarkMode,
      bottomNavigationBarTheme: _darkBottomNavigationBarThemeData,
      hoverColor: primaryColorDarkMode,
      highlightColor: primaryColorDarkMode,
      colorScheme: ColorScheme(
        brightness: Brightness.light,
        primary: primaryColorDarkMode,
        onPrimary: primaryColorDarkMode.withOpacity(0.8),
        secondary: secondaryDarkMode,
        onSecondary: secondaryDarkMode.withOpacity(0.8),
        error: redColorDarkMode,
        onError: redColorDarkMode.withOpacity(0.8),
        errorContainer: redColorDarkMode.withOpacity(0.8),
        background: secondaryLightMode,
        onBackground: blackColor.withOpacity(0.8),
        surface: lightGreyColorDarkMode.withOpacity(0.4),
        onSurface: lightGreyColorDarkMode.withOpacity(0.4),));

  BottomNavigationBarThemeData get _whiteBottomNavigationBarThemeData =>
      BottomNavigationBarThemeData(
          backgroundColor: greyColorLightMode.withOpacity(0.5),
          elevation: 0,
          landscapeLayout: BottomNavigationBarLandscapeLayout.linear,
          selectedItemColor: whiteColor,
          selectedLabelStyle: RegularStyle(
            color: whiteColor,
            fontSize: 9.sp,
          ).getStyle(),
          showSelectedLabels: true,
          showUnselectedLabels: true,
          unselectedItemColor: greyColorLightMode,
          unselectedLabelStyle: RegularStyle(
            color: greyColorLightMode,
            fontSize: 9.sp,
          ).getStyle(),
          type: BottomNavigationBarType.fixed);

  BottomNavigationBarThemeData get _darkBottomNavigationBarThemeData =>
      BottomNavigationBarThemeData(
          backgroundColor: greyColorDarkMode.withOpacity(0.5),
          elevation: 0,
          landscapeLayout: BottomNavigationBarLandscapeLayout.linear,
          selectedItemColor: blackColor,
          selectedLabelStyle: RegularStyle(
            color: blackColor,
            fontSize: 14.sp,
          ).getStyle(),
          showSelectedLabels: true,
          showUnselectedLabels: true,
          unselectedItemColor: greyColorDarkMode,
          unselectedLabelStyle: RegularStyle(
            color: greyColorDarkMode,
            fontSize: 12.sp,
          ).getStyle(),
          type: BottomNavigationBarType.fixed);
}
