import 'dart:async';
import 'dart:math';
import 'package:deel/core/dto/models/notifications/notification_response_model.dart';
import 'package:deel/deel.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paymob/flutter_paymob.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:shorebird_code_push/shorebird_code_push.dart';
import 'package:simple_shared_pref/simple_shared_pref.dart';
import 'package:url_launcher/url_launcher.dart';

import 'core/dto/modules/admin_dio_module.dart';
import 'core/dto/modules/app_provider_module.dart';
import 'core/dto/modules/logger_module.dart';
import 'core/dto/modules/odoo_dio_module.dart';
import 'core/dto/network/app_http_overrides.dart';
import 'core/services/dependency_injection_service.dart';
import 'flavor_config.dart';
import 'flavors.dart';
import 'my_app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

// late ObjectBox objectBox;
FutureOr<void> main() async {
  /// ensure widget init
  WidgetsFlutterBinding.ensureInitialized();


  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await FirebaseMessaging.instance.setAutoInitEnabled(true);




  await FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    print(message.category);

    getIt<ProductCategoryBloc>().handleNotificationNavigation(
      NotificationResponseModel.fromJson(message.data),
    );
  });

  FirebaseMessaging.instance.onTokenRefresh
      .listen((fcmToken) {
    // print("********* fcm Token $fcmToken **********");
    LoggerModule.log(
      message: "********* fcm Token $fcmToken **********",
      name: "fcm Token",
    );
  })
      .onError((err) {
    // print("********* error getting device fcm Token **********");
    LoggerModule.log(
      message: "********* error getting device fcm Token **********",
      name: "fcm Token",
    );
  });



  // You may set the permission requests to "provisional" which allows the user to choose what type
  // of notifications they would like to receive once the user receives a notification.

  if (Platform.isIOS) {
    // For apple platforms, ensure the APNS token is available before making any FCM plugin API calls
     await FirebaseMessaging.instance.getAPNSToken().then((apnsToken) async {
      if (apnsToken != null) {
        print("********* apnToken $apnsToken **********");

        AppConstants.fcmToken = apnsToken;
        MoreBloc().updateNotificationsDeviceData(
          SharedPrefModule().userId ?? "",
          apnsToken,
        );
      }
    });
  } else {
    await FirebaseMessaging.instance.getToken().then((tok) async {
      if (tok != null) {
        print("********* fcmToken $tok **********");
        AppConstants.fcmToken = tok;

        MoreBloc().updateNotificationsDeviceData(
          SharedPrefModule().userId ?? "",
          tok,
        );
      }
    });
  }

  await SimpleSharedPref().init(allowEncryptAndDecrypt: false);

  HttpOverrides.global = AppHttpOverrides();
  _initOdooDio();
  _initAdminDio();


  await DependencyInjectionService().init();

  Future.microtask(() {
    _checkInstantUpdate();
    _checkAppUpdate();
  },);

  /// run app and use provider for app config
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<AppProviderModule>(
          create: (_) {
            AppProviderModule appProviderModule = AppProviderModule();
            appProviderModule.initAppThemeAndLanguage();
            return appProviderModule;
          },
        ),
      ],
      child: const MyApp(),
    ),
  );
}


void _checkInstantUpdate(){
  LoggerModule.log(name: "*********", message: 'Checking for instant updates...');
  Apputils.updateAndRestartApp(Routes.rootNavigatorKey.currentContext!);
}

void _checkAppUpdate(){
  LoggerModule.log(name: "*********", message: 'Checking for App updates...');
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
        // AppProviderModule().init(context);
      } else if (Platform.isIOS &&
          Apputils.icCurrentVersionValid(
            currentVersion: version,
            latestVersion: latestVersionNumberIOS,
          )) {
        // AppProviderModule().init(context);
      } else {
        {
          await showDialog(
            context: Routes.rootNavigatorKey.currentContext!,
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
      LoggerModule.log(
        name: "*********",
        message: 'Failed to get app version',
      );
    }
  });
}

void _initAdminDio() {
  AdminDioModule().baseUrl = FlavorConfig.adminApiUrl;
  AdminDioModule().init();
  AdminDioModule().setAppHeaders();
}

void _initOdooDio() {
  OdooDioModule().baseUrl = FlavorConfig.apiUrl;
  OdooDioModule().init();
  OdooDioModule().setAppHeaders();
}
