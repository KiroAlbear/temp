import 'dart:developer' as developer;
import 'package:core/dto/modules/dio_module.dart';

class LoggerModule {
  /// Logs a message with optional error information and stack trace.
  ///
  /// - `message`: The log message.
  /// - `name`: A name for the logger.
  /// - `error`: An optional error object.
  /// - `stackTrace`: An optional stack trace.
  static void log({
    required String message,
    required String name,
    dynamic error,
    StackTrace? stackTrace,
  }) {
    if (name != DioModule.internal().runtimeType.toString()) {
      developer.log(
        message,
        name: name,
        error: error,
        stackTrace: stackTrace,
      );
    }
    // if (error != null && stackTrace != null) {
    //   FirebaseCrashlytics.instance.recordError(error, stackTrace);
    //   // FirebaseAnalytics.instance.logEvent(name: 'name: $name'
    //   //     '\nmessage: $message'
    //   //     '\nerror: ${error.toString()}'
    //   //     '\nstack trace: ${stackTrace.toString()}');
    // } else {
    //   FirebaseCrashlytics.instance.log('name: $name'
    //       '\nmessage: $message');
    //   FirebaseAnalytics.instance.logEvent(name: 'name: $name'
    //       '\nmessage: $message');
    // }
  }
}
