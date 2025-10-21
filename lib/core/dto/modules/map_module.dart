import 'package:deel/deel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_loader/image_helper.dart';
import 'package:open_street_map_search_and_pick/open_street_map_search_and_pick.dart';

import 'app_color_module.dart';
import 'custom_text_style_module.dart';

class MapModule {
  Widget loadMap(
          {required Function(double latitude, double longitude, String city,
                  String area, String address)
              onPicked,
          required String hintText,
          required String buttonText,
          double? latitude,
          double? longitude}) =>
      OpenStreetMapSearchAndPick(
        textFieldProgressBarColor: primaryColor,
        onPicked: (pickedData) {
          onPicked(
              pickedData.latLong.latitude,
              pickedData.latLong.longitude,
              pickedData.address['state'] ?? "",
              pickedData.address['village'] ?? '',
              '${pickedData.address['house_number'] ?? ""} / ${pickedData.address['road'] ?? ""}');
        },
        buttonColor: primaryColor,
        searchBorderColor: darkSecondaryColor,
        buttonText: buttonText,
        hintStyle: MediumStyle(fontSize: 14.sp, color: lightGreyColorLightMode)
            .getStyle(),
        locationPinTextStyle:
            MediumStyle(fontSize: 12.sp, color: lightBlackColor).getStyle(),
        locationPinIcon: Icons.location_pin,
        zoomInIcon: Icons.zoom_in,
        zoomOutIcon: Icons.zoom_out_sharp,
        buttonTextColor: lightBlackColor,
        backArrowWidget: InkWell(
          onTap: () {
            Navigator.of(Routes.rootNavigatorKey.currentContext!).pop();
          },
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
            child: ImageHelper(
                image: Assets.svg.icPreviousBlue, imageType: ImageType.svg),
          ),
        ),
        buttonTextStyle:
            MediumStyle(fontSize: 16.sp, color: lightBlackColor).getStyle(),
        currentLocationIcon: Icons.location_searching,
        locationPinIconColor: redColor,
        setLocationButtonBorderRadious: 10,
        searchSuffixIcon: Icons.search,
        buttonWidth: double.infinity,
        buttonHeight: 70.h,
        hintText: hintText,
        latitude: latitude,
        longitude: longitude,
      );
}
