import 'package:core/core.dart';
import 'package:core/dto/modules/app_color_module.dart';
import 'package:core/dto/modules/custom_text_style_module.dart';
import 'package:flutter/material.dart';
import 'package:open_street_map_search_and_pick/open_street_map_search_and_pick.dart';

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
        mapHeight: 330.h,
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
        buttonText: buttonText,
        locationPinTextStyle:
            MediumStyle(fontSize: 12.sp, color: lightBlackColor).getStyle(),
        locationPinIcon: Icons.location_pin,
        zoomInIcon: Icons.zoom_in,
        zoomOutIcon: Icons.zoom_out_sharp,
        buttonTextColor: lightBlackColor,
        buttonTextStyle:
            MediumStyle(fontSize: 16.sp, color: lightBlackColor).getStyle(),
        currentLocationIcon: Icons.location_searching,
        locationPinIconColor: redColor,
        setLocationButtonBorderRadious: 10,
        buttonWidth: double.infinity,
        buttonHeight: 70.h,
        hintText: hintText,
        latitude: latitude,
        longitude: longitude,
      );
}
