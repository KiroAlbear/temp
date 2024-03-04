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
      bottomNavigationBarTheme: _lightBottomNavigationBarThemeData,
      hoverColor: primaryColorLightMode,
      highlightColor: primaryColorLightMode,
      textTheme: TextTheme(
        bodyLarge: MediumStyle(color: secondaryLightMode, fontSize: 12.sp).getStyle(),
      ),
      listTileTheme: ListTileThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.w),
        ),
        textColor: secondaryLightMode,
        subtitleTextStyle: MediumStyle(color: secondaryLightMode, fontSize: 10.sp).getStyle(),
        titleTextStyle: MediumStyle(color: secondaryLightMode, fontSize: 10.sp).getStyle(),
          dense: true,
      ),
      colorScheme: ColorScheme(
        brightness: Brightness.light,
        primary: primaryColorLightMode,
        onPrimary: primaryColorLightMode,
        secondary: secondaryLightMode,
        onSecondary: secondaryLightMode,
        error: redColorLightMode,
        onError: redColorLightMode,
        errorContainer: redColorLightMode,
        background: whiteColor,
        onBackground: whiteColor,
        surface: lightGreyColorLightMode,
        onSurface: lightGreyColorLightMode,
        outline: secondaryLightMode,
        onSurfaceVariant: secondaryLightMode,
      )
  );

  ThemeData get darkTheme => ThemeData(
      scaffoldBackgroundColor: secondaryLightMode,
      primaryColor: primaryColorDarkMode,
      dividerColor: greyColorDarkMode,
      bottomNavigationBarTheme: _darkBottomNavigationBarThemeData,
      hoverColor: primaryColorDarkMode,
      highlightColor: primaryColorDarkMode,
      textTheme: TextTheme(
        bodyLarge: MediumStyle(color: secondaryDarkMode, fontSize: 12.sp).getStyle(),
      ),
      listTileTheme: ListTileThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.w),
        ),
        textColor: secondaryDarkMode,
        subtitleTextStyle: MediumStyle(color: secondaryDarkMode, fontSize: 10.sp).getStyle(),
        titleTextStyle: MediumStyle(color: secondaryDarkMode, fontSize: 10.sp).getStyle(),
        dense: true,
      ),
      colorScheme: ColorScheme(
        brightness: Brightness.light,
        primary: primaryColorDarkMode,
        onPrimary: primaryColorDarkMode,
        secondary: secondaryDarkMode,
        onSecondary: secondaryDarkMode,
        error: redColorDarkMode,
        onError: redColorDarkMode,
        errorContainer: redColorDarkMode,
        background: secondaryLightMode,
        onBackground: blackColor,
        surface: lightGreyColorDarkMode,
        onSurface: lightGreyColorDarkMode,
        outline: secondaryColor,
        onSurfaceVariant: secondaryColor,
      ));

  BottomNavigationBarThemeData get _lightBottomNavigationBarThemeData =>
      BottomNavigationBarThemeData(
          backgroundColor: offWhiteColorLightMode,
          elevation: 0,
          landscapeLayout: BottomNavigationBarLandscapeLayout.linear,
          selectedItemColor: whiteColor,
          selectedLabelStyle: RegularStyle(
            color: whiteColor,
            fontSize: 9.sp,
          ).getStyle(),
          showSelectedLabels: false,
          showUnselectedLabels: false,
          unselectedItemColor: greyColorLightMode,
          unselectedLabelStyle: RegularStyle(
            color: greyColorLightMode,
            fontSize: 9.sp,
          ).getStyle(),
          type: BottomNavigationBarType.fixed);

  BottomNavigationBarThemeData get _darkBottomNavigationBarThemeData =>
      BottomNavigationBarThemeData(
          backgroundColor: offWhiteColorDarkMore,
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
