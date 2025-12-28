import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:shorebird_code_push/shorebird_code_push.dart';
import 'core/Utils/firebase_analytics_events_names.dart';
import 'core/Utils/firebase_analytics_utl.dart';
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
    FirebaseAnalytics.instance.setAnalyticsCollectionEnabled(true);

    Future.delayed(const Duration(seconds: 2)).then((value) async {
      FirebaseAnalyticsUtil().logEvent(FirebaseAnalyticsEventsNames.app_start);

      WidgetsBinding.instance.addPostFrameCallback(
        (timeStamp) async {
          await Apputils.updateAndRestartApp(context);
          AppProviderModule().init(context);
        },
      );
    });
    super.initState();
  }

  @override
  Color? statusBarColor() => primaryColor;

  @override
  Color? systemNavigationBarColor() => primaryColor;

  @override
  double appTopPadding() => 0;

  @override
  Widget getBody(BuildContext context) {
    return Container(
      color: primaryColor,
      child: LogoWidget(
        logo: Assets.svg.icLogo,
      ),
    );
  }

  @override
  bool isSafeArea() => false;

  @override
  bool canPop() => false;
}
