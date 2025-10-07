import 'dart:async';
import 'dart:math';
import 'package:deel/deel.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paymob/flutter_paymob.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:simple_shared_pref/simple_shared_pref.dart';

import 'core/dto/modules/admin_dio_module.dart';
import 'core/dto/modules/app_provider_module.dart';
import 'core/dto/modules/logger_module.dart';
import 'core/dto/modules/odoo_dio_module.dart';
import 'core/dto/network/app_http_overrides.dart';
import 'core/services/dependency_injection_service.dart';
import 'flavors.dart';
import 'my_app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

// late ObjectBox objectBox;
FutureOr<void> main() async {
  /// ensure widget init
  WidgetsFlutterBinding.ensureInitialized();

  await FlutterPaymob.instance.initialize(
      userTokenExpiration: 3600, // optional, default is 30 days
      apiKey:
          "ZXlKaGJHY2lPaUpJVXpVeE1pSXNJblI1Y0NJNklrcFhWQ0o5LmV5SmpiR0Z6Y3lJNklrMWxjbU5vWVc1MElpd2ljSEp2Wm1sc1pWOXdheUk2TVRBME9ETTJNaXdpYm1GdFpTSTZJbWx1YVhScFlXd2lmUS5nNnIyd09hek1naVM2RUQxQWxITWRmbl9zOFUwOEowRmtDZTdnRndfMGlGb3F1TERDRVJVNThBd0l5dWZJZ1B3QVd5aVlVYlQtcG9nVjVlQU8wSmxBUQ==", //  // from dashboard Select Settings -> Account Info -> API Key
      integrationID: 5106629,
      walletIntegrationId: 5106875,
      iFrameID: 926227);

  ///
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await FirebaseMessaging.instance.setAutoInitEnabled(true);
  // You may set the permission requests to "provisional" which allows the user to choose what type
  // of notifications they would like to receive once the user receives a notification.

  // For apple platforms, ensure the APNS token is available before making any FCM plugin API calls
  final apnsToken = await FirebaseMessaging.instance.getAPNSToken().then(
    (apnsToken) async {
      if (apnsToken != null) {
        print("********* fcmToken $apnsToken **********");
      }
    },
  );

  final notificationSettings =
      await FirebaseMessaging.instance.requestPermission(
    provisional: true,
    alert: true,
    badge: true,
    sound: true,
  );

  // Android 13+: Request permission
  // if (defaultTargetPlatform == TargetPlatform.android) {
  //   if (await Permission.notification.isDenied ||
  //       await Permission.notification.isPermanentlyDenied) {
  //     await Permission.notification.request();
  //   }
  // }

  await requestNotificationPermissions();

  final String? tok = await FirebaseMessaging.instance.getToken().then(
    (tok) async {
      if (tok != null) {
        print("********* fcmToken $tok **********");
      }
    },
  );

  FirebaseMessaging.instance.onTokenRefresh.listen((fcmToken) {
    // print("********* fcm Token $fcmToken **********");
    LoggerModule.log(
        message: "********* fcm Token $fcmToken **********", name: "fcm Token");
  }).onError((err) {
    // print("********* error getting device fcm Token **********");
    LoggerModule.log(
        message: "********* error getting device fcm Token **********",
        name: "fcm Token");
  });

  if (notificationSettings.authorizationStatus ==
      AuthorizationStatus.authorized) {
    debugPrint('✅ Notifications authorized');
  } else if (notificationSettings.authorizationStatus ==
      AuthorizationStatus.provisional) {
    debugPrint('⚠️ Notifications provisionally authorized');
  } else {
    debugPrint('❌ Notifications denied');
  }

  F.appFlavor ??= Flavor.app_stage;

  if (F.apiUrl.isEmpty) {
    F.apiUrl = 'https://deel-demo.odoo.com/';
  }

  if (F.adminApiUrl.isEmpty) {
    F.adminApiUrl = 'https://adminapi.deel-app.com/api/';
  }

  // if (kDebugMode) {
  //   // Force disable Crashlytics collection while doing every day development.
  //   // Temporarily toggle this to true if you want to test crash reporting in your app.
  //   await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(false);
  // } else
  {
    await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
    // Handle Crashlytics enabled status when not in Debug,
    // e.g. allow your users to opt-in to crash reporting.
  }

  /// init shared preferences as simple shared pref plugin
  await SimpleSharedPref().init(allowEncryptAndDecrypt: false);

  /// add logger with all fatal errors to crashlytics
  // addFireBaseCrashReporting();

  /// set base url for dioModule
  _initOdooDio();
  _initAdminDio();
  LoggerModule.log(message: AdminDioModule().baseUrl, name: 'admin dio module');
  LoggerModule.log(message: OdooDioModule().baseUrl, name: 'odoo dio module');

  /// allow Chucker to show in release mode
  ChuckerFlutter.showOnRelease = true;
  HttpOverrides.global = AppHttpOverrides();
  await DependencyInjectionService().init();

  /// run app and use provider for app config
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<AppProviderModule>(create: (_) {
      AppProviderModule appProviderModule = AppProviderModule();
      appProviderModule.initAppThemeAndLanguage();
      return appProviderModule;
    }),
  ], child: const MyApp()));
  // _runAppWithSentry();
}

Future<void> requestNotificationPermissions() async {
  final PermissionStatus status = await Permission.notification.request();
  if (status.isGranted) {
    // Notification permissions granted
  } else if (status.isDenied) {
    // Notification permissions denied
  } else if (status.isPermanentlyDenied) {
    // Notification permissions permanently denied, open app settings
    await openAppSettings();
  }
}

void _initAdminDio() {
  AdminDioModule().baseUrl = F.adminApiUrl;
  AdminDioModule().init();
  AdminDioModule().setAppHeaders();
}

void _initOdooDio() {
  OdooDioModule().baseUrl = F.apiUrl;
  OdooDioModule().init();
  OdooDioModule().setAppHeaders();
}

// void addFireBaseCrashReporting() {
//   FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
//   PlatformDispatcher.instance.onError = (error, stack) {
//     FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
//     return true;
//   };
// }

void _runAppWithSentry() async {
  // await SentryFlutter.init(
  //   (options) {
  //     options.dsn =
  //         'https://b3a964f4ec88da9c00d953c418f89192@o4506076199845888.ingest.sentry.io/4506076200894464';
  //     options.tracesSampleRate = 1.0;
  //     options.anrEnabled = true;
  //   },
  //   appRunner: () => runApp(MultiProvider(providers: [
  //     ChangeNotifierProvider<AppProviderModule>(
  //         create: (_) {
  //           AppProviderModule appProviderModule = AppProviderModule();
  //           appProviderModule.initAppThemeAndLanguage();
  //           return appProviderModule;
  //         }),
  //   ], child: MyApp())),
  // );
}
