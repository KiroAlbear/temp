import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:deel/core/dto/models/notifications/notification_response_model.dart';
import 'package:deel/deel.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paymob/flutter_paymob.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:simple_shared_pref/simple_shared_pref.dart';

import 'core/dto/modules/admin_dio_module.dart';
import 'core/dto/modules/app_provider_module.dart';
import 'core/dto/modules/logger_module.dart';
import 'core/dto/modules/odoo_dio_module.dart';
import 'core/dto/network/app_http_overrides.dart';
import 'core/services/dependency_injection_service.dart';
import 'flavor_config.dart';
import 'firebase_options.dart';
import 'my_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await _init();

  runApp(MultiProvider(providers: _buildProviders(), child: const MyApp()));
}

Future<void> _init() async {
  await _initPaymob();
  await _initFirebase();
  _installCrashHandlers();

  await _initNotifications();
  await _initSharedPrefs();

  _initNetworkModules();

  HttpOverrides.global = AppHttpOverrides();
  await DependencyInjectionService().init();
}

Future<void> _initPaymob() async {
  await FlutterPaymob.instance.initialize(
    userTokenExpiration: 3600,
    apiKey:
        "ZXlKaGJHY2lPaUpJVXpVeE1pSXNJblI1Y0NJNklrcFhWQ0o5LmV5SmpiR0Z6Y3lJNklrMWxjbU5vWVc1MElpd2ljSEp2Wm1sc1pWOXdheUk2TVRBME9ETTJNaXdpYm1GdFpTSTZJbWx1YVhScFlXd2lmUS5nNnIyd09hek1naVM2RUQxQWxITWRmbl9zOFUwOEowRmtDZTdnRndfMGlGb3F1TERDRVJVNThBd0l5dWZJZ1B3QVd5aVlVYlQtcG9nVjVlQU8wSmxBUQ==",
    integrationID: 5106629,
    walletIntegrationId: 5106875,
    iFrameID: 926227,
  );
}

Future<void> _initFirebase() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
}

void _installCrashHandlers() {
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;

  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };
}

Future<void> _initNotifications() async {
  final messaging = FirebaseMessaging.instance;
  await messaging.setAutoInitEnabled(true);

  // 1) Ask via Firebase Messaging (iOS-focused)
  final settings = await messaging.requestPermission(
    provisional: true,
    alert: true,
    badge: true,
    sound: true,
  );

  _logNotificationAuth(settings.authorizationStatus);

  // 2) Ask via permission_handler (Android 13+ and some OEM behaviors)
  await _requestOsNotificationPermission();

  // 3) Get FCM token (works on iOS & Android)
  if (Platform.isIOS) {
    // For apple platforms, ensure the APNS token is available before making any FCM plugin API calls
    await FirebaseMessaging.instance.getAPNSToken().then((apnsToken) async {
      if (apnsToken != null) {
        print("********* apnToken $apnsToken **********");
        _updateDeviceTokenOnBackend(apnsToken);
      }
    });
  } else {
    await FirebaseMessaging.instance.getToken().then((tok) async {
      if (tok != null) {
        print("********* fcmToken $tok **********");
        _updateDeviceTokenOnBackend(tok);
      }
    });
  }

  // Token refresh
  messaging.onTokenRefresh
      .listen((newToken) {
        LoggerModule.log(
          message: "FCM token refreshed: $newToken",
          name: "fcm_token",
        );
        AppConstants.fcmToken = newToken;
        _updateDeviceTokenOnBackend(newToken);
      })
      .onError((err) {
        LoggerModule.log(
          message: "Error getting refreshed FCM token: $err",
          name: "fcm_token",
        );
      });

  // Notification open handling
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    getIt<ProductCategoryBloc>().handleNotificationNavigation(
      NotificationResponseModel.fromJson(message.data),
    );
  });
}

Future<void> _requestOsNotificationPermission() async {
  await Permission.notification.request();
}

void _updateDeviceTokenOnBackend(String token) {
  // Ideally inject these instead of newing them up here.
  AppConstants.fcmToken = token;
  final userId = SharedPrefModule().userId ?? "";
  if (userId.isEmpty) return;

  MoreBloc().updateNotificationsDeviceData(userId, token);
}

void _logNotificationAuth(AuthorizationStatus status) {
  switch (status) {
    case AuthorizationStatus.authorized:
      debugPrint('✅ Notifications authorized');
      break;
    case AuthorizationStatus.provisional:
      debugPrint('⚠️ Notifications provisionally authorized');
      break;
    default:
      debugPrint('❌ Notifications denied or not determined');
      break;
  }
}

Future<void> _initSharedPrefs() async {
  await SimpleSharedPref().init(allowEncryptAndDecrypt: false);
}

void _initNetworkModules() {
  _initDioModule(
    AdminDioModule(),
    FlavorConfig.adminApiUrl,
    'admin dio module',
  );
  _initDioModule(OdooDioModule(), FlavorConfig.apiUrl, 'odoo dio module');
}

void _initDioModule(DioModule module, String baseUrl, String logName) {
  module.baseUrl = baseUrl;
  module.init();
  module.setAppHeaders();
  LoggerModule.log(message: baseUrl, name: logName);
}

List<SingleChildWidget> _buildProviders() {
  return [
    ChangeNotifierProvider<AppProviderModule>(
      create: (_) {
        final appProvider = AppProviderModule();
        appProvider.initAppThemeAndLanguage();
        return appProvider;
      },
    ),
  ];
}
