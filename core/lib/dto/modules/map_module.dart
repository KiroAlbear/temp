import 'package:core/core.dart';
import 'package:core/dto/modules/app_color_module.dart';
import 'package:core/dto/modules/app_provider_module.dart';
import 'package:core/dto/modules/constants_module.dart';
import 'package:core/dto/modules/custom_text_style_module.dart';
import 'package:core/dto/modules/logger_module.dart';
import 'package:flutter/material.dart';
import 'package:location_picker_flutter_map/location_picker_flutter_map.dart';

class MapModule {
  Widget loadMap(
      {required Function(PickedData pickedData) onPicked,
      Function(PickedData pickedData)? onChanged}) {
    return FlutterLocationPicker(
      onPicked: (pickedData) => onPicked(pickedData),
      onChanged: (pickedData) =>
          onChanged != null ? onChanged(pickedData) : null,
      contributorBadgeForOSMColor: primaryColor,
      zoomButtonsColor: primaryColor,
      mapLoadingBackgroundColor: greyColor,
      searchBarHintColor: secondaryColor,
      searchBarTextColor: blackColor,
      locationButtonsColor: blackColor,
      searchBarBackgroundColor: whiteColor,
      contributorBadgeForOSMTextColor: primaryColor,
      locationButtonBackgroundColor: whiteColor,
      zoomButtonsBackgroundColor: primaryColor,
      initZoom: 10,
      mapLanguage: AppProviderModule().locale,
      searchbarBorderRadius: BorderRadius.circular(10.w),
      contributorBadgeForOSMPositionTop: 12.h,
      contributorBadgeForOSMPositionBottom: 12.h,
      contributorBadgeForOSMPositionLeft: 12.w,
      contributorBadgeForOSMPositionRight: 12.w,
      markerIconOffset: 50.r,
      onError: (e) =>
          LoggerModule.log(message: e.toString(), name: runtimeType.toString()),
      contributorBadgeForOSMText: ConstantModule.appTitle,
      selectedLocationButtonTextstyle:
          BoldStyle(color: blackColor, fontSize: 14.sp).getStyle(),
      showCurrentLocationPointer: true,
      showZoomController: true,
      showSelectLocationButton: true,
      showSearchBar: true,
      showContributorBadgeForOSM: true,
      showLocationController: true,
    );
  }
}
