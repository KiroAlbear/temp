import 'package:core/core.dart';
import 'package:core/dto/modules/app_provider_module.dart';
import 'package:deel/main_app_live.dart' as app;
import 'package:deel/my_app.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  // enableFlutterDriverExtension();
  // app.main();
  AppProviderModule? appProviderModule;

  setUp(() {
    app.main();
    if (appProviderModule == null) appProviderModule = AppProviderModule();

    runApp(MultiProvider(providers: [
      ChangeNotifierProvider<AppProviderModule>(create: (_) {
        appProviderModule!.initAppThemeAndLanguage();
        return appProviderModule!;
      }),
    ], child: const MyApp()));
  });

  group('Counter App', () {
    testWidgets('tap on the floating action button, verify counter',
        (tester) async {
      // app.main();

      await tester.pumpAndSettle(Duration(seconds: 3));
      // await tester.pumpAndSettle(Duration(seconds: 3));
      final fab = find.byKey(const Key('login'));
      expect(fab, findsOneWidget);
    });

    testWidgets('verify counter', (tester) async {
      // app.main();
      await tester.pumpWidget(MyApp());

      await tester.pumpAndSettle(Duration(seconds: 3));
      // await tester.pumpAndSettle(Duration(seconds: 3));
      final fab = find.byKey(const Key('login'));
      expect(fab, findsOneWidget);
    });
  });
  // testWidgets('tap on the floating action button, verify counter',
  //     (tester) async {
  //   // app.main();
  //
  //   await tester.pumpAndSettle(Duration(seconds: 3));
  //   // await tester.pumpAndSettle(Duration(seconds: 3));
  //   final fab = find.byKey(const Key('login'));
  //   expect(fab, findsOneWidget);
  // });
  //
  // testWidgets('verify counter', (tester) async {
  //   // app.main();
  //   await tester.pumpWidget(MyApp());
  //
  //   await tester.pumpAndSettle(Duration(seconds: 3));
  //   // await tester.pumpAndSettle(Duration(seconds: 3));
  //   final fab = find.byKey(const Key('login'));
  //   expect(fab, findsOneWidget);
  // });
}
