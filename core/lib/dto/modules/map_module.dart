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
      Container(
        height: 400.h,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.w)),
        child: OpenStreetMapSearchAndPick(
          onPicked: (pickedData) {
            onPicked(
                pickedData.latLong.latitude,
                pickedData.latLong.longitude,
                pickedData.address['state'],
                pickedData.address['village'] ?? '',
                '${pickedData.address['house_number']} / ${pickedData.address['road']}');
          },
          buttonColor: secondaryColor,
          buttonText: buttonText,
          locationPinTextStyle:
              MediumStyle(fontSize: 12.sp, color: secondaryColor).getStyle(),
          locationPinIcon: Icons.location_pin,
          zoomInIcon: Icons.zoom_in,
          zoomOutIcon: Icons.zoom_out_sharp,
          buttonTextColor: whiteColor,
          buttonTextStyle:
              MediumStyle(fontSize: 20.sp, color: whiteColor).getStyle(),
          currentLocationIcon: Icons.location_searching,
          locationPinIconColor: primaryColor,
          buttonWidth: 40.w,
          hintText: hintText,
          buttonHeight: 40.h,
        ),
      );
}
