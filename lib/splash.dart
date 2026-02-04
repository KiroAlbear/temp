import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paymob/flutter_paymob.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:logger/logger.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shorebird_code_push/shorebird_code_push.dart';
import 'package:url_launcher/url_launcher.dart';
import 'core/Utils/firebase_analytics_events_names.dart';
import 'core/Utils/firebase_analytics_utl.dart';
import 'core/dto/models/notifications/notification_response_model.dart';
import 'deel.dart';
import 'flavor_config.dart';

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

    _initPaymob();

    FirebaseAnalytics.instance.setAnalyticsCollectionEnabled(true);
    FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);

    if (F.appFlavor == Flavor.app_test ) {
      AppProviderModule().init(context);
      return;
    }

    FirebaseAnalyticsUtil().logEvent(FirebaseAnalyticsEventsNames.app_start);
    // if (mounted)
    {
      Apputils.updateAndRestartApp();
      Future.delayed(const Duration(seconds: 1)).then((value) async {
        requestNotificationPermissions();

        FirebaseAnalyticsUtil().logEvent(
          FirebaseAnalyticsEventsNames.app_start,
        );

        // if (mounted)
        {
          LoggerModule.log(
            name: "*********",
            message: 'Checking for updates...',
          );
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
            } else if (state is FailedState) {
              AppProviderModule().init(context);
            }
          });
        }
      });
    }

    super.initState();
  }

  Future<void> _initPaymob() async {
    await FlutterPaymob.instance.initialize(
      userTokenExpiration: 3600, // optional, default is 30 days
      apiKey:
          "ZXlKaGJHY2lPaUpJVXpVeE1pSXNJblI1Y0NJNklrcFhWQ0o5LmV5SmpiR0Z6Y3lJNklrMWxjbU5vWVc1MElpd2ljSEp2Wm1sc1pWOXdheUk2TVRBME9ETTJNaXdpYm1GdFpTSTZJbWx1YVhScFlXd2lmUS5nNnIyd09hek1naVM2RUQxQWxITWRmbl9zOFUwOEowRmtDZTdnRndfMGlGb3F1TERDRVJVNThBd0l5dWZJZ1B3QVd5aVlVYlQtcG9nVjVlQU8wSmxBUQ==", //  // from dashboard Select Settings -> Account Info -> API Key
      integrationID: 5106629,
      walletIntegrationId: 5106875,
      iFrameID: 926227,
    );
  }

  Future<void> requestNotificationPermissions() async {
    final notificationSettings = await FirebaseMessaging.instance
        .requestPermission(
          provisional: true,
          alert: true,
          badge: true,
          sound: true,
        );

    if (notificationSettings.authorizationStatus ==
        AuthorizationStatus.authorized) {
      debugPrint('✅ Notifications authorized');
    } else if (notificationSettings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      debugPrint('⚠️ Notifications provisionally authorized');
    } else {
      debugPrint('❌ Notifications denied');
    }

    // final PermissionStatus status = await Permission.notification.request();
    // if (status.isGranted) {
    //   // Notification permissions granted
    // } else if (status.isDenied) {
    //   // Notification permissions denied
    // } else if (status.isPermanentlyDenied) {
    //   // Notification permissions permanently denied, open app settings
    //   // await openAppSettings();
    // }
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
