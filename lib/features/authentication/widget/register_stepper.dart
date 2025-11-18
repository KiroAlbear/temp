import 'dart:io';

import 'package:deel/deel.dart';
import 'package:deel/features/bottom_navigation/ui/bottomNavigation/bottom_navigation_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_loader/image_helper.dart';

import '../../../../core/dto/enums/app_screen_enum.dart';
import '../../../../core/dto/modules/app_color_module.dart';
import '../../../../core/dto/modules/custom_text_style_module.dart';
import '../../../../core/generated/l10n.dart';
import '../../../../core/ui/bases/bloc_base.dart';
import '../../../../core/ui/custom_text.dart';
import '../../../../core/ui/logo_widget.dart';

class RegisterStepperWidget extends StatefulWidget {
  final Widget child;

  const RegisterStepperWidget({
    super.key,
    required this.child,
  });

  @override
  State<RegisterStepperWidget> createState() => _RegisterStepperWidgetState();
}

class _RegisterStepperWidgetState extends State<RegisterStepperWidget> {
  @override
  Widget build(BuildContext context) => Container(
        padding: EdgeInsets.only(top: 30),
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 50.h,
            ),
            _bottomWidget,
          ],
        ),
      );

  Widget get _bottomWidget => Expanded(
        child: SingleChildScrollView(
          child: widget.child,
        ),
      );
}
