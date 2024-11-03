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

  String get apiSelectedLanguageCode =>
      _sharedPref.getValue<String>(
          key: _sharedKey(SharedPRefEnum.apiSelectedLanguage)) ??
      'ar';

  set apiSelectedLanguageCode(String value) => _sharedPref.setValue<String>(
      key: _sharedKey(SharedPRefEnum.apiSelectedLanguage), value: value);

  String get apiARLanguageCode =>
      _sharedPref.getValue<String>(
          key: _sharedKey(SharedPRefEnum.apiARLanguage)) ??
      'ar';

  set apiARLanguageCode(String value) => _sharedPref.setValue<String>(
      key: _sharedKey(SharedPRefEnum.apiARLanguage), value: value);

  String get apiENLanguageCode =>
      _sharedPref.getValue<String>(
          key: _sharedKey(SharedPRefEnum.apiENLanguage)) ??
      'en';

  set apiENLanguageCode(String value) => _sharedPref.setValue<String>(
      key: _sharedKey(SharedPRefEnum.apiENLanguage), value: value);

  /// locale
  String get locale =>
      _sharedPref.getValue<String>(key: _sharedKey(SharedPRefEnum.locale)) ??
      'en';

  set locale(String value) => _sharedPref.setValue<String>(
      key: _sharedKey(SharedPRefEnum.locale), value: value);

  /// language
  String get language =>
      _sharedPref.getValue<String>(key: _sharedKey(SharedPRefEnum.language)) ??
      'ar';

  set language(String value) => _sharedPref.setValue<String>(
      key: _sharedKey(SharedPRefEnum.language), value: value);

  String get userAddressText =>
      _sharedPref.getValue<String>(
          key: _sharedKey(SharedPRefEnum.userAddress)) ??
      '';

  set userAddressText(String value) => _sharedPref.setValue<String>(
      key: _sharedKey(SharedPRefEnum.userAddress), value: value);

  String get shopName =>
      _sharedPref.getValue<String>(
          key: _sharedKey(SharedPRefEnum.userShopName)) ??
      '';

  set shopName(String value) => _sharedPref.setValue<String>(
      key: _sharedKey(SharedPRefEnum.userShopName), value: value);

  int get orderId =>
      _sharedPref.getValue<int>(key: _sharedKey(SharedPRefEnum.orderId)) ?? 0;

  set orderId(int value) => _sharedPref.setValue<int>(
      key: _sharedKey(SharedPRefEnum.orderId), value: value);

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
  String? get userPhone =>
      _sharedPref.getValue<String>(key: _sharedKey(SharedPRefEnum.userPhone));

  set userPhone(String? value) => _sharedPref.setValue<String>(
      key: _sharedKey(SharedPRefEnum.userPhone), value: value ?? '');

  String? get userPhoneWithoutCountry => _sharedPref.getValue<String>(
      key: _sharedKey(SharedPRefEnum.userPhoneWithoutCountry));

  set userPhoneWithoutCountry(String? value) => _sharedPref.setValue<String>(
      key: _sharedKey(SharedPRefEnum.userPhoneWithoutCountry),
      value: value ?? '');

  int? get countryCode =>
      _sharedPref.getValue<int>(key: _sharedKey(SharedPRefEnum.countryCode));

  set countryCode(int? value) => _sharedPref.setValue<int>(
      key: _sharedKey(SharedPRefEnum.countryCode), value: value ?? 0);

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
