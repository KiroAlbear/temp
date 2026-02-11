import 'dart:async';
import 'package:deel/deel.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_shared_pref/simple_shared_pref.dart';



// late ObjectBox objectBox;
FutureOr<void> main() async {
  /// ensure widget init



  await FirebaseMessaging.instance.setAutoInitEnabled(true);


  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    LoggerModule.log(
      message: "Notification category: ${message.category}",
      name: "FCM",
    );

    getIt<ProductCategoryBloc>().handleNotificationNavigation(
      NotificationResponseModel.fromJson(message.data),
    );
  });




  // You may set the permission requests to "provisional" which allows the user to choose what type
  // of notifications they would like to receive once the user receives a notification.



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
