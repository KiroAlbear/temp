import 'dart:async';

import 'package:core/core.dart';
import 'package:core/dto/modules/admin_dio_module.dart';
import 'package:core/dto/modules/app_provider_module.dart';
import 'package:core/dto/modules/logger_module.dart';
import 'package:core/dto/modules/odoo_dio_module.dart';
import 'package:core/dto/network/app_http_overrides.dart';
import 'package:flutter/material.dart';

import 'flavors.dart';
import 'my_app.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'firebase_options.dart';
// late ObjectBox objectBox;
FutureOr<void> main() async {
  /// ensure widget init
  // await Firebase.initializeApp(
  //     options: DefaultFirebaseOptions.currentPlatform,
  // );
  WidgetsFlutterBinding.ensureInitialized();

  /// initialize firebase application
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );

  /// init shared preferences as simple shared pref plugin
  await SimpleSharedPref().init(allowEncryptAndDecrypt: false);
  // if (SharedPrefModule().userId != null) {
  //   FirebaseCrashlytics.instance
  //       .setUserIdentifier(SharedPrefModule().userId?? '');
  // }
  //
  // /// enable crashlytics collection
  // FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);

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
