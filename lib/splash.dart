import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:package_info_plus/package_info_plus.dart';
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

          MoreBloc().checkAppUpdateStream.listen(
            (state) async {
              if (state is SuccessState) {
                PackageInfo packageInfo = await PackageInfo.fromPlatform();
                String version = packageInfo.version;
                int currentVersionNumber = _getVersionNumber(version); //0.20.0
                int latestVersionNumberAndroid = _getVersionNumber(state
                        .response
                        ?.firstWhere((element) => element.type == 0)
                        .versionNum ??
                    "0.0.0");
                int latestVersionNumberIOS = _getVersionNumber(state.response
                        ?.firstWhere((element) => element.type == 1)
                        .versionNum ??
                    "0.0.0");

                if (Platform.isAndroid &&
                    latestVersionNumberAndroid <= currentVersionNumber) {
                  AppProviderModule().init(context);
                } else if (Platform.isIOS &&
                    latestVersionNumberIOS <= currentVersionNumber) {
                  AppProviderModule().init(context);
                } else {
                  await showDialog(
                    context: context,
                    builder: (context) {
                      return DialogWidget(
                          message: "Update Required",
                          confirmMessage: "confirmMessage",
                          sameButtonsColor: true);
                    },
                  );
                }

                LoggerModule.log(
                    name: "*********", message: 'Latest app version: $version');
              } else if (value is ErrorState) {
                AppProviderModule().init(context);
              }
            },
          );

          AppProviderModule().init(context);
        },
      );
    });
    super.initState();
  }

  int _getVersionNumber(String version) {
    return int.tryParse(version.split(".")[1]) ?? 0;
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
