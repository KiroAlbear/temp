import 'package:deel/core/dto/modules/shared_pref_module.dart';
import 'package:deel/core/routes/navigation_type.dart';
import 'package:deel/core/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import '../enums/app_screen_enum.dart';
import '../models/baseModules/api_state.dart';
import '../remote/language_remote.dart';
import 'custom_navigator_module.dart';
import 'odoo_dio_module.dart';

/// This module manages various application-level states and configurations.
/// It provides methods to change settings like locale, theme mode, and more.
/// It also handles user authentication status, token expiration, and logout.
class AppProviderModule with ChangeNotifier {
  /// Singleton instance of AppProviderModule.
  static final AppProviderModule _instance = AppProviderModule.internal();

  AppProviderModule.internal();

  factory AppProviderModule() {
    return _instance;
  }

  // BehaviorSubject to track the user's authentication status.
  bool _isLoggedIn = false;

  /// Locale and theme settings.
  String locale = 'ar';

  /// late init for application theme mode
  ThemeMode themeMode = ThemeMode.dark;

  /// System UI overlay style for different theme modes.
  // SystemUiOverlayStyle systemUiOverlayStyle = const SystemUiOverlayStyle(
  //   statusBarBrightness: Brightness.dark,
  //   statusBarIconBrightness: Brightness.dark,
  //   statusBarColor: Colors.transparent,
  //   systemNavigationBarColor: Colors.transparent,
  //   systemNavigationBarDividerColor: Colors.transparent,
  //   systemNavigationBarContrastEnforced: false,
  //   systemStatusBarContrastEnforced: false,
  //   systemNavigationBarIconBrightness: Brightness.dark,
  // );

  /// Toggle between English and Arabic locales.
  void changeLocale(String locale) {
    this.locale = locale;
    SharedPrefModule().locale = locale;
    OdooDioModule().setAppHeaders();
    notifyListeners();
  }

  /// Toggle between light and dark theme modes.
  void changeThemeMode(ThemeMode themeMode) {
    if (themeMode == ThemeMode.light) {
      this.themeMode = ThemeMode.light;
      // systemUiOverlayStyle = _lightSystemUIOverlay;
      SharedPrefModule().isDarkMode = false;
    } else {
      this.themeMode = ThemeMode.dark;
      // systemUiOverlayStyle = _darkSystemUIOverlay;
      SharedPrefModule().isDarkMode = true;
    }
    notifyListeners();
  }

  /// Update system UI overlay style based on system theme mode.
  void updateSystemUIOverLayDependOnThemeModeSystem() {
    if (themeMode == ThemeMode.system) {
      if (WidgetsBinding.instance.platformDispatcher.platformBrightness ==
          Brightness.light) {
        // systemUiOverlayStyle = _lightSystemUIOverlay;
      } else {
        // systemUiOverlayStyle = _darkSystemUIOverlay;
      }
    } else if (ThemeMode.dark == themeMode) {
      // systemUiOverlayStyle = _darkSystemUIOverlay;
    } else {
      // systemUiOverlayStyle = _lightSystemUIOverlay;
    }
  }

  /// System UI overlay style for dark theme mode.
  // SystemUiOverlayStyle get _darkSystemUIOverlay => const SystemUiOverlayStyle(
  //       statusBarBrightness: Brightness.light,
  //       statusBarIconBrightness: Brightness.light,
  //       statusBarColor: Colors.transparent,
  //       systemNavigationBarColor: Colors.transparent,
  //       systemNavigationBarDividerColor: Colors.transparent,
  //       systemNavigationBarContrastEnforced: false,
  //       systemStatusBarContrastEnforced: false,
  //       systemNavigationBarIconBrightness: Brightness.light,
  //     );

  /// System UI overlay style for light theme mode.
  // SystemUiOverlayStyle get _lightSystemUIOverlay => const SystemUiOverlayStyle(
  //       statusBarBrightness: Brightness.dark,
  //       statusBarIconBrightness: Brightness.dark,
  //       statusBarColor: Colors.transparent,
  //       systemNavigationBarColor: Colors.transparent,
  //       systemNavigationBarDividerColor: Colors.transparent,
  //       systemNavigationBarContrastEnforced: false,
  //       systemStatusBarContrastEnforced: false,
  //       systemNavigationBarIconBrightness: Brightness.dark,
  //     );

  void _loadAppLanguages() {
    LanguageRemote().saveToCart().listen((event) {
      if (event is SuccessState &&
          event.response != null &&
          event.response!.isNotEmpty){

        SharedPrefModule().apiARLanguageCode = event.response!
            .firstWhere(
                (element) => element.lang.toLowerCase().contains("arabic"))
            .code;

        SharedPrefModule().apiENLanguageCode = event.response!
            .firstWhere(
                (element) => element.lang.toLowerCase().contains("english"))
            .code;

        if (SharedPrefModule().language == 'ar') {
          SharedPrefModule().apiSelectedLanguageCode =
              SharedPrefModule().apiARLanguageCode;
        } else {
          SharedPrefModule().apiSelectedLanguageCode =
              SharedPrefModule().apiENLanguageCode;
        }
      }



    });
  }

  /// Initialize the app's state and check user authentication status.
  Future<void> init(BuildContext context) async {
    _isLoggedIn = SharedPrefModule().bearerToken != null;
    _loadAppLanguages();
    if (_isLoggedIn) {
      /// TODO replace it with bearer token refresh

      OdooDioModule().setAppHeaders();

      await Routes.navigateToScreen(Routes.homeScreen, NavigationType.goNamed, context);
      // CustomNavigatorModule.navigatorKey.currentState
      //     ?.pushReplacementNamed(AppScreenEnum.home.name);

    } else {
      Routes.navigateToScreen(Routes.loginScreen, NavigationType.pushReplacementNamed, context);
      // CustomNavigatorModule.navigatorKey.currentState
      //     ?.pushReplacementNamed(AppScreenEnum.login.name);
    }
    notifyListeners();
    // return Future.value();
  }

  void initAppThemeAndLanguage() {
    themeMode = SharedPrefModule().isDarkMode == null
        ? ThemeMode.light
        : (SharedPrefModule().isDarkMode ?? false)
            ? ThemeMode.dark
            : ThemeMode.light;
    locale =
        SharedPrefModule().locale.isEmpty ? "ar" : SharedPrefModule().locale;
  }

  /// Log the user out by clearing shared preferences and updating the state.
  void logout(BuildContext context) {
    var locale = SharedPrefModule().locale;
    var isDark = SharedPrefModule().isDarkMode;
    var userPhone = SharedPrefModule().userPhone;
    var userPhoneWithoutCountry = SharedPrefModule().userPhoneWithoutCountry;
    var password = SharedPrefModule().password;
    SharedPrefModule().clear;
    SharedPrefModule().isDarkMode = isDark;
    SharedPrefModule().locale = locale;
    SharedPrefModule().password = password;
    SharedPrefModule().userPhone = userPhone;
    SharedPrefModule().userPhoneWithoutCountry = userPhoneWithoutCountry;
    SharedPrefModule().bearerToken = null;
    _isLoggedIn = true;
    init(context);
    notifyListeners();
    Routes.navigateToScreen(Routes.loginScreen, NavigationType.pushReplacementNamed, context);
    // CustomNavigatorModule.navigatorKey.currentState
    //     ?.pushReplacementNamed(AppScreenEnum.login.name);
  }

  /// Check if the user's token is expired or about to expire.
  bool _isTokenExpired() =>
      JwtDecoder.isExpired(SharedPrefModule().bearerToken ?? '') ||
      JwtDecoder.getExpirationDate(SharedPrefModule().bearerToken ?? '')
              .difference(DateTime.now())
              .inDays >
          5;
}
