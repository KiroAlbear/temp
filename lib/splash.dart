import 'package:flutter/material.dart';
import 'deel.dart';

class SplashScreen extends BaseStatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashWidgetState();
}

class _SplashWidgetState extends BaseState<SplashScreen> {
  @override
  PreferredSizeWidget? appBar() => null;

  @override
  void initState() {
    customBackgroundColor = primaryColor;
    Future.delayed(const Duration(seconds: 2))
        .then((value) => AppProviderModule().init(context));
    super.initState();

  }

  @override
  Color? statusBarColor() => primaryColor;

  @override
  Color? systemNavigationBarColor() => primaryColor;

  @override
  Widget getBody(BuildContext context) {
    return LogoWidget(
      logo: Assets.svg.icLogo,
    );
  }

  @override
  bool isSafeArea() => false;

  @override
  bool canPop() => false;
}
