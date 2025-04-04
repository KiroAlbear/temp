import 'package:deel/deel.dart';
import 'package:flutter/material.dart';
import '../../generated/l10n.dart';

class AlertModule {

  static final AlertModule _instance = AlertModule.internal();

  AlertModule.internal();

  factory AlertModule() => _instance;

  bool isBannerShowed = false;

  Future<void> showMessage(
      {required BuildContext context,
      required String message,
      Key? key,
      VoidCallback? onDismiss,
      List<Widget> actions = const [],
      VoidCallback? leadingCallBack,
      MaterialBannerType materialBannerType = MaterialBannerType.error}) async {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // ScaffoldMessenger.maybeOf(context)!
      //     .showSnackBar(_snackBar(message, context, duration))
      //     .closed
      //     .then((value) {
      //   if (onDismiss != null) onDismiss();
      // });
      if (isBannerShowed) {
        ScaffoldMessenger.maybeOf(context)?.hideCurrentMaterialBanner();
        isBannerShowed = false;
      } else {
        isBannerShowed = true;
      }
      if (message.isNotEmpty) {
        ScaffoldMessenger.maybeOf(context)!
            .showMaterialBanner(CustomMaterialBanner(
              context: context,
              message: message,
              leadingCallBack: leadingCallBack,
              materialBannerType: materialBannerType,
              actions: actions,
            ))
            .closed
            .then((value) {
          isBannerShowed = false;
          if (onDismiss != null) onDismiss();
        });
      }
    });
    Future.delayed(const Duration(seconds: 4)).then((value) {
      if (materialBannerType != MaterialBannerType.info) {
        isBannerShowed = false;
        ScaffoldMessenger.maybeOf(context)?.hideCurrentMaterialBanner();
      }
    });
    // _showSnakeBar(key, duration, context, message);
  }
  //
  // Future<dynamic> showDialog(
  //     {required BuildContext context,
  //     required String message,
  //     String? confirmMessage,
  //     String? headerSvg,
  //     String? headerMessage,
  //     String? cancelMessage,
  //     VoidCallback? onCancel,
  //     VoidCallback? onConfirm,
  //     bool hasCancelButton = false,
  //     bool sameButtonsColor = false,
  //     bool errorColorInConfirm = false}) async {
  //   return NavigationModule().pushBottomDialog(
  //     widget: DialogWidget(
  //       message: message,
  //       confirmMessage: confirmMessage ?? S.of(context).ok,
  //       cancelMessage: cancelMessage,
  //       headerMessage: headerMessage,
  //       headerSvg: headerSvg,
  //       onCancel: onCancel,
  //       onConfirm: onConfirm,
  //       errorColorInConfirm: errorColorInConfirm,
  //       hasCloseButton: hasCancelButton,
  //       sameButtonsColor: sameButtonsColor,
  //     ),
  //     context: context,
  //   );
  //   // _flushBar(key, duration, context, message);
  // }

  Future<dynamic> showContactUsBottomSheet(
      {required ContactUsBloc contactUsBloc,
      required BuildContext context}) async {

    showModalBottomSheet(
      useRootNavigator: true,
      constraints: BoxConstraints(
          maxHeight:
          MediaQuery.of(context).size.height * 0.30),
      context: context, builder: (context) {
      return ContactUsWidget(
        contactUsBloc: contactUsBloc,
      );
    },);

  }

}
