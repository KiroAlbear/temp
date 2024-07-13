class ConstantModule {
  static const String appTitle = "Dokkan";

  /// debug, live or stage versioning
  static const bool isLive = false;
  static const bool isTest = true;
  static const bool isStage = false;
  static const String baseLiveUrl = 'https://availo-mobileApi.t2.sa/api/';
  static const String baseStageUrl = 'https://stg2availo-mobileapi.t2.sa/api/';
  static const String baseTestUrl = 'https://devmobileapi-availo.t2.sa/Api/';
  static const String lookUpUrl = 'www.google.com';

  /// default validation regex
  static const String mobileRegex = r'(^[0-9]{9,11}$)';
  static const String passwordRegex =
      '$atLeastLowerCaseRegex'
      // '$atLeastUpperCaseRegex'
      '$atLeastNumberCaseRegex'
      // '$atLeastSpecialCharacter'
      '$noSpaceRegex'
      '$passwordLength';
  static const String passwordLength = '{$passwordMinLength,}';
  static const int passwordMinLength = 8;
  static const String atLeastLowerCaseRegex = '(?=.*[a-z])';
  static const String atLeastUpperCaseRegex = '(?=.*[A-Z])';
  static const String atLeastNumberCaseRegex = '(?=.*[0-9])';
  static const String noSpaceRegex = '[^\\s]';

  // static const String atLeastSpecialCharacter = '(?=.*[\\W-_])';
  static const String atLeastSpecialCharacter = '(?=.*[!|@|#|%|&|\$])';
  static const String pointText = "\u2022";
  static const String urlRegex =
      r'^((?:.|\n)*?)((http:\/\/www\.|https:\/\/www\.|http:\/\/|https:\/\/)?[a-z0-9]+([\-\.]{1}[a-z0-9]+)([-A-Z0-9.]+)(/[-A-Z0-9+&@#/%=~_|!:,.;]*)?(\?[A-Z0-9+&@#/%=~_|!:,.;]*)?)';
  static const String checkInOutKey =
      'MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCgCBQqiPsLrCODmep8qmhJe8Fa14mw/hWdArI+rNb'
      'bJPsDyVyTe9T78vSXq8KPQhkmOKPkZWkMCKB4khgGZ0/thzfn2rKGXAKqsSRKskgVczRf1NxbpZt2l6'
      '6gbezsB4DF8BapAJ9CU5PIFdMKiLcP7CdnDmZnosw7KdlktugZ2QIDAQAB';
}
