import 'package:core/core.dart';
import 'package:flutter/cupertino.dart';

import 'app_color_module.dart';
import 'app_provider_module.dart';

BoxDecoration get leftRadiusWhiteBorder => BoxDecoration(
    color: whiteColor,
    borderRadius: BorderRadius.only(
        topLeft: Radius.circular(40.w),
        topRight: Radius.circular(40.w)));


BoxDecoration get grayRectangleBorder=> BoxDecoration(
  color: whiteColor,
  borderRadius: BorderRadius.circular(10.r),
  border: Border.all(width: 1.w, color: greyColor)
);
