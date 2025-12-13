import 'package:firebase_analytics/firebase_analytics.dart';

class FirebaseAnalyticsUtil {
  final FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  Future<void> logEvent(String name, {Map<String, Object>? parameters}) async {
    await analytics.logEvent(
      name: name,
      parameters: parameters,
    );
  }
}
