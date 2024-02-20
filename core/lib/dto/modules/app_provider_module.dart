import 'package:core/dto/enums/app_screen_enum.dart';
import 'package:core/dto/modules/app_color_module.dart';
import 'package:core/dto/modules/shared_pref_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import 'custom_navigator_module.dart';
import 'dio_module.dart';

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
  ThemeMode themeMode = ThemeMode.light;

  /// System UI overlay style for different theme modes.
  SystemUiOverlayStyle systemUiOverlayStyle = const SystemUiOverlayStyle(
    statusBarBrightness: Brightness.dark,
    statusBarIconBrightness: Brightness.dark,
    statusBarColor: primaryColorLightMode,
    systemNavigationBarColor: primaryColorLightMode,
    systemNavigationBarDividerColor: primaryColorLightMode,
    systemNavigationBarContrastEnforced: false,
    systemStatusBarContrastEnforced: false,
    systemNavigationBarIconBrightness: Brightness.dark,
  );

  /// Toggle between English and Arabic locales.
  void changeLocale(String locale) {
    this.locale = locale;
    SharedPrefModule().language = locale;
    DioModule().setAppHeaders();
    notifyListeners();
  }

  /// Toggle between light and dark theme modes.
  void changeThemeMode(ThemeMode themeMode) {
    if (themeMode == ThemeMode.light) {
      this.themeMode = ThemeMode.light;
      systemUiOverlayStyle = _lightSystemUIOverlay;
      SharedPrefModule().isDarkMode = false;
    } else {
      this.themeMode = ThemeMode.dark;
      systemUiOverlayStyle = _darkSystemUIOverlay;
      SharedPrefModule().isDarkMode = true;
    }
    notifyListeners();
  }

  /// Update system UI overlay style based on system theme mode.
  void updateSystemUIOverLayDependOnThemeModeSystem() {
    if (themeMode == ThemeMode.system) {
      if (WidgetsBinding.instance.platformDispatcher.platformBrightness ==
          Brightness.light) {
        systemUiOverlayStyle = _lightSystemUIOverlay;
      } else {
        systemUiOverlayStyle = _darkSystemUIOverlay;
      }
    } else if (ThemeMode.dark == themeMode) {
      systemUiOverlayStyle = _darkSystemUIOverlay;
    } else {
      systemUiOverlayStyle = _lightSystemUIOverlay;
    }
  }

  /// System UI overlay style for dark theme mode.
  SystemUiOverlayStyle get _darkSystemUIOverlay => const SystemUiOverlayStyle(
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.light,
        statusBarColor: primaryColorDarkMode,
        systemNavigationBarColor: primaryColorDarkMode,
        systemNavigationBarDividerColor: primaryColorDarkMode,
        systemNavigationBarContrastEnforced: false,
        systemStatusBarContrastEnforced: false,
        systemNavigationBarIconBrightness: Brightness.light,
      );

  /// System UI overlay style for light theme mode.
  SystemUiOverlayStyle get _lightSystemUIOverlay => const SystemUiOverlayStyle(
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark,
        statusBarColor: primaryColorLightMode,
        systemNavigationBarColor: primaryColorLightMode,
        systemNavigationBarDividerColor: primaryColorLightMode,
        systemNavigationBarContrastEnforced: false,
        systemStatusBarContrastEnforced: false,
        systemNavigationBarIconBrightness: Brightness.dark,
      );

  /// Initialize the app's state and check user authentication status.
  Future<void> init(BuildContext context) async {
    _isLoggedIn = SharedPrefModule().bearerToken != null;
    if (_isLoggedIn && _isTokenExpired()) {
      /// TODO replace it with bearer token refresh
      final isRefreshed = true;
      if (isRefreshed) {
        DioModule().setAppHeaders();

        CustomNavigatorModule.navigatorKey.currentState
            ?.pushReplacementNamed(AppScreenEnum.home.name);
      } else {
        // SharedPrefModule().clear;
        CustomNavigatorModule.navigatorKey.currentState
            ?.pushReplacementNamed(AppScreenEnum.login.name);
      }
    } else {
      CustomNavigatorModule.navigatorKey.currentState
          ?.pushReplacementNamed(AppScreenEnum.login.name);
    }
    notifyListeners();
    return Future.value();
  }

  void initAppThemeAndLanguage() {
    themeMode = SharedPrefModule().isDarkMode == null
        ? ThemeMode.light
        : (SharedPrefModule().isDarkMode ?? false)
            ? ThemeMode.dark
            : ThemeMode.light;
    locale = SharedPrefModule().language.isEmpty
        ? "ar"
        : SharedPrefModule().language;
  }

  /// Log the user out by clearing shared preferences and updating the state.
  void logout(BuildContext context) {
    var language = SharedPrefModule().language;
    var isDark = SharedPrefModule().isDarkMode;
    SharedPrefModule().clear;
    SharedPrefModule().isDarkMode = isDark;
    SharedPrefModule().language = language;
    _isLoggedIn = true;
    notifyListeners();
    CustomNavigatorModule.navigatorKey.currentState
        ?.pushReplacementNamed(AppScreenEnum.login.name);
  }

  /// Check if the user's token is expired or about to expire.
  bool _isTokenExpired() =>
      JwtDecoder.isExpired(SharedPrefModule().bearerToken ?? '') ||
      JwtDecoder.getExpirationDate(SharedPrefModule().bearerToken ?? '')
              .difference(DateTime.now())
              .inDays >
          5;
}
