import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:restart_app/restart_app.dart';
import 'package:shorebird_code_push/shorebird_code_push.dart';
import 'core/Utils/firebase_analytics_events_names.dart';
import 'core/Utils/firebase_analytics_utl.dart';
import 'deel.dart';

class SplashScreen extends BaseStatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashWidgetState();
}

class _SplashWidgetState extends BaseState<SplashScreen> {
  @override
  PreferredSizeWidget? appBar() => null;

  @override
  void initState() {
    customBackgroundColor = primaryColor;
    FirebaseAnalytics.instance.setAnalyticsCollectionEnabled(true);

    Future.delayed(const Duration(seconds: 2)).then((value) async {
      FirebaseAnalyticsUtil().logEvent(FirebaseAnalyticsEventsNames.app_start);
      await _checkForShorebirdUpdates();

      AppProviderModule().init(context);
    });
    super.initState();
  }

  Future<void> _checkForShorebirdUpdates() async {
    final shorebirdCodePush = ShorebirdUpdater();
    // Check for updates and prompt the user to restart if one is available.
    final UpdateStatus status = await shorebirdCodePush.checkForUpdate();

    // print('************** Shorebird status: $status *****');

    if (status == UpdateStatus.outdated) {
      // Download the update.
      await shorebirdCodePush.update();

      await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: const Text('Update Ready'),
            content: const Text(
                'An update has been downloaded and will be applied when the app restarts. Please restart the app to apply the update.'),
            actions: [
              TextButton(
                onPressed: () async {
                  await Restart.restartApp(
                    /// In Web Platform, Fill webOrigin only when your new origin is different than the app's origin
                    // webOrigin: 'http://example.com',

                    // Customizing the restart notification message (only needed on iOS)
                    notificationTitle: 'Restarting App',
                    notificationBody: 'Please tap here to open the app again.',
                  );
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );

      // Optionally, notify the user that an update is ready and they should restart.
      // In a real app, you might show a dialog or snackbar here.
      print('Update downloaded. Please restart the app to apply the changes.');
    }
  }

  @override
  Color? statusBarColor() => primaryColor;

  @override
  Color? systemNavigationBarColor() => primaryColor;

  @override
  double appTopPadding() => 0;

  @override
  Widget getBody(BuildContext context) {
    return Container(
      color: primaryColor,
      child: LogoWidget(
        logo: Assets.svg.icLogo,
      ),
    );
  }

  @override
  bool isSafeArea() => false;

  @override
  bool canPop() => false;
}
