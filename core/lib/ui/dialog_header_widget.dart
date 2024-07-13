import 'package:core/core.dart';
import 'package:core/dto/modules/app_color_module.dart';
import 'package:flutter/material.dart';

class DialogHeaderWidget extends StatelessWidget {
  final Widget child;
  const DialogHeaderWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) => Dialog(
    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    alignment: Alignment.bottomCenter,
    insetPadding: EdgeInsets.symmetric(vertical: 0.h),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20.w),
        topRight: Radius.circular(20.w),
      ),
    ),
    elevation: 20.w,
    clipBehavior: Clip.none,
    shadowColor: lightBlackColor,
    surfaceTintColor: Theme.of(context).scaffoldBackgroundColor,
    child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: IntrinsicHeight(
          child: child,
        )),
  );
}
