import 'package:authentication/ui/login/login_widget.dart';
import 'package:core/core.dart';
import 'package:core/dto/enums/app_screen_enum.dart';
import 'package:core/dto/modules/app_provider_module.dart';
import 'package:core/dto/modules/custom_navigator_module.dart';
import 'package:core/dto/modules/custom_theme_module.dart';
import 'package:core/dto/modules/logger_module.dart';
import 'package:core/generated/l10n.dart';
import 'package:dokkan/generated/assets.dart';
import 'package:dokkan/splash.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'flavors.dart';


part 'navigation_routes.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => ScreenUtilInit(
        minTextAdapt: true,
        splitScreenMode: true,
        designSize: const Size(393, 852),
        ensureScreenSize: true,
        useInheritedMediaQuery: true,
        builder: (BuildContext context, Widget? child) {
          AppProviderModule().updateSystemUIOverLayDependOnThemeModeSystem();
          return _materialApp(context);
        },
      );

  Widget _materialApp(BuildContext context) => MaterialApp(
        title: F.name,

        /// default theme here
        theme: CustomTheme().lightTheme,

        /// dark theme here
        darkTheme: CustomTheme().darkTheme,

        /// theme changer notifier
        themeMode: Provider.of<AppProviderModule>(context).themeMode,

        /// debug banner
        debugShowCheckedModeBanner: kDebugMode,

        /// localizations support using flutter intl
        localizationsDelegates: _localizationsDelegates,
        // locale: Locale(Provider.of<AppProviderModule>(context).locale, ''),
    locale: const Locale('ar'),
        supportedLocales: S.delegate.supportedLocales,

        /// navigation key use for do navigation outside any context
        navigatorKey: CustomNavigatorModule.navigatorKey,

        /// allow Chucker Flutter to show
        navigatorObservers: [ChuckerFlutter.navigatorObserver],

        /// handle generated routes for navigation
        onGenerateRoute: (settings) =>
            _onGenerateRoute(settings.name ?? '', context),

        /// set default screen route for app
        initialRoute: AppScreenEnum.splash.name,
      );

  List<LocalizationsDelegate<dynamic>> get _localizationsDelegates {
    return const [
      S.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate
    ];
  }
}
