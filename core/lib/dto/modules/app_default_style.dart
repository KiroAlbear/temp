import 'package:core/core.dart';
import 'package:flutter/cupertino.dart';

import 'app_color_module.dart';
import 'app_provider_module.dart';

BoxDecoration get leftRadiusWhiteBorder => BoxDecoration(
    color: whiteColor,
    borderRadius: BorderRadius.only(
        topLeft: AppProviderModule().locale == 'en'
            ? Radius.circular(40.w)
            : Radius.zero,
        topRight: AppProviderModule().locale == 'ar'
            ? Radius.circular(40.w)
            : Radius.zero));


BoxDecoration get grayRectangleBorder=> BoxDecoration(
  color: whiteColor,
  borderRadius: BorderRadius.circular(10.r),
  border: Border.all(width: 1.w, color: greyColor)
);
