import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

import 'logger_module.dart';

class LocalAuthModule {
  final LocalAuthentication _auth = LocalAuthentication();

  Future<bool> get _canAuthenticateWithBiometrics async =>
      await _auth.canCheckBiometrics;

  Future<bool> get isSupported async => await _auth.isDeviceSupported();

  Future<List<BiometricType>> get _availableBiometrics async =>
      await _auth.getAvailableBiometrics();

  Future<bool> isAuthenticated(String message) async {
    if (await _canAuthenticateWithBiometrics || await isSupported) {
      final biometrics = await _availableBiometrics;
      if (biometrics.isNotEmpty) {
        try {
          return await _auth.authenticate(
              localizedReason: message,
              options: const AuthenticationOptions(biometricOnly: true));
        } on PlatformException catch (e, stackTrace) {
          LoggerModule.log(
              message: e.toString(),
              name: runtimeType.toString(),
              error: e,
              stackTrace: stackTrace);
          return false;
        }
      } else {
        return false;
      }
    } else {
      return false;
    }
  }
}
