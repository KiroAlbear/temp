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
  Widget getBody(BuildContext context) => const Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            bottom: 0,
            child: LogoWidget(
              logo: Assets.svgIcLogo,
            ),
          ),
        ],
      );

  @override
  bool isSafeArea() => true;

  @override
  bool canPop() => false;
}
