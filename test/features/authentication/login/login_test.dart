import 'package:deel/deel.dart';
import 'package:deel/flavor_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:deel/main_app_stage.dart' as app;
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:provider/provider.dart';

void _initAdminDio(Dio dio) {
  AdminDioModule().dio = dio;
  AdminDioModule().baseUrl = FlavorConfig.adminApiUrl;
  AdminDioModule().init();
  AdminDioModule().setAppHeaders();
}

void _initOdooDio(Dio dio) {
  OdooDioModule().dio = dio;
  OdooDioModule().baseUrl = FlavorConfig.apiUrl;
  OdooDioModule().init();
  OdooDioModule().setAppHeaders();
}

Future<void> waitForWidget(
  WidgetTester tester,
  Finder finder, {
  Duration timeout = const Duration(seconds: 20),
}) async {
  final end = DateTime.now().add(timeout);
  while (DateTime.now().isBefore(end)) {
    await tester.pump();
    if (finder.evaluate().isNotEmpty) {
      return;
    }
  }
  throw Exception('Widget not found within timeout');
}

void main() {
  testWidgets('login_widget', (WidgetTester tester) async {
    WidgetsFlutterBinding.ensureInitialized();

    final dio = Dio();
    final dioAdapter = DioAdapter(dio: dio);

    // Mock the network response
    dioAdapter.onPost(
      'https://dokkan.odoo.com/get/country',
      (server) => server.reply(200, {
        "status": 200,
        "message": "Countries retrieved successfully!",
        "isSuccess": "true",
        "data": [
          {
            "id": 65,
            "name": "Egypt",
            "code": "EG",
            "address_format":
                "%(street)s\n%(street2)s\n%(city)s %(state_code)s %(zip)s\n%(country_name)s",
            "address_view_id": false,
            "currency_id": [74, "EGP"],
            "image_url": "/base/static/img/country_flags/eg.png",
            "phone_code": 20,
            "country_group_ids": [],
            "state_ids": [
              273,
              285,
              286,
              269,
              270,
              287,
              278,
              268,
              289,
              271,
              272,
              275,
              290,
              274,
              291,
              279,
              292,
              294,
              280,
              277,
              276,
              293,
              288,
              296,
              282,
              295,
              283,
              284,
              281,
            ],
            "name_position": "before",
            "vat_label": false,
            "state_required": false,
            "zip_required": true,
            "display_name": "Egypt",
            "create_uid": [1, "OdooBot"],
            "create_date": "2024-02-02T22:16:27.745634",
            "write_uid": [2, "Administrator"],
            "write_date": "2024-07-15T19:07:30.809044",
            "enforce_cities": false,
            "is_stripe_supported_country": false,
            "show_in_api": true,
          },
          {
            "id": 245,
            "name": "Yemen",
            "code": "YE",
            "address_format":
                "%(street)s\n%(street2)s\n%(city)s %(state_code)s %(zip)s\n%(country_name)s",
            "address_view_id": false,
            "currency_id": [124, "YE1"],
            "image_url": "/base/static/img/country_flags/ye.png",
            "phone_code": 967,
            "country_group_ids": [],
            "state_ids": [
              1711,
              1712,
              1713,
              1714,
              1715,
              1716,
              1717,
              1718,
              1719,
              1720,
              1721,
              1722,
              1723,
              1724,
              1725,
              1726,
              1727,
              1728,
              1729,
              1730,
              1731,
            ],
            "name_position": "before",
            "vat_label": false,
            "state_required": false,
            "zip_required": true,
            "display_name": "Yemen",
            "create_uid": [1, "OdooBot"],
            "create_date": "2024-02-02T22:16:27.745634",
            "write_uid": [2, "Administrator"],
            "write_date": "2024-07-15T19:07:08.742508",
            "enforce_cities": true,
            "is_stripe_supported_country": false,
            "show_in_api": true,
          },
        ],
      }),
    );

    ///
    // await Firebase.initializeApp(
    //    options: DefaultFirebaseOptions.currentPlatform,
    //  );

    F.appFlavor ??= Flavor.app_stage;

    // if( F.apiUrl.isEmpty){
    //   F.apiUrl = 'https://dokkan.odoo.com/';
    // }
    //
    // if(F.adminApiUrl.isEmpty){
    //   F.adminApiUrl = 'https://adminapi.deel-app.com/api/';
    // }

    // if (kDebugMode) {
    //   // Force disable Crashlytics collection while doing every day development.
    //   // Temporarily toggle this to true if you want to test crash reporting in your app.
    //   await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(false);
    // } else
    {
      // await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
      // Handle Crashlytics enabled status when not in Debug,
      // e.g. allow your users to opt-in to crash reporting.
    }

    /// init shared preferences as simple shared pref plugin
    // await SimpleSharedPref().init(allowEncryptAndDecrypt: false);

    /// add logger with all fatal errors to crashlytics
    // addFireBaseCrashReporting();

    /// set base url for dioModule
    _initOdooDio(dio);
    _initAdminDio(dio);
    LoggerModule.log(
      message: AdminDioModule().baseUrl,
      name: 'admin dio module',
    );
    LoggerModule.log(message: OdooDioModule().baseUrl, name: 'odoo dio module');

    /// allow Chucker to show in release mode
    // ChuckerFlutter.showOnRelease = true;
    HttpOverrides.global = AppHttpOverrides();

    await tester.pumpWidget(
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

    // Add debug prints
    print(tester.allWidgets);
    // Print the widget tree
    debugDumpApp();
    // Ensure the widgets are rendered
    // await tester.pumpAndSettle(const Duration(seconds: 30));
    // await tester.pumpAndSettl  e(const Duration(seconds: 30));
    // await tester.pumpAndSettle(const Duration(seconds: 30));
    await waitForWidget(tester, find.byKey(Key("MobileCountryWidget")));
    final mobileField = find.byKey(Key("MobileCountryWidget"));
    final passwordField = find.byKey(Key("PasswordWidget"));

    // Check if the widgets are found

    await tester.enterText(mobileField, "01272911556");
    await tester.enterText(passwordField, "123456");

    expect(find.text("01272911556"), findsOneWidget);
    expect(find.text("123456"), findsOneWidget);
  });

  //
  // test('otp_remote', () {
  //   // Test the OtpRemote class
  // });
  // test('forgot_password_widget', () {
  //   // Test the ForgotPasswordWidget class
  // });
  // test('reset_password_remote', () {
  //   // Test the ResetPasswordRemote class
  // });
}
