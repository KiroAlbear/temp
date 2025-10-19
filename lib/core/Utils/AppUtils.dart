import 'package:deel/deel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../dto/enums/app_screen_enum.dart';
import '../dto/modules/alert_module.dart';
import '../generated/l10n.dart';

class Apputils {
  static Future<void> showNeedToLoginBottomSheet(BuildContext context) async {
    await showModalBottomSheet(
      context: context,
      useRootNavigator: true,
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.25,
      ),
      builder: (context) {
      return DialogWidget(
        message: S.of(context).youNeedToLoginToUseApp,
        confirmMessage: S.of(context).ok,
        sameButtonsColor: false,
        onConfirm: () {
          Routes.navigateToScreen(Routes.loginPage, NavigationType.goNamed, context);
        },
        cancelMessage: S.of(context).cancel,
      );
    },);

    // AlertModule().showDialog(
    //   context: context,
    //   message: S.of(context).youNeedToLoginToUseApp,
    //   confirmMessage: S.of(context).ok,
    //   onConfirm: () {
    //     Future.delayed(const Duration(milliseconds: 600)).then(
    //       (value) {
    //         Routes.navigateToScreen(Routes.loginScreen, NavigationType.pushReplacementNamed, context);
    //         // CustomNavigatorModule.navigatorKey.currentState
    //         //     ?.pushReplacementNamed(AppScreenEnum.login.name);
    //       },
    //     );
    //   },
    //   cancelMessage: S.of(context).cancel,
    // );
  }


  static formatMobilePhone(String phone){
    return phone.contains("+20")?phone.replaceAll("+20", "+2"):phone;
  }

  static Map<String, dynamic> convertFlaseToNullJson(
      Map<String, dynamic> json) {
    json.updateAll((key, value) => value == false ? null : value);

    return json;
  }
}
