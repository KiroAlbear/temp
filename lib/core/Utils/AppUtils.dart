import 'package:deel/deel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shorebird_code_push/shorebird_code_push.dart';
import '../dto/enums/app_screen_enum.dart';
import '../dto/modules/alert_module.dart';
import '../generated/l10n.dart';

class Apputils {
  static Future<void> showNeedToLoginBottomSheet(BuildContext context) async {
    await showModalBottomSheet(
      context: context,
      useRootNavigator: true,
      builder: (context) {
        return DialogWidget(
          message: S.of(context).youNeedToLoginToUseApp,
          confirmMessage: S.of(context).ok,
          sameButtonsColor: false,
          onConfirm: () {
            Routes.navigateToScreen(
                Routes.loginPage, NavigationType.goNamed, context);
          },
          cancelMessage: S.of(context).cancel,
        );
      },
    );
  }

  static Future<void> updateAndRestartApp(BuildContext context) async {
    final shorebirdCodePush = ShorebirdUpdater();
    // Check for updates and prompt the user to restart if one is available.
    final UpdateStatus status = await shorebirdCodePush.checkForUpdate();

    // print('************** Shorebird status: $status *****');

    if (status == UpdateStatus.outdated) {
      // Download the update.
      try {
        await shorebirdCodePush.update();

        await showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return AlertDialog(
              title: const Text('Update Ready'),
              content: const Text(
                  'An update has been downloaded and will be applied when the app restarts. Please restart the app to apply the update.'),
              actions: [
                TextButton(
                  onPressed: () async {
                    Navigator.of(context).pop();
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      } catch (e) {
        LoggerModule.log(message: "${e.toString()}", name: "Update Error");
        await showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Update Error'),
              content: Text('${e.toString()}'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      }

      // Optionally, notify the user that an update is ready and they should restart.
      // In a real app, you might show a dialog or snackbar here.
      print('Update downloaded. Please restart the app to apply the changes.');
    }
  }

  static String getFormattedAddress(Map<dynamic, dynamic> address) {
    String formattedAddress = '';

    if ((address['house_number'] as String?) != null) {
      formattedAddress += '${address['house_number']} /';
    }

    if ((address['road'] as String?) != null) {
      formattedAddress += ' ${address['road']} /';
    }

    if ((address['village'] as String?) != null) {
      formattedAddress += ' ${address['village']} /';
    }

    if ((address['state'] as String?) != null) {
      formattedAddress += ' ${address['state']}';
    }
    return formattedAddress;
  }

  static formatMobilePhone(String phone) {
    return phone.contains("+20") ? phone.replaceAll("+20", "+2") : phone;
  }

  static Map<String, dynamic> convertFlaseToNullJson(
      Map<String, dynamic> json) {
    json.updateAll((key, value) => value == false ? null : value);

    return json;
  }
}
