import 'package:flutter/material.dart';

class CustomNavigatorModule {
  // Singleton instance of the CustomNavigatorModule.
  static final CustomNavigatorModule _instance =
      CustomNavigatorModule.internal();

  CustomNavigatorModule.internal();

  // Factory constructor to return the singleton instance.
  factory CustomNavigatorModule() {
    return _instance;
  }

  // GlobalKey to access the navigator state.
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();
}
