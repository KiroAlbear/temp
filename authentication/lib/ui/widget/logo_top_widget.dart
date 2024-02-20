import 'package:core/core.dart';
import 'package:core/dto/modules/app_color_module.dart';
import 'package:core/ui/bases/base_state.dart';
import 'package:flutter/material.dart';

class LogoTopWidget extends BaseStatefulWidget {
  final bool canBack;
  final Widget child;
  final String logo;
  const LogoTopWidget({super.key, required this.canBack, required this.child, required this.logo});

  @override
  State<LogoTopWidget> createState() => _LogoTopWidgetState();
}

class _LogoTopWidgetState extends BaseState<LogoTopWidget> {
  @override
  PreferredSizeWidget? appBar() => null;

  @override
  Widget getBody(BuildContext context)=> Container(
    color: primaryColor,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: 90.h,),
        LogoWidget(height: 94.h,width: 253.h,
        logo: widget.logo),
        SizedBox(height: 67.h,),
        _bottomWidget,
      ],
    ),
  );

  Widget get _bottomWidget=> Expanded(
    child: Container(
      decoration: leftRadiusWhiteBorder,
      child: SingleChildScrollView(
        child: widget.child,
      ),
    ),
  );

  @override
  bool isSafeArea() => true;

  @override
  bool canPop() => widget.canBack;
}
