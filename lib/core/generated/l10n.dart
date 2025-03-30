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

  /// `{PermissionName} has been denied. our app required this permission in order to continue.`
  String openSetting(Object PermissionName) {
    return Intl.message(
      '$PermissionName has been denied. our app required this permission in order to continue.',
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

  /// `Enter {codeLength} number sent to {mobileNumber}`
  String enterVerificationCodeSentTo(Object codeLength, Object mobileNumber) {
    return Intl.message(
      'Enter $codeLength number sent to $mobileNumber',
      name: 'enterVerificationCodeSentTo',
      desc: '',
      args: [codeLength, mobileNumber],
    );
  }

  /// `Resend OTP after {time} seconds`
  String resendOtpAfter(Object time) {
    return Intl.message(
      'Resend OTP after $time seconds',
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

  /// `Must contain letters`
  String get atLeastOneSmallLetter {
    return Intl.message(
      'Must contain letters',
      name: 'atLeastOneSmallLetter',
      desc: '',
      args: [],
    );
  }

  /// `Must contain numbers`
  String get atLeastOneNumber {
    return Intl.message(
      'Must contain numbers',
      name: 'atLeastOneNumber',
      desc: '',
      args: [],
    );
  }

  /// `At least one special Character`
  String get atLeastOneSpecialCharacter {
    return Intl.message(
      'At least one special Character',
      name: 'atLeastOneSpecialCharacter',
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

  /// `Register new account`
  String get registerNewAccount {
    return Intl.message(
      'Register new account',
      name: 'registerNewAccount',
      desc: '',
      args: [],
    );
  }

  /// `Once you press on next you will receive message to activate your account`
  String get registerMessageOtp {
    return Intl.message(
      'Once you press on next you will receive message to activate your account',
      name: 'registerMessageOtp',
      desc: '',
      args: [],
    );
  }

  /// `Already have an account?`
  String get haveAccount {
    return Intl.message(
      'Already have an account?',
      name: 'haveAccount',
      desc: '',
      args: [],
    );
  }

  /// `Full name`
  String get fullName {
    return Intl.message(
      'Full name',
      name: 'fullName',
      desc: '',
      args: [],
    );
  }

  String get threeFullName {
    return Intl.message(
      'Full name',
      name: 'threeFullName',
      desc: '',
      args: [],
    );
  }

  /// `Enter full name`
  String get enterFullName {
    return Intl.message(
      'Enter full name',
      name: 'enterFullName',
      desc: '',
      args: [],
    );
  }

  /// `Establishment name`
  String get platformName {
    return Intl.message(
      'Establishment name',
      name: 'platformName',
      desc: '',
      args: [],
    );
  }

  /// `Enter establishment name`
  String get enterPlatformName {
    return Intl.message(
      'Enter establishment name',
      name: 'enterPlatformName',
      desc: '',
      args: [],
    );
  }

  /// `Please authenticate to login`
  String get biometricLoginMessage {
    return Intl.message(
      'Please authenticate to login',
      name: 'biometricLoginMessage',
      desc: '',
      args: [],
    );
  }

  /// `Create account`
  String get createAccount {
    return Intl.message(
      'Create account',
      name: 'createAccount',
      desc: '',
      args: [],
    );
  }

  /// `Locate your location`
  String get locationYourLocation {
    return Intl.message(
      'Locate your location',
      name: 'locationYourLocation',
      desc: '',
      args: [],
    );
  }

  /// `Select your location`
  String get selectLocation {
    return Intl.message(
      'Select your location',
      name: 'selectLocation',
      desc: '',
      args: [],
    );
  }

  /// `Confirm`
  String get confirm {
    return Intl.message(
      'Confirm',
      name: 'confirm',
      desc: '',
      args: [],
    );
  }

  /// `Building number / street name`
  String get streetName {
    return Intl.message(
      'Building number / street name',
      name: 'streetName',
      desc: '',
      args: [],
    );
  }

  /// `Enter the building number and street name`
  String get enterStreetName {
    return Intl.message(
      'Enter the building number and street name',
      name: 'enterStreetName',
      desc: '',
      args: [],
    );
  }

  /// `District`
  String get neighborhood {
    return Intl.message(
      'District',
      name: 'neighborhood',
      desc: '',
      args: [],
    );
  }

  /// `Enter the neighborhood name`
  String get enterNeighborhood {
    return Intl.message(
      'Enter the neighborhood name',
      name: 'enterNeighborhood',
      desc: '',
      args: [],
    );
  }

  /// `Governorate`
  String get city {
    return Intl.message(
      'Governorate',
      name: 'city',
      desc: '',
      args: [],
    );
  }

  /// `Enter the name of the governorate`
  String get enterCity {
    return Intl.message(
      'Enter the name of the governorate',
      name: 'enterCity',
      desc: '',
      args: [],
    );
  }

  /// `previous`
  String get previous {
    return Intl.message(
      'previous',
      name: 'previous',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to select this location?`
  String get pickLocationEnsureMessage {
    return Intl.message(
      'Are you sure you want to select this location?',
      name: 'pickLocationEnsureMessage',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Welcome to Dokkan`
  String get welcomeToDokkan {
    return Intl.message(
      'Welcome to Dokkan',
      name: 'welcomeToDokkan',
      desc: '',
      args: [],
    );
  }

  /// `You can start order now`
  String get youCanStartOrderNow {
    return Intl.message(
      'You can start order now',
      name: 'youCanStartOrderNow',
      desc: '',
      args: [],
    );
  }

  /// `Start`
  String get start {
    return Intl.message(
      'Start',
      name: 'start',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to exit Dokkan?`
  String get closeApplicationMessage {
    return Intl.message(
      'Are you sure you want to exit Deel?',
      name: 'closeApplicationMessage',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get home {
    return Intl.message(
      'Home',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get search {
    return Intl.message(
      'Search',
      name: 'search',
      desc: '',
      args: [],
    );
  }

  /// `Promotion`
  String get promotion {
    return Intl.message(
      'Promotion',
      name: 'promotion',
      desc: '',
      args: [],
    );
  }

  /// `Basket`
  String get basket {
    return Intl.message(
      'Basket',
      name: 'basket',
      desc: '',
      args: [],
    );
  }

  /// `More`
  String get more {
    return Intl.message(
      'More',
      name: 'more',
      desc: '',
      args: [],
    );
  }

  /// `Looking for a specific product?`
  String get searchProduct {
    return Intl.message(
      'Looking for a specific product?',
      name: 'searchProduct',
      desc: '',
      args: [],
    );
  }

  /// `Best offers`
  String get bestOffers {
    return Intl.message(
      'Best offers',
      name: 'bestOffers',
      desc: '',
      args: [],
    );
  }

  /// `Best offers`
  String get lastOffers {
    return Intl.message(
      'Last offers',
      name: 'lastOffers',
      desc: '',
      args: [],
    );
  }

  /// `Offers`
  String get offersTitle {
    return Intl.message(
      'Offers',
      name: 'offersTitle',
      desc: '',
      args: [],
    );
  }

  /// `Browse sections`
  String get browseSections {
    return Intl.message(
      'Browse sections',
      name: 'browseSections',
      desc: '',
      args: [],
    );
  }

  /// `Edit location`
  String get editLocation {
    return Intl.message(
      'Edit location',
      name: 'editLocation',
      desc: '',
      args: [],
    );
  }

  /// `Current orders`
  String get currentOrders {
    return Intl.message(
      'Current orders',
      name: 'currentOrders',
      desc: '',
      args: [],
    );
  }

  /// `Previous orders`
  String get previousOrder {
    return Intl.message(
      'Previous orders',
      name: 'previousOrder',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `Account info`
  String get accountInfo {
    return Intl.message(
      'Account info',
      name: 'accountInfo',
      desc: '',
      args: [],
    );
  }

  /// `Change password`
  String get changePassword {
    return Intl.message(
      'Change password',
      name: 'changePassword',
      desc: '',
      args: [],
    );
  }

  /// `Delete account`
  String get deleteAccount {
    return Intl.message(
      'Delete account',
      name: 'deleteAccount',
      desc: '',
      args: [],
    );
  }

  /// `Favourites`
  String get favourites {
    return Intl.message(
      'Favourites',
      name: 'favourites',
      desc: '',
      args: [],
    );
  }

  /// `Account balance`
  String get accountBalance {
    return Intl.message(
      'Account balance',
      name: 'accountBalance',
      desc: '',
      args: [],
    );
  }

  /// `Support & Assistance`
  String get supportAndAssistance {
    return Intl.message(
      'Support & Assistance',
      name: 'supportAndAssistance',
      desc: '',
      args: [],
    );
  }

  /// `Contact us`
  String get contactUs {
    return Intl.message(
      'Contact us',
      name: 'contactUs',
      desc: '',
      args: [],
    );
  }

  /// `FAQ`
  String get faq {
    return Intl.message(
      'FAQ',
      name: 'faq',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get logout {
    return Intl.message(
      'Logout',
      name: 'logout',
      desc: '',
      args: [],
    );
  }

  /// `Favourite`
  String get favourite {
    return Intl.message(
      'Favourite',
      name: 'favourite',
      desc: '',
      args: [],
    );
  }

  /// `Discount {percent}`
  String discount(Object percent) {
    return Intl.message(
      'Discount $percent',
      name: 'discount',
      desc: '',
      args: [percent],
    );
  }

  /// `Add to cart`
  String get addToCart {
    return Intl.message(
      'Add to cart',
      name: 'addToCart',
      desc: '',
      args: [],
    );
  }

  /// `Products`
  String get products {
    return Intl.message(
      'Products',
      name: 'products',
      desc: '',
      args: [],
    );
  }

  /// `Usage Policy`
  String get usagePolicy {
    return Intl.message(
      'Usage Policy',
      name: 'usagePolicy',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to logout?`
  String get logoutMessage {
    return Intl.message(
      'Are you sure you want to logout?',
      name: 'logoutMessage',
      desc: '',
      args: [],
    );
  }

  /// `\nAre you sure you want to delete your account?\nThis will erase all your data and previous requests.`
  String get deleteAccountMessage {
    return Intl.message(
      '\nAre you sure you want to delete your account?\nThis will erase all your data and previous requests.',
      name: 'deleteAccountMessage',
      desc: '',
      args: [],
    );
  }

  /// `Yes`
  String get yes {
    return Intl.message(
      'Yes',
      name: 'yes',
      desc: '',
      args: [],
    );
  }

  /// `How can we help?`
  String get howCanWeHelp {
    return Intl.message(
      'How can we help?',
      name: 'howCanWeHelp',
      desc: '',
      args: [],
    );
  }

  /// `Hotline`
  String get hotline {
    return Intl.message(
      'Hotline',
      name: 'hotline',
      desc: '',
      args: [],
    );
  }

  /// `WhatsApp`
  String get whatsApp {
    return Intl.message(
      'WhatsApp',
      name: 'whatsApp',
      desc: '',
      args: [],
    );
  }

  /// `Facebook`
  String get faceBook {
    return Intl.message(
      'Facebook',
      name: 'faceBook',
      desc: '',
      args: [],
    );
  }

  /// `Current password`
  String get currentPassword {
    return Intl.message(
      'Current password',
      name: 'currentPassword',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get save {
    return Intl.message(
      'Save',
      name: 'save',
      desc: '',
      args: [],
    );
  }

  String get editData {
    return Intl.message(
      'Edit Data',
      name: 'editData',
      desc: '',
      args: [],
    );
  }

  /// `Camera`
  String get camera {
    return Intl.message(
      'Camera',
      name: 'camera',
      desc: '',
      args: [],
    );
  }

  /// `Gallery`
  String get gallery {
    return Intl.message(
      'Gallery',
      name: 'gallery',
      desc: '',
      args: [],
    );
  }

  /// `Which you would like to use?`
  String get selectPhotoFromCameraOrGallery {
    return Intl.message(
      'Which you would like to use?',
      name: 'selectPhotoFromCameraOrGallery',
      desc: '',
      args: [],
    );
  }

  /// `You need to login`
  String get youNeedToLoginToUseApp {
    return Intl.message(
      'You need to login',
      name: 'youNeedToLoginToUseApp',
      desc: '',
      args: [],
    );
  }

  /// `Login now`
  String get loginNow {
    return Intl.message(
      'Login now',
      name: 'loginNow',
      desc: '',
      args: [],
    );
  }

  /// `Search by Barcode`
  String get scanBarcode {
    return Intl.message(
      'Search by Barcode',
      name: 'scanBarcode',
      desc: '',
      args: [],
    );
  }

  /// `Make sure barcode is\nblack mark to scan`
  String get scanText {
    return Intl.message(
      'Make sure barcode is\nblack mark to scan',
      name: 'scanText',
      desc: '',
      args: [],
    );
  }

  /// `Promo details`
  String get promoDetails {
    return Intl.message(
      'Promo details',
      name: 'promoDetails',
      desc: '',
      args: [],
    );
  }

  /// `Promo items`
  String get promoItems {
    return Intl.message(
      'Offer Items',
      name: 'promoItems',
      desc: '',
      args: [],
    );
  }

  /// `Enter the new password`
  String get newPassword {
    return Intl.message(
      'Enter the new password',
      name: 'newPassword',
      desc: '',
      args: [],
    );
  }

  /// `Enter to confirm the new password`
  String get confirmNewPassword {
    return Intl.message(
      'Enter to confirm the new password',
      name: 'confirmNewPassword',
      desc: '',
      args: [],
    );
  }

  /// `Mobile already registered before`
  String get mobileAlreadyRegistered {
    return Intl.message(
      'Mobile already registered before',
      name: 'mobileAlreadyRegistered',
      desc: '',
      args: [],
    );
  }

  /// `Choose your city`
  String get chooseCity {
    return Intl.message(
      'Choose your city',
      name: 'chooseCity',
      desc: '',
      args: [],
    );
  }

  /// `Update profile`
  String get updateProfileTitle {
    return Intl.message(
      'Update profile',
      name: 'updateProfileTitle',
      desc: '',
      args: [],
    );
  }

  /// `Personal Information`
  String get updateProfilePersonalData {
    return Intl.message(
      'Personal Information',
      name: 'updateProfilePersonalData',
      desc: '',
      args: [],
    );
  }

  /// `Building Information`
  String get updateProfileBuildingData {
    return Intl.message(
      'Building Information',
      name: 'updateProfileBuildingData',
      desc: '',
      args: [],
    );
  }

  /// `Building Name`
  String get updateProfileBuildingName {
    return Intl.message(
      'Building Name',
      name: 'updateProfileBuildingName',
      desc: '',
      args: [],
    );
  }

  /// `Location`
  String get updateProfileLocation {
    return Intl.message(
      'Location',
      name: 'updateProfileLocation',
      desc: '',
      args: [],
    );
  }

  /// `Building number / Street name`
  String get updateProfileBuildingNumber {
    return Intl.message(
      'Building number / Street name',
      name: 'updateProfileBuildingNumber',
      desc: '',
      args: [],
    );
  }

  /// `District`
  String get updateProfileDistrict {
    return Intl.message(
      'District',
      name: 'updateProfileDistrict',
      desc: '',
      args: [],
    );
  }

  /// `Governorate`
  String get updateProfileGovernorate {
    return Intl.message(
      'Governorate',
      name: 'updateProfileGovernorate',
      desc: '',
      args: [],
    );
  }

  /// `You mobile exist before`
  String get mobileExistBefore {
    return Intl.message(
      'You mobile exist before',
      name: 'mobileExistBefore',
      desc: '',
      args: [],
    );
  }

  /// `There are no favorite products`
  String get emptyFavourite {
    return Intl.message(
      'There are no favorite products',
      name: 'emptyFavourite',
      desc: '',
      args: [],
    );
  }

  /// `Past orders`
  String get pastOrders {
    return Intl.message(
      'Past orders',
      name: 'pastOrders',
      desc: '',
      args: [],
    );
  }

  /// `My orders`
  String get myOrders {
    return Intl.message(
      'My orders',
      name: 'myOrders',
      desc: '',
      args: [],
    );
  }

  /// `Order number:`
  String get orderNumber {
    return Intl.message(
      'Order number:',
      name: 'orderNumber',
      desc: '',
      args: [],
    );
  }

  /// `Order total:`
  String get orderTotal {
    return Intl.message(
      'Order total:',
      name: 'orderTotal',
      desc: '',
      args: [],
    );
  }

  /// `Items count:`
  String get orderItemCount {
    return Intl.message(
      'Items count:',
      name: 'orderItemCount',
      desc: '',
      args: [],
    );
  }

  /// `Sending order`
  String get orderSending {
    return Intl.message(
      'Sending order',
      name: 'orderSending',
      desc: '',
      args: [],
    );
  }

  /// `Accepting order`
  String get orderAccepting {
    return Intl.message(
      'Accepting order',
      name: 'orderAccepting',
      desc: '',
      args: [],
    );
  }

  /// `Shipping order`
  String get orderShipping {
    return Intl.message(
      'Shipping order',
      name: 'orderShipping',
      desc: '',
      args: [],
    );
  }

  /// `Outside for delivery`
  String get orderOutside {
    return Intl.message(
      'Outside for delivery',
      name: 'orderOutside',
      desc: '',
      args: [],
    );
  }

  /// `Order delivered`
  String get orderDelivered {
    return Intl.message(
      'Order delivered',
      name: 'orderDelivered',
      desc: '',
      args: [],
    );
  }

  /// `Order in progress`
  String get orderInProgress {
    return Intl.message(
      'Order in progress',
      name: 'orderInProgress',
      desc: '',
      args: [],
    );
  }

  /// `Order details`
  String get orderDetails {
    return Intl.message(
      'Order details',
      name: 'orderDetails',
      desc: '',
      args: [],
    );
  }

  /// `Order received`
  String get orderRecieved {
    return Intl.message(
      'Order received',
      name: 'orderRecieved',
      desc: '',
      args: [],
    );
  }

  /// `Order canceled`
  String get orderNotRecieved {
    return Intl.message(
      'Order canceled',
      name: 'orderNotRecieved',
      desc: '',
      args: [],
    );
  }

  /// `Order again`
  String get orderAgain {
    return Intl.message(
      'Order again',
      name: 'orderAgain',
      desc: '',
      args: [],
    );
  }

  /// `Items details`
  String get itemsDetails {
    return Intl.message(
      'Items details',
      name: 'itemsDetails',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to cancel this order?`
  String get orderCancelConfirmation {
    return Intl.message(
      'Are you sure you want to cancel this order?',
      name: 'orderCancelConfirmation',
      desc: '',
      args: [],
    );
  }

  /// `Reason for canceling your order`
  String get orderCancelReasonTitle {
    return Intl.message(
      'Reason for canceling your order',
      name: 'orderCancelReasonTitle',
      desc: '',
      args: [],
    );
  }

  /// `Reason for canceling the order`
  String get orderCancelReasonHint {
    return Intl.message(
      'Reason for canceling the order',
      name: 'orderCancelReasonHint',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Cancellation`
  String get orderCancelConfirmButton {
    return Intl.message(
      'Confirm Cancellation',
      name: 'orderCancelConfirmButton',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a reason for canceling the order`
  String get orderCancelReasonValidation {
    return Intl.message(
      'Please enter a reason for canceling the order',
      name: 'orderCancelReasonValidation',
      desc: '',
      args: [],
    );
  }

  /// `Back`
  String get orderCancelBackButton {
    return Intl.message(
      'Back',
      name: 'orderCancelBackButton',
      desc: '',
      args: [],
    );
  }

  /// `Items`
  String get orderItem {
    return Intl.message(
      'Items',
      name: 'orderItem',
      desc: '',
      args: [],
    );
  }

  /// `You don't have any order till now`
  String get ordersNotFound {
    return Intl.message(
      'You don\'t have any order till now',
      name: 'ordersNotFound',
      desc: '',
      args: [],
    );
  }

  /// `All`
  String get productsFilterAll {
    return Intl.message(
      'All',
      name: 'productsFilterAll',
      desc: '',
      args: [],
    );
  }

  /// `Basket`
  String get cartTitle {
    return Intl.message(
      'Basket',
      name: 'cartTitle',
      desc: '',
      args: [],
    );
  }

  /// `Usage Policy`
  String get usagePolicyTitle {
    return Intl.message(
      'Usage Policy',
      name: 'usagePolicyTitle',
      desc: '',
      args: [],
    );
  }

  /// `Products Details`
  String get cartProductDetails {
    return Intl.message(
      'Products Details',
      name: 'cartProductDetails',
      desc: '',
      args: [],
    );
  }

  /// `There is no orders`
  String get cartEmpty {
    return Intl.message(
      'There is no orders',
      name: 'cartEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Order is confirmed successfully`
  String get cartSuccessConfirmation {
    return Intl.message(
      'Order is confirmed successfully',
      name: 'cartSuccessConfirmation',
      desc: '',
      args: [],
    );
  }

  /// `Your order will be delivered to you within 24 hours \nYou can now track the progress of your orderً`
  String get cartSuccessIsDelivering {
    return Intl.message(
      'Your order will be delivered to you within 24 hours \nYou can now track the progress of your orderً',
      name: 'cartSuccessIsDelivering',
      desc: '',
      args: [],
    );
  }

  /// `Track your order`
  String get cartSuccessTrackButton {
    return Intl.message(
      'Track your order',
      name: 'cartSuccessTrackButton',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure to remove the product from the cart?`
  String get cartDeleteMessage {
    return Intl.message(
      'Are you sure to remove the product from the cart?',
      name: 'cartDeleteMessage',
      desc: '',
      args: [],
    );
  }

  /// `The maximum quantity you can add to this product is`
  String get cartMaximumProductsReached {
    return Intl.message(
      'The maximum quantity you can add to this product is',
      name: 'cartMaximumProductsReached',
      desc: '',
      args: [],
    );
  }

  /// `The minimum amount you can add to this product is`
  String get cartMinimumProductsReached {
    return Intl.message(
      'The minimum amount you can add to this product is',
      name: 'cartMinimumProductsReached',
      desc: '',
      args: [],
    );
  }

  /// `Minimum order !`
  String get cartMinimumOrder {
    return Intl.message(
      'Minimum order !',
      name: 'cartMinimumOrder',
      desc: '',
      args: [],
    );
  }

  /// `Order now`
  String get cartOrderNow {
    return Intl.message(
      'Order now',
      name: 'cartOrderNow',
      desc: '',
      args: [],
    );
  }

  /// `Order details`
  String get cartOrderOrderDetails {
    return Intl.message(
      'Order details',
      name: 'cartOrderOrderDetails',
      desc: '',
      args: [],
    );
  }

  /// `Confirm order`
  String get cartConfirmOrder {
    return Intl.message(
      'Confirm order',
      name: 'cartConfirmOrder',
      desc: '',
      args: [],
    );
  }

  /// `Cash on delivery`
  String get cartCashOnDelivery {
    return Intl.message(
      'Cash on delivery',
      name: 'cartCashOnDelivery',
      desc: '',
      args: [],
    );
  }

  /// `Payment method that suits you`
  String get cartPaymentOptions {
    return Intl.message(
      'Payment method that suits you',
      name: 'cartPaymentOptions',
      desc: '',
      args: [],
    );
  }

  /// `Dokkan wallet`
  String get cartDokkanWallet {
    return Intl.message(
      'Dokkan wallet',
      name: 'cartDokkanWallet',
      desc: '',
      args: [],
    );
  }

  /// `Product is not available`
  String get productIsNotAvailable {
    return Intl.message(
      'Product is not available',
      name: 'productIsNotAvailable',
      desc: '',
      args: [],
    );
  }

  /// `Phone number is not exist`
  String get mobileIsNotExist {
    return Intl.message(
      'Phone number is not exist',
      name: 'mobileIsNotExist',
      desc: '',
      args: [],
    );
  }

  /// `Problem with Phone number `
  String get otpPhoneIsNotValid {
    return Intl.message(
      'Problem with Phone number ',
      name: 'otpPhoneIsNotValid',
      desc: '',
      args: [],
    );
  }

  /// `Problem with verification code`
  String get otpIsNotValid {
    return Intl.message(
      'Problem with verification code',
      name: 'otpIsNotValid',
      desc: '',
      args: [],
    );
  }

  String get otpAuthenticate {
    return Intl.message(
      'Verify',
      name: 'otpAuthenticate',
      desc: '',
      args: [],
    );
  }

  /// `Some products are not available`
  String get cartProductsNotAvailable {
    return Intl.message(
      'Some products are not available',
      name: 'cartProductsNotAvailable',
      desc: '',
      args: [],
    );
  }

  /// `only available with quantity`
  String get cartProductQuantityNotAvailable {
    return Intl.message(
      'only available with quantity',
      name: 'cartProductQuantityNotAvailable',
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
