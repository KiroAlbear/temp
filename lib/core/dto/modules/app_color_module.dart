import 'package:deel/core/dto/modules/shared_pref_module.dart';
import 'package:flutter/material.dart';

/// primary colors
const Color primaryColorLightMode = Color.fromRGBO(255, 194, 0, 1);
const Color primaryColorDarkMode = Color.fromRGBO(255, 194, 0, 1);

const Color yellowColorLightMode = Color.fromRGBO(255, 241, 0, 1);
const Color yellowColorDarkMode = Color.fromRGBO(255, 241, 0, 1);

const Color filterItemColorLightMode = Color.fromRGBO(249, 243, 147, 1);
const Color filterItemColorDarkMode = Color.fromRGBO(249, 243, 147, 1);

/// secondary color
const Color secondaryLightMode = Color.fromRGBO(0, 69, 122, 1);
const Color secondaryDarkMode = Color.fromRGBO(0, 69, 122, 1);

// const Color darkSecondaryLightMode = Color.fromRGBO(0, 69, 122, 1);
// const Color darkSecondaryDarkMode = Color.fromRGBO(0, 69, 122, 1);

/// light black color
const Color lightBlackLightMode = Color.fromRGBO(58, 58, 58, 1);
const Color lightBlackDarkMode = Color.fromRGBO(58, 58, 58, 1);

/// pale blue color
const Color paleBlueLightMode = Color.fromRGBO(181, 238, 236, 1);
const Color paleBlueDarkMode = Color.fromRGBO(39, 170, 165, 1);

/// grey Color
const Color greyColorLightMode = Color.fromRGBO(168, 172, 177, 1);
const Color greyColorDarkMode = Color.fromRGBO(168, 172, 177, 1);

const Color greyBorderColorLightMode = Color.fromRGBO(238, 238, 238, 1);
const Color greyBorderColorDarkMode = Color.fromRGBO(238, 238, 238, 1);

const Color greyOrderGreyTextColorLightMode = Color.fromRGBO(132, 132, 132, 1);
const Color greyOrderGreyTextColorDarkMode = Color.fromRGBO(132, 132, 132, 1);

const Color greyTextFieldBorderColorLightMode = Color.fromRGBO(
  225,
  225,
  225,
  1,
);
const Color greyTextFieldBorderColorDarkMode = Color.fromRGBO(225, 225, 225, 1);

/// green color
const Color greenColorLightMode = Color.fromRGBO(47, 102, 78, 1);
const Color greenColorDarkMode = Color.fromRGBO(47, 102, 78, 1);

/// red color
const Color redColorLightMode = Color.fromRGBO(253, 68, 37, 1);
const Color redColorDarkMode = Color.fromRGBO(253, 68, 37, 1);

const Color black = Colors.black;
const Color white = Colors.white;

const Color bottomSheetBarrierLightMode = Color.fromRGBO(43, 43, 43, 0.4);
const Color bottomSheetBarrierDarkMode = Color.fromRGBO(43, 43, 43, 0.4);

/// light gray color color
const Color lightGreyColorLightMode = Color.fromRGBO(168, 172, 177, 1);
const Color lightGreyColorDarkMode = Color.fromRGBO(168, 172, 177, 1);

const Color lightGrey2ColorLightMode = Color.fromRGBO(237, 237, 237, 1);
const Color lightGrey2ColorDarkMode = Color.fromRGBO(237, 237, 237, 1);

/// off white color
const Color offWhiteColorLightMode = Color.fromRGBO(251, 251, 251, 1);
const Color offWhiteColorDarkMore = Color.fromRGBO(63, 63, 63, 1);

/// yellow card color
const Color yellowCardColorLightMode = Color.fromRGBO(254, 255, 239, 1);
const Color yellowCardColorDarkMode = Color.fromRGBO(254, 255, 239, 1);

/// yellow switch color
const Color yellowSwitchColorLightMode = Color.fromRGBO(249, 243, 147, 1);
const Color yellowSwitchColorDarkMode = Color.fromRGBO(249, 243, 147, 1);

/// yellow switch color
const Color yellowSwitchColorBorderLightMode = Color.fromRGBO(255, 194, 0, 1);
const Color yellowSwitchColorBorderDarkMode = Color.fromRGBO(255, 194, 0, 1);

/// yellow switch color
const Color yellowMostSellingBackgroundLightMode = Color.fromRGBO(
  255,
  194,
  0,
  0.18,
);
const Color yellowMostSellingBackgroundDarkMode = Color.fromRGBO(
  255,
  194,
  0,
  0.18,
);

/// green card color
const Color greenCardColorLightMode = Color.fromRGBO(239, 255, 240, 1);
const Color greenCardColorDarkMode = Color.fromRGBO(239, 255, 240, 1);

/// red card color
const Color redCardColorLightMode = Color.fromRGBO(255, 239, 239, 1);
const Color redCardColorDarkMode = Color.fromRGBO(255, 239, 239, 1);

/// promotion card color
const Color promotionCardColorLightMode = Color.fromRGBO(168, 172, 177, 0.1);
const Color promotionCardColorDarkMode = Color.fromRGBO(168, 172, 177, 0.1);

/// category card color
const Color categoryCardColorLightMode = Color.fromRGBO(251, 251, 251, 1);
const Color categoryCardColorDarkMode = Color.fromRGBO(251, 251, 251, 1);

const Color disabledButtonTextColorLightMode = Color.fromRGBO(135, 135, 135, 1);
const Color disabledButtonTextColorDarkMode = Color.fromRGBO(135, 135, 135, 1);

const Color disabledButtonColorLightMode = Color.fromRGBO(228, 228, 228, 1);
const Color disabledButtonColorDarkMode = Color.fromRGBO(228, 228, 228, 1);

/// menu order card color
const Color menuOrderCardColorLightMode = Color.fromRGBO(249, 249, 249, 1);
const Color menuOrderCardColorDarkMode = Color.fromRGBO(249, 249, 249, 1);

/// product card colorrgba
const Color productCardColorLightMode = Color.fromRGBO(250, 250, 250, 1);
const Color productCardColorDarkMode = Color.fromRGBO(250, 250, 250, 1);

const Color faqCardColorLightMode = Color.fromRGBO(238, 238, 239, 1);
const Color faqCardColorDarkMode = Color.fromRGBO(238, 238, 239, 1);

const Color cartSuccessBlueLightMode = Color.fromRGBO(0, 69, 122, 1);
const Color cartSuccessBlueDarkMode = Color.fromRGBO(0, 69, 122, 1);

bool get _isDark => SharedPrefModule().isDarkMode ?? false;

Color primaryColor = _isDark ? primaryColorDarkMode : primaryColorLightMode;

Color secondaryColor = _isDark ? secondaryDarkMode : secondaryLightMode;

// Color darkSecondaryColor = _isDark ? darkSecondaryDarkMode : darkSecondaryLightMode;

Color paleBlueColor = _isDark ? paleBlueDarkMode : paleBlueLightMode;

Color greyColor = _isDark ? greyColorDarkMode : greyColorLightMode;

Color borderGreyColor = _isDark
    ? greyBorderColorDarkMode
    : greyBorderColorLightMode;

Color textFieldBorderGreyColor = _isDark
    ? greyTextFieldBorderColorDarkMode
    : greyTextFieldBorderColorLightMode;

Color greenColor = _isDark ? greenColorDarkMode : greenColorLightMode;

Color redColor = _isDark ? redColorDarkMode : redColorLightMode;

Color blackColor = _isDark ? white : black;

Color lightBlackColor = _isDark ? lightBlackDarkMode : lightBlackDarkMode;

Color whiteColor = _isDark ? black : white;

Color offWhiteColor = _isDark ? offWhiteColorDarkMore : offWhiteColorLightMode;

Color yellowCardColor = _isDark
    ? yellowCardColorDarkMode
    : yellowCardColorLightMode;

Color greenCardColor = _isDark
    ? greenCardColorDarkMode
    : greenCardColorLightMode;

Color redCardColor = _isDark ? redCardColorDarkMode : redCardColorLightMode;

Color promotionCardColor = _isDark
    ? promotionCardColorDarkMode
    : promotionCardColorLightMode;

Color categoryCardColor = _isDark
    ? categoryCardColorDarkMode
    : categoryCardColorLightMode;

Color menuOrderCardColor = _isDark
    ? menuOrderCardColorDarkMode
    : menuOrderCardColorLightMode;

Color productCardColor = _isDark
    ? productCardColorDarkMode
    : productCardColorLightMode;

Color faqCardColor = _isDark ? faqCardColorDarkMode : faqCardColorLightMode;
Color yellowColor = _isDark ? yellowColorDarkMode : yellowColorLightMode;
Color bottomSheetBarrierColor = _isDark
    ? bottomSheetBarrierDarkMode
    : bottomSheetBarrierLightMode;
Color myOrdersCardColor = _isDark
    ? faqCardColorDarkMode
    : faqCardColorLightMode;

Color switchColor = _isDark
    ? yellowSwitchColorDarkMode
    : yellowSwitchColorLightMode;

Color switchBorderColor = _isDark
    ? yellowSwitchColorBorderDarkMode
    : yellowSwitchColorBorderLightMode;

Color mostSellingBackgroundColor = _isDark
    ? yellowMostSellingBackgroundDarkMode
    : yellowMostSellingBackgroundLightMode;

Color filterItemColor = _isDark
    ? filterItemColorDarkMode
    : filterItemColorLightMode;

Color cartSuccessBlueColor = _isDark
    ? cartSuccessBlueDarkMode
    : cartSuccessBlueLightMode;
