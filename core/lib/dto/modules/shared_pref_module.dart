import 'package:core/dto/enums/shared_pref_enum.dart';
import 'package:simple_shared_pref/simple_shared_pref.dart';

class SharedPrefModule {
  final SimpleSharedPref _sharedPref = SimpleSharedPref();

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
      key: _sharedKey(SharedPRefEnum.isDarkMode), value: value ?? '');



  void get clear => _sharedPref.clear();

  void remove(SharedPRefEnum key) {
    _sharedPref.removeValue(_sharedKey(key));
  }

  String _sharedKey(SharedPRefEnum enumKey) {
    return enumKey.name.toString().split('.').last;
  }
}
