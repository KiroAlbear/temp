import 'package:deel/deel.dart';
import 'package:flutter/cupertino.dart';
import '../dto/enums/app_screen_enum.dart';
import '../dto/modules/alert_module.dart';
import '../dto/modules/custom_navigator_module.dart';
import '../generated/l10n.dart';

class Apputils {
  static showNeedToLoginDialog(BuildContext context) {
    AlertModule().showDialog(
      context: context,
      message: S.of(context).youNeedToLoginToUseApp,
      onConfirm: () {
        Future.delayed(const Duration(milliseconds: 600)).then(
          (value) {
            Routes.navigateToScreen(Routes.loginScreen, NavigationType.pushReplacementNamed, context);
            // CustomNavigatorModule.navigatorKey.currentState
            //     ?.pushReplacementNamed(AppScreenEnum.login.name);
          },
        );
      },
      cancelMessage: S.of(context).cancel,
    );
  }

  static Map<String, dynamic> convertFlaseToNullJson(
      Map<String, dynamic> json) {
    json.updateAll((key, value) => value == false ? null : value);

    return json;
  }
}
