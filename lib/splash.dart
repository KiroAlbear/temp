import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:logger/logger.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shorebird_code_push/shorebird_code_push.dart';
import 'package:url_launcher/url_launcher.dart';
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

    if (F.appFlavor == Flavor.app_stage) {
      AppProviderModule().init(context);
      return;
    }

    Future.delayed(const Duration(seconds: 2)).then((value) async {
      FirebaseAnalyticsUtil().logEvent(FirebaseAnalyticsEventsNames.app_start);

      if (mounted) {
        await Apputils.updateAndRestartApp(context);
        LoggerModule.log(name: "*********", message: 'Checking for updates...');
        MoreBloc().checkAppUpdateStream.listen((state) async {
          if (state is SuccessState) {
            PackageInfo packageInfo = await PackageInfo.fromPlatform();
            String version = packageInfo.version;

            String latestVersionNumberAndroid =
                state.response
                    ?.firstWhere((element) => element.type == 0)
                    .versionNum ??
                "0.0.0";
            String latestVersionNumberIOS =
                state.response
                    ?.firstWhere((element) => element.type == 1)
                    .versionNum ??
                "0.0.0";

            if (Platform.isAndroid &&
                Apputils.icCurrentVersionValid(
                  currentVersion: version,
                  latestVersion: latestVersionNumberAndroid,
                )) {
              AppProviderModule().init(context);
            } else if (Platform.isIOS &&
                Apputils.icCurrentVersionValid(
                  currentVersion: version,
                  latestVersion: latestVersionNumberIOS,
                )) {
              AppProviderModule().init(context);
            } else {
              if (mounted) {
                await showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) {
                    return PopScope(
                      canPop: false,
                      child: AlertDialog(
                        title: const Text('تحديث'),
                        content: const Text(
                          "الرجاء تحديث التطبيق إلى أحدث إصدار للمتابعة",
                        ),
                        actions: [
                          TextButton(
                            onPressed: () async {
                              String updateUrl = "";
                              if (Platform.isIOS) {
                                updateUrl = AppConstants.iosUpdateUrl;
                              } else {
                                updateUrl = AppConstants.androidUpdateUrl;
                              }
                              final uri = Uri.parse(updateUrl);
                              await launchUrl(uri);
                            },
                            child: const Text('تحديث'),
                          ),
                        ],
                      ),
                    );
                  },
                );
              }
            }

            LoggerModule.log(
              name: "*********",
              message: 'Latest app version: $version',
            );
          } else if (value is FailedState) {
            AppProviderModule().init(context);
          }
        });
      }
    });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
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
      child: LogoWidget(logo: Assets.svg.icLogo),
    );
  }

  @override
  bool isSafeArea() => false;

  @override
  bool canPop() => false;
}
