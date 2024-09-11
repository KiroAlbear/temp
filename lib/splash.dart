import 'package:core/core.dart';
import 'package:core/dto/modules/app_color_module.dart';
import 'package:core/dto/modules/app_provider_module.dart';
import 'package:core/ui/bases/base_state.dart';
import 'package:dokkan/generated/assets.dart';
import 'package:flutter/material.dart';

class SplashWidget extends BaseStatefulWidget {
  const SplashWidget({super.key});

  @override
  State<SplashWidget> createState() => _SplashWidgetState();
}

class _SplashWidgetState extends BaseState<SplashWidget> {
  @override
  PreferredSizeWidget? appBar() => null;

  @override
  void initState() {
    customBackgroundColor = primaryColor;
    super.initState();
    Future.delayed(const Duration(seconds: 2))
        .then((value) => AppProviderModule().init(context));
  }

  @override
  Color? statusBarColor() => primaryColor;

  @override
  Widget getBody(BuildContext context) {
    return LogoWidget(
      logo: Assets.svgIcLogo,
    );
  }

  @override
  bool isSafeArea() => false;

  @override
  bool canPop() => false;
}
