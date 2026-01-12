import 'package:deel/deel.dart';
import 'package:deel/features/announcements/bloc/announcements_bloc.dart'
    show AnnouncementsBloc;
import 'package:deel/features/announcements/ui/announcements_dialog_widget.dart';
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

  static void showAnnouncementsDialog() {
    getIt<AnnouncementsBloc>().announcementsStream.listen(
      (event) async {
        if (event is SuccessState) {
          WidgetsBinding.instance.addPostFrameCallback(
              (timeStamp) async {
                if(event.response?.isEmpty ?? true){
                  return;
                }else{
                  showDialog(
                    context: Routes.rootNavigatorKey.currentContext!,
                    builder: (context) {
                      return AnnouncementsDialogWidget(items: event.response!);
                    },
                  );
                }

            },
          );
        }
      },
    );
  }

  static bool icCurrentVersionValid(
      {required String currentVersion, required String latestVersion}) {
    List<int> a = currentVersion.split('.').map(int.parse).toList();
    List<int> b = latestVersion.split('.').map(int.parse).toList();

    int maxLen = a.length > b.length ? a.length : b.length;
    for (int i = 0; i < maxLen; i++) {
      int x = i < a.length ? a[i] : 0;
      int y = i < b.length ? b[i] : 0;

      if (x > y) return true; // v1 > v2
      if (x < y) return false; // v1 < v2
    }
    return true; // equal
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
              title: const Text('التحديث جاهز'),
              content: const Text(
                  "تم تنزيل التحديث وسيتم تطبيقه عند إعادة تشغيل التطبيق. يرجى إعادة تشغيل التطبيق لتطبيق التحديث."),
              actions: [
                TextButton(
                  onPressed: () async {
                    Navigator.of(context).pop();
                  },
                  child: const Text('موافق'),
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
