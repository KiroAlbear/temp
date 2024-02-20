import 'package:core/dto/modules/shared_pref_module.dart';
import 'package:flutter/material.dart';

/// primary colors
const Color primaryColorLightMode = Color.fromRGBO(255, 241, 0, 1);
const Color primaryColorDarkMode = Color.fromRGBO(255, 241, 0, 1);

/// secondary color
const Color secondaryLightMode = Color.fromRGBO(35, 31, 32, 1);
const Color secondaryDarkMode = Color.fromRGBO(17, 15, 16, 1);

/// pale blue color
const Color paleBlueLightMode = Color.fromRGBO(181, 238, 236, 1);
const Color paleBlueDarkMode = Color.fromRGBO(39, 170, 165, 1);

/// grey Color
const Color greyColorLightMode = Color.fromRGBO(168, 172, 177, 1);
const Color greyColorDarkMode = Color.fromRGBO(81, 85, 90, 1);

/// green color
const Color greenColorLightMode = Color.fromRGBO(1, 177, 135, 1);
const Color greenColorDarkMode = Color.fromRGBO(0, 88, 67, 1);

/// red color
const Color redColorLightMode = Color.fromRGBO(255, 10, 7, 1);
const Color redColorDarkMode = Color.fromRGBO(131, 1, 0, 1);

const Color black = Colors.black;
const Color white = Colors.white;

/// light gray color color
const Color lightGreyColorLightMode = Color.fromRGBO(240, 240, 240, 1);
const Color lightGreyColorDarkMode = Color.fromRGBO(120, 120, 120, 1);

bool get _isDark => SharedPrefModule().isDarkMode?? false;

Color primaryColor = _isDark ? primaryColorDarkMode : primaryColorLightMode;

Color secondaryColor = _isDark ? secondaryDarkMode : secondaryLightMode;

Color paleBlueColor = _isDark ? paleBlueDarkMode : paleBlueLightMode;

Color greyColor = _isDark ? greyColorDarkMode : greyColorLightMode;

Color greenColor = _isDark ? greenColorDarkMode : greenColorLightMode;

Color redColor = _isDark ? redColorDarkMode : redColorLightMode;

Color blackColor = _isDark ? white : black;

Color whiteColor = _isDark ? black : white;
