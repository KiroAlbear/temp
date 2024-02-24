// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Login`
  String get login {
    return Intl.message(
      'Login',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `Enter mobile number`
  String get enterMobileNumber {
    return Intl.message(
      'Enter mobile number',
      name: 'enterMobileNumber',
      desc: '',
      args: [],
    );
  }

  /// `Mobile`
  String get yourMobile {
    return Intl.message(
      'Mobile',
      name: 'yourMobile',
      desc: '',
      args: [],
    );
  }

  /// `Choose your country`
  String get chooseYourCountry {
    return Intl.message(
      'Choose your country',
      name: 'chooseYourCountry',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Enter your password`
  String get enterYourPassword {
    return Intl.message(
      'Enter your password',
      name: 'enterYourPassword',
      desc: '',
      args: [],
    );
  }

  /// `Forgot password?`
  String get forgotPassword {
    return Intl.message(
      'Forgot password?',
      name: 'forgotPassword',
      desc: '',
      args: [],
    );
  }

  /// `Enter`
  String get loginEnter {
    return Intl.message(
      'Enter',
      name: 'loginEnter',
      desc: '',
      args: [],
    );
  }

  /// `Don't have account?`
  String get doNotHaveAccount {
    return Intl.message(
      'Don\'t have account?',
      name: 'doNotHaveAccount',
      desc: '',
      args: [],
    );
  }

  /// `Register`
  String get registerNow {
    return Intl.message(
      'Register',
      name: 'registerNow',
      desc: '',
      args: [],
    );
  }

  /// `Failed`
  String get failed {
    return Intl.message(
      'Failed',
      name: 'failed',
      desc: '',
      args: [],
    );
  }

  /// `Loading`
  String get loading {
    return Intl.message(
      'Loading',
      name: 'loading',
      desc: '',
      args: [],
    );
  }

  /// `Success`
  String get success {
    return Intl.message(
      'Success',
      name: 'success',
      desc: '',
      args: [],
    );
  }

  /// `Ok`
  String get ok {
    return Intl.message(
      'Ok',
      name: 'ok',
      desc: '',
      args: [],
    );
  }

  /// `General error.\nPlease try again later!`
  String get generalError {
    return Intl.message(
      'General error.\nPlease try again later!',
      name: 'generalError',
      desc: '',
      args: [],
    );
  }

  /// `${PermissionName} has been denied. our app required this permission in order to continue.`
  String openSetting(Object PermissionName) {
    return Intl.message(
      '\$$PermissionName has been denied. our app required this permission in order to continue.',
      name: 'openSetting',
      desc: '',
      args: [PermissionName],
    );
  }

  /// `No internet Connection.\nPlease try again later`
  String get noInternetConnection {
    return Intl.message(
      'No internet Connection.\nPlease try again later',
      name: 'noInternetConnection',
      desc: '',
      args: [],
    );
  }

  /// `Email required`
  String get emailRequired {
    return Intl.message(
      'Email required',
      name: 'emailRequired',
      desc: '',
      args: [],
    );
  }

  /// `Invalid email`
  String get inValidEmail {
    return Intl.message(
      'Invalid email',
      name: 'inValidEmail',
      desc: '',
      args: [],
    );
  }

  /// `Filed required`
  String get required {
    return Intl.message(
      'Filed required',
      name: 'required',
      desc: '',
      args: [],
    );
  }

  /// `Password and confirm password didn't match`
  String get passwordNotMatched {
    return Intl.message(
      'Password and confirm password didn\'t match',
      name: 'passwordNotMatched',
      desc: '',
      args: [],
    );
  }

  /// `Invalid mobile`
  String get invalidMobile {
    return Intl.message(
      'Invalid mobile',
      name: 'invalidMobile',
      desc: '',
      args: [],
    );
  }

  /// `Enter your registered mobile`
  String get enterYouRegisteredMobile {
    return Intl.message(
      'Enter your registered mobile',
      name: 'enterYouRegisteredMobile',
      desc: '',
      args: [],
    );
  }

  /// `Send OTP`
  String get sendOTP {
    return Intl.message(
      'Send OTP',
      name: 'sendOTP',
      desc: '',
      args: [],
    );
  }

  /// `Skip`
  String get skip {
    return Intl.message(
      'Skip',
      name: 'skip',
      desc: '',
      args: [],
    );
  }

  /// `Enter verification code`
  String get enterVerificationCode {
    return Intl.message(
      'Enter verification code',
      name: 'enterVerificationCode',
      desc: '',
      args: [],
    );
  }

  /// `Enter ${codeLength} number sent to ${mobileNumber}`
  String enterVerificationCodeSentTo(Object codeLength, Object mobileNumber) {
    return Intl.message(
      'Enter \$$codeLength number sent to \$$mobileNumber',
      name: 'enterVerificationCodeSentTo',
      desc: '',
      args: [codeLength, mobileNumber],
    );
  }

  /// `Resend OTP after ${time} seconds`
  String resendOtpAfter(Object time) {
    return Intl.message(
      'Resend OTP after \$$time seconds',
      name: 'resendOtpAfter',
      desc: '',
      args: [time],
    );
  }

  /// `Send OTP again`
  String get sendOtpAgain {
    return Intl.message(
      'Send OTP again',
      name: 'sendOtpAgain',
      desc: '',
      args: [],
    );
  }

  /// `Validate`
  String get validateOtp {
    return Intl.message(
      'Validate',
      name: 'validateOtp',
      desc: '',
      args: [],
    );
  }

  /// `Reset password`
  String get resetPassword {
    return Intl.message(
      'Reset password',
      name: 'resetPassword',
      desc: '',
      args: [],
    );
  }

  /// `Confirm password`
  String get confirmPassword {
    return Intl.message(
      'Confirm password',
      name: 'confirmPassword',
      desc: '',
      args: [],
    );
  }

  /// `Enter confirm password`
  String get enterConfirmPassword {
    return Intl.message(
      'Enter confirm password',
      name: 'enterConfirmPassword',
      desc: '',
      args: [],
    );
  }

  /// `At least one capital letter`
  String get atLeastOneCapChar {
    return Intl.message(
      'At least one capital letter',
      name: 'atLeastOneCapChar',
      desc: '',
      args: [],
    );
  }

  /// `At least one small letter`
  String get atLeastOneSmallLetter {
    return Intl.message(
      'At least one small letter',
      name: 'atLeastOneSmallLetter',
      desc: '',
      args: [],
    );
  }

  /// `At least one number`
  String get atLeastOneNumber {
    return Intl.message(
      'At least one number',
      name: 'atLeastOneNumber',
      desc: '',
      args: [],
    );
  }

  /// `At least one special Character`
  String get AtLeastOneSpecialCharacter {
    return Intl.message(
      'At least one special Character',
      name: 'AtLeastOneSpecialCharacter',
      desc: '',
      args: [],
    );
  }

  /// `No space allowed`
  String get noSpaceAllowed {
    return Intl.message(
      'No space allowed',
      name: 'noSpaceAllowed',
      desc: '',
      args: [],
    );
  }

  /// `At lest 8 characters`
  String get passwordMinimumCharacters {
    return Intl.message(
      'At lest 8 characters',
      name: 'passwordMinimumCharacters',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get next {
    return Intl.message(
      'Next',
      name: 'next',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
