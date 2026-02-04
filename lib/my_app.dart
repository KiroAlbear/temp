import 'package:deel/deel.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'l10n/loc.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.of(context).padding;
    AppConstants.isHavingBottomPadding = padding.bottom > 20;

    return SafeArea(
      top: false,
      bottom: false,
      child: ScreenUtilInit(
        minTextAdapt: true,
        splitScreenMode: true,
        designSize: const Size(393, 852),
        ensureScreenSize: true,
        useInheritedMediaQuery: true,
        builder: (BuildContext context, Widget? child) {
          AppProviderModule().updateSystemUIOverLayDependOnThemeModeSystem();
          return _materialApp(context);
        },
      ),
    );
  }

  Widget _materialApp(BuildContext context) => MaterialApp.router(
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
    localizationsDelegates: Loc.localizationsDelegates,
    // locale: Locale(Provider.of<AppProviderModule>(context).locale, ''),
    locale: const Locale('ar'),

    supportedLocales: Loc.supportedLocales,

    routerConfig: Routes.goRouter,
  );
}
