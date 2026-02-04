import 'package:deel/deel.dart';
import 'package:flutter/material.dart';

class AlertModule {
  static final AlertModule _instance = AlertModule.internal();

  AlertModule.internal();

  factory AlertModule() => _instance;

  bool isBannerShowed = false;

  Future<void> showMessage({
    required BuildContext context,
    required String message,
    Key? key,
    VoidCallback? onDismiss,
    List<Widget> actions = const [],
    VoidCallback? leadingCallBack,
    MaterialBannerType materialBannerType = MaterialBannerType.error,
  }) async {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (isBannerShowed) {
        ScaffoldMessenger.maybeOf(context)?.hideCurrentMaterialBanner();
        isBannerShowed = false;
      } else {
        isBannerShowed = true;
      }
      if (message.isNotEmpty) {
        ScaffoldMessenger.maybeOf(context)!
            .showMaterialBanner(
              CustomMaterialBanner(
                context: context,
                message: message,
                leadingCallBack: leadingCallBack,
                materialBannerType: materialBannerType,
                actions: actions,
              ),
            )
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

  Future<dynamic> showContactUsBottomSheet({
    required ContactUsBloc contactUsBloc,
    required BuildContext context,
  }) async {
    showModalBottomSheet(
      useRootNavigator: true,
      isScrollControlled: false,
      context: context,
      builder: (context) {
        return Padding(
          padding: AppConstants.isHavingBottomPadding
              ? const EdgeInsets.only(bottom: 32.0)
              : EdgeInsets.zero,
          child: ContactUsWidget(contactUsBloc: contactUsBloc),
        );
      },
    );
  }
}
