import 'package:deel/deel.dart';
import 'package:deel/features/more/accountChangePassword/ui/account_change_password.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:transition_easy/custom_transition_module.dart';
import 'package:transition_easy/easy_fade_in_transition.dart';
import 'package:transition_easy/easy_transition.dart';
import 'core/generated/l10n.dart';
import 'flavors.dart';
import 'package:deel/gen/assets.gen.dart';

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
        // navigatorObservers: [ChuckerFlutter.navigatorObserver],

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
