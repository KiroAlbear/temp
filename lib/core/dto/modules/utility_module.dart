import 'dart:convert';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:package_info_plus/package_info_plus.dart';

class UtilityModule {
  /// Checks if the current device is a tablet based on screen width.
  bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width < 1100 &&
      MediaQuery.of(context).size.width >= 750;

  /// Generates a unique request ID based on the current date and time.
  ///
  /// This method creates a request ID that is designed to be unique within the
  /// context of the application. It does so by performing a series of numeric
  /// operations on the milliseconds since the epoch of the current date and time.
  /// The resulting value is then formatted as a string with a specific pattern.
  ///
  /// The generated request ID is primarily intended for use in scenarios where
  /// requests or actions need to be uniquely identified, such as when logging
  /// or tracking user activities.
  ///
  /// Returns:
  ///   A unique request ID as a string.
  ///
  /// Example usage:
  /// ```dart
  /// String uniqueRequestId = generateRequestId();
  /// print("Request ID: $uniqueRequestId");
  /// ```
  String generateRequestId() {
    // Get the current date and time
    final DateTime now = DateTime.now();

    // Extract the milliseconds since epoch
    final num millisecondsSinceEpoch = now.millisecondsSinceEpoch;

    // Perform numeric operations to create a unique value
    double uniqueValue = millisecondsSinceEpoch.toDouble();
    uniqueValue *= 12;
    uniqueValue += 4;
    uniqueValue /= 7;
    uniqueValue -= 6;

    // Convert the numeric value to a string and format it
    String requestId = uniqueValue.toString().replaceAll('.', ':');

    // Rearrange the characters to enhance randomness
    final String prefix = requestId.substring(0, 5);
    final String suffix = requestId.substring(requestId.length - 5);
    requestId = suffix +
        requestId.replaceAll(prefix, '').replaceAll(suffix, '') +
        prefix;

    // Return the generated request ID
    return requestId;
  }

  Future<void> showBottomSheetDialog({
    required Widget child,
    required BuildContext context,
    required bool useFixedHeight,
  }) async {
    await showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20.w))),
        elevation: 200,
        isScrollControlled: true,
        useRootNavigator: true,
        useSafeArea: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        builder: (context) => FractionallySizedBox(
              child: child,
              heightFactor: useFixedHeight ? 0.7 : null,
            ));
  }

  Future<String> get deviceId async {
    if (Platform.isIOS) {
      final iosInfo = await DeviceInfoPlugin().iosInfo;
      return iosInfo.identifierForVendor ?? '';
    } else if (Platform.isAndroid) {
      final androidInfo = await DeviceInfoPlugin().androidInfo;
      return androidInfo.id;
    } else {
      return "";
    }
  }

  Future<String> get deviceInfo async {
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();
    Map<String, String> data = {};
    if (Platform.isIOS) {
      final iosInfo = await DeviceInfoPlugin().iosInfo;
      data = {
        "OSType": Platform.operatingSystem,
        "OSVersion": iosInfo.systemVersion,
        "AppVersion": "v${packageInfo.version}",
        "DeviceId": iosInfo.identifierForVendor!,
        "DeviceModel": iosInfo.model + iosInfo.systemVersion,
      };
    } else if (Platform.isAndroid) {
      final androidInfo = await DeviceInfoPlugin().androidInfo;
      data = {
        "OSType": Platform.operatingSystem,
        "OSVersion": androidInfo.version.release,
        "AppVersion": "v${packageInfo.version}",
        "DeviceId": androidInfo.id,
        "DeviceModel": androidInfo.model + androidInfo.version.release,
      };
    }
    return json.encode(data);
  }
}
