import 'dart:async';
import 'package:deel/deel.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_shared_pref/simple_shared_pref.dart';

import 'package:firebase_core/firebase_core.dart';

// late ObjectBox objectBox;
FutureOr<void> main() async {
  /// ensure widget init
  WidgetsFlutterBinding.ensureInitialized();


  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await FirebaseMessaging.instance.setAutoInitEnabled(true);




  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
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
