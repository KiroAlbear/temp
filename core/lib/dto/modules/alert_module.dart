import 'package:core/dto/modules/navigation_module.dart';
import 'package:core/generated/l10n.dart';
import 'package:core/ui/contactUs/contact_us_bloc.dart';
import 'package:core/ui/contactUs/contact_us_widget.dart';
import 'package:core/ui/custom_material_banner.dart';
import 'package:core/ui/dialog_widget.dart';
import 'package:flutter/material.dart';

class AlertModule {
  // void showMessage(
  //     {required BuildContext context,
  //     required String message,
  //     List<Widget>? actions}) {
  //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: ))
  // //   ScaffoldMessenger.of(context).showMaterialBanner(MaterialBanner(
  // //     overflowAlignment: OverflowBarAlignment.start,
  // //     padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
  // //     content: CustomText(
  // //       text: message,
  // //       customTextStyle:
  // //           MediumStyle(color: Theme.of(context).primaryColor, fontSize: 14.sp),
  // //     ),
  // //     leading: ImageHelper(
  // //       image: ImageModule.icWarning,
  // //       imageType: ImageType.svg,
  // //       width: 25.w,
  // //       height: 25.h,
  // //     ),
  // //     backgroundColor: Theme.of(context).colorScheme.error,
  // //     margin: EdgeInsets.symmetric(horizontal: 5.w),
  // //     elevation: 2.r,
  // //     forceActionsBelow: true,
  // //     actions: actions ??
  // //         [
  // //           CustomButton(
  // //             idleText: S.of(context).dismiss,
  // //             onTap: () {
  // //               ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
  // //             },
  // //             textSize: 12.sp,
  // //             width: 100.w,
  // //             height: 40.h,
  // //           ),
  // //         ],
  // //   ));
  // // }
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

  /// AnimatedSnackBar
  /* void _showSnakeBar(
      Key? key, Duration duration, BuildContext context, String message) {
    AnimatedSnackBar(
      snackBarStrategy: StackSnackBarStrategy(),
      mobilePositionSettings: MobilePositionSettings(
          left: 20.w,
          right: 20.w,
          topOnAppearance: 40.h,
          bottomOnAppearance: 60.h),
      duration: const Duration(seconds: 6),
      mobileSnackBarPosition: Platform.isAndroid
          ? MobileSnackBarPosition.top
          : MobileSnackBarPosition.top,
      builder: ((context) => Container(
            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
            alignment: AppProviderModule().locale == "en"
                ? Alignment.centerLeft
                : Alignment.centerRight,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.errorContainer,
                borderRadius: BorderRadius.circular(10.w),
                border: Border.all(
                    color: CustomTheme().whichColor(
                        darkColor: cadetColor, lightColor: columbiaBlueColor))),
            child: CustomText(
                text: message,
                customTextStyle:
                    MediumStyle(color: whiteColor, fontSize: 16.sp)),
          )),
    ).show(context);
  }*/

  /// Flushbar
  /*void _showFlushBar(Key? key, Duration duration, BuildContext context, String message){
    Flushbar(
      key: key,
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      borderRadius: BorderRadius.circular(10.r),
      isDismissible: false,
      flushbarPosition: FlushbarPosition.TOP,
      duration: duration,
      backgroundColor: Theme.of(context).colorScheme.errorContainer,
      messageColor: Theme.of(context).primaryColor,
      borderColor: Theme.of(context).colorScheme.errorContainer,
      flushbarStyle: FlushbarStyle.FLOATING,
      messageText: CustomText(
          text: message,
          customTextStyle: MediumStyle(color: whiteColor, fontSize: 16.sp)),
    ).show(context);
  }*/

  /// default snack bar
  // SnackBar _snackBar(String message, BuildContext context, Duration duration) =>
  //     SnackBar(
  //       content: CustomText(
  //         text: message,
  //         customTextStyle: MediumStyle(fontSize: 14.sp, color: whiteColor),
  //       ),
  //       behavior: SnackBarBehavior.floating,
  //       duration: duration,
  //       backgroundColor: Theme.of(context).colorScheme.errorContainer,
  //       closeIconColor: whiteColor,
  //       padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
  //       shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.circular(10.w),
  //           side: BorderSide(
  //               color: CustomTheme().whichColor(
  //                   darkColor: cadetColor, lightColor: columbiaBlueColor),
  //               width: 1.w)),
  //       elevation: 0,
  //       margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
  //       clipBehavior: Clip.none,
  //       showCloseIcon: false,
  //       dismissDirection: DismissDirection.endToStart,
  //     );

  // MaterialBanner _materialBanner(String message, BuildContext context,
  //         {String leadingSvgPath = ImageModule.icClose,
  //         VoidCallback? leadingCallBack}) =>
  //     MaterialBanner(
  //       overflowAlignment: OverflowBarAlignment.start,
  //       content: CustomText(
  //         text: message,
  //         customTextStyle: MediumStyle(fontSize: 14.sp, color: whiteColor),
  //       ),
  //       backgroundColor: Theme.of(context).colorScheme.errorContainer,
  //       actions: [
  //         InkWell(
  //           child: ImageHelper(
  //             image: leadingSvgPath,
  //             imageType: ImageType.svg,
  //             color: whiteColor,
  //           ),
  //           onTap: () => leadingCallBack != null
  //               ? {
  //                   ScaffoldMessenger.of(context).clearMaterialBanners(),
  //                   leadingCallBack(),
  //                 }
  //               : ScaffoldMessenger.of(context).clearMaterialBanners(),
  //         )
  //       ],
  //       forceActionsBelow: false,
  //       dividerColor: CustomTheme()
  //           .whichColor(darkColor: cadetColor, lightColor: columbiaBlueColor),
  //       surfaceTintColor: CustomTheme()
  //           .whichColor(darkColor: cadetColor, lightColor: columbiaBlueColor),
  //       shadowColor: CustomTheme()
  //           .whichColor(darkColor: cadetColor, lightColor: columbiaBlueColor),
  //       leadingPadding: EdgeInsets.symmetric(horizontal: 50.w),
  //       padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
  //       elevation: 1.r,
  //     );

  Future<dynamic> showDialog(
      {required BuildContext context,
      required String message,
      String? confirmMessage,
      String? headerSvg,
      String? headerMessage,
      String? cancelMessage,
      VoidCallback? onCancel,
      VoidCallback? onConfirm,
      bool hasCancelButton = false,
      bool sameButtonsColor = false,
      bool errorColorInConfirm = false}) async {
    return NavigationModule().pushBottomDialog(
      widget: DialogWidget(
        message: message,
        confirmMessage: confirmMessage ?? S.of(context).ok,
        cancelMessage: cancelMessage,
        headerMessage: headerMessage,
        headerSvg: headerSvg,
        onCancel: onCancel,
        onConfirm: onConfirm,
        errorColorInConfirm: errorColorInConfirm,
        hasCloseButton: hasCancelButton,
        sameButtonsColor: sameButtonsColor,
      ),
      context: context,
    );
    // _flushBar(key, duration, context, message);
  }

  Future<dynamic> showContactUsDialog(
      {required ContactUsBloc contactUsBloc,
      required BuildContext context}) async {
    return NavigationModule().pushBottomDialog(
      widget: ContactUsWidget(
        contactUsBloc: contactUsBloc,
      ),
      context: context,
    );
    // _flushBar(key, duration, context, message);
  }

  //  showConfirmationDialog(BuildContext context, String title,
  //     String content, List<Widget>? actions) {
  //   // show the dialog
  //   showDialog(
  //     barrierDismissible: false,
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         backgroundColor: CustomTheme().backgroundColor,
  //         titleTextStyle:
  //             AvailoFonts.b2.copyWith(color: CustomTheme().mainColor),
  //         shape:
  //             RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
  //         title: Text(
  //           title,
  //           style: AvailoFonts.h5
  //               .copyWith(color: CustomTheme().mainColor, fontFamily: "Tajawal"),
  //         ),
  //         content: Text(
  //           content,
  //           style: TextStyle(color: CustomTheme().mainColor),
  //         ),
  //         actions: actions,
  //       );
  //     },
  //   );
  // }
}
