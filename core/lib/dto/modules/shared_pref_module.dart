import 'package:core/dto/enums/shared_pref_enum.dart';
import 'package:simple_shared_pref/simple_shared_pref.dart';

class SharedPrefModule {
  final SimpleSharedPref _sharedPref = SimpleSharedPref();

  double get userLat =>
      _sharedPref.getValue<double>(key: _sharedKey(SharedPRefEnum.userLat)) ??
      0;

  set userLat(double value) => _sharedPref.setValue<double>(
      key: _sharedKey(SharedPRefEnum.userLat), value: value);

  double get userLong =>
      _sharedPref.getValue<double>(key: _sharedKey(SharedPRefEnum.userLong)) ??
      0;

  set userLong(double value) => _sharedPref.setValue<double>(
      key: _sharedKey(SharedPRefEnum.userLong), value: value);

  /// language
  String get language =>
      _sharedPref.getValue<String>(key: _sharedKey(SharedPRefEnum.language)) ??
      'en';

  set language(String value) => _sharedPref.setValue<String>(
      key: _sharedKey(SharedPRefEnum.language), value: value);

  /// dark or light mode
  bool? get isDarkMode =>
      _sharedPref.getValue<bool>(key: _sharedKey(SharedPRefEnum.isDarkMode));

  set isDarkMode(bool? value) => _sharedPref.setValue<bool>(
      key: _sharedKey(SharedPRefEnum.isDarkMode), value: value ?? false);

  /// user id
  String? get userId =>
      _sharedPref.getValue<String>(key: _sharedKey(SharedPRefEnum.userId));

  set userId(String? value) => _sharedPref.setValue<String>(
      key: _sharedKey(SharedPRefEnum.userId), value: value ?? '');

  /// bearer token
  String? get bearerToken =>
      _sharedPref.getValue<String>(key: _sharedKey(SharedPRefEnum.bearerToken));

  set bearerToken(String? value) => _sharedPref.setValue<String>(
      key: _sharedKey(SharedPRefEnum.bearerToken), value: value ?? '');

  /// userName
  String? get userName =>
      _sharedPref.getValue<String>(key: _sharedKey(SharedPRefEnum.userName));

  set userName(String? value) => _sharedPref.setValue<String>(
      key: _sharedKey(SharedPRefEnum.userName), value: value ?? '');

  /// password
  String? get password =>
      _sharedPref.getValue<String>(key: _sharedKey(SharedPRefEnum.password));

  set password(String? value) => _sharedPref.setValue<String>(
      key: _sharedKey(SharedPRefEnum.password), value: value ?? '');

  void get clear => _sharedPref.clear();

  void remove(SharedPRefEnum key) {
    _sharedPref.removeValue(_sharedKey(key));
  }

  String _sharedKey(SharedPRefEnum enumKey) {
    return enumKey.name.toString().split('.').last;
  }
}
