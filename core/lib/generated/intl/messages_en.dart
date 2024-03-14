// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static String m0(codeLength, mobileNumber) =>
      "Enter ${codeLength} number sent to ${mobileNumber}";

  static String m1(PermissionName) =>
      "${PermissionName} has been denied. our app required this permission in order to continue.";

  static String m2(time) => "Resend OTP after ${time} seconds";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "AtLeastOneSpecialCharacter": MessageLookupByLibrary.simpleMessage(
            "At least one special Character"),
        "Login": MessageLookupByLibrary.simpleMessage("Login"),
        "atLeastOneCapChar":
            MessageLookupByLibrary.simpleMessage("At least one capital letter"),
        "atLeastOneNumber":
            MessageLookupByLibrary.simpleMessage("At least one number"),
        "atLeastOneSmallLetter":
            MessageLookupByLibrary.simpleMessage("At least one small letter"),
        "basket": MessageLookupByLibrary.simpleMessage("Basket"),
        "bestOffers": MessageLookupByLibrary.simpleMessage("Best offers"),
        "biometricLoginMessage": MessageLookupByLibrary.simpleMessage(
            "Please authenticate to login"),
        "browseSections":
            MessageLookupByLibrary.simpleMessage("Browse sections"),
        "cancel": MessageLookupByLibrary.simpleMessage("Cancel"),
        "chooseYourCountry":
            MessageLookupByLibrary.simpleMessage("Choose your country"),
        "city": MessageLookupByLibrary.simpleMessage("Governorate"),
        "closeApplicationMessage": MessageLookupByLibrary.simpleMessage(
            "Are you sure you want to exit Dokkan?"),
        "confirmPassword":
            MessageLookupByLibrary.simpleMessage("Confirm password"),
        "createAccount": MessageLookupByLibrary.simpleMessage("Create account"),
        "doNotHaveAccount":
            MessageLookupByLibrary.simpleMessage("Don\'t have account?"),
        "editLocation": MessageLookupByLibrary.simpleMessage("Edit location"),
        "emailRequired": MessageLookupByLibrary.simpleMessage("Email required"),
        "enterCity": MessageLookupByLibrary.simpleMessage(
            "Enter the name of the governorate"),
        "enterConfirmPassword":
            MessageLookupByLibrary.simpleMessage("Enter confirm password"),
        "enterFullName":
            MessageLookupByLibrary.simpleMessage("Enter full name"),
        "enterMobileNumber":
            MessageLookupByLibrary.simpleMessage("Enter mobile number"),
        "enterNeighborhood":
            MessageLookupByLibrary.simpleMessage("Enter the neighborhood name"),
        "enterPlatformName":
            MessageLookupByLibrary.simpleMessage("Enter establishment name"),
        "enterStreetName": MessageLookupByLibrary.simpleMessage(
            "Enter the building number and street name"),
        "enterVerificationCode":
            MessageLookupByLibrary.simpleMessage("Enter verification code"),
        "enterVerificationCodeSentTo": m0,
        "enterYouRegisteredMobile": MessageLookupByLibrary.simpleMessage(
            "Enter your registered mobile"),
        "enterYourPassword":
            MessageLookupByLibrary.simpleMessage("Enter your password"),
        "failed": MessageLookupByLibrary.simpleMessage("Failed"),
        "forgotPassword":
            MessageLookupByLibrary.simpleMessage("Forgot password?"),
        "fullName": MessageLookupByLibrary.simpleMessage("Full name"),
        "generalError": MessageLookupByLibrary.simpleMessage(
            "General error.\nPlease try again later!"),
        "haveAccount":
            MessageLookupByLibrary.simpleMessage("Already have an account?"),
        "home": MessageLookupByLibrary.simpleMessage("Home"),
        "inValidEmail": MessageLookupByLibrary.simpleMessage("Invalid email"),
        "invalidMobile": MessageLookupByLibrary.simpleMessage("Invalid mobile"),
        "loading": MessageLookupByLibrary.simpleMessage("Loading"),
        "locationYourLocation":
            MessageLookupByLibrary.simpleMessage("Locate your location"),
        "login": MessageLookupByLibrary.simpleMessage("Login"),
        "loginEnter": MessageLookupByLibrary.simpleMessage("Enter"),
        "more": MessageLookupByLibrary.simpleMessage("More"),
        "neighborhood": MessageLookupByLibrary.simpleMessage("District"),
        "next": MessageLookupByLibrary.simpleMessage("Next"),
        "noInternetConnection": MessageLookupByLibrary.simpleMessage(
            "No internet Connection.\nPlease try again later"),
        "noSpaceAllowed":
            MessageLookupByLibrary.simpleMessage("No space allowed"),
        "ok": MessageLookupByLibrary.simpleMessage("Ok"),
        "openSetting": m1,
        "password": MessageLookupByLibrary.simpleMessage("Password"),
        "passwordMinimumCharacters":
            MessageLookupByLibrary.simpleMessage("At lest 8 characters"),
        "passwordNotMatched": MessageLookupByLibrary.simpleMessage(
            "Password and confirm password didn\'t match"),
        "pickLocationEnsureMessage": MessageLookupByLibrary.simpleMessage(
            "Are you sure you want to select this location?"),
        "platformName":
            MessageLookupByLibrary.simpleMessage("Establishment name"),
        "previous": MessageLookupByLibrary.simpleMessage("previous"),
        "promotion": MessageLookupByLibrary.simpleMessage("Promotion"),
        "registerMessageOtp": MessageLookupByLibrary.simpleMessage(
            "Once you press on next you will receive message to activate your account"),
        "registerNewAccount":
            MessageLookupByLibrary.simpleMessage("Register new account"),
        "registerNow": MessageLookupByLibrary.simpleMessage("Register"),
        "required": MessageLookupByLibrary.simpleMessage("Filed required"),
        "resendOtpAfter": m2,
        "resetPassword": MessageLookupByLibrary.simpleMessage("Reset password"),
        "search": MessageLookupByLibrary.simpleMessage("Search"),
        "searchProduct": MessageLookupByLibrary.simpleMessage(
            "Looking for a specific product?"),
        "selectLocation":
            MessageLookupByLibrary.simpleMessage("Select your location"),
        "sendOTP": MessageLookupByLibrary.simpleMessage("Send OTP"),
        "sendOtpAgain": MessageLookupByLibrary.simpleMessage("Send OTP again"),
        "skip": MessageLookupByLibrary.simpleMessage("Skip"),
        "start": MessageLookupByLibrary.simpleMessage("Start"),
        "streetName": MessageLookupByLibrary.simpleMessage(
            "Building number / street name"),
        "success": MessageLookupByLibrary.simpleMessage("Success"),
        "validateOtp": MessageLookupByLibrary.simpleMessage("Validate"),
        "welcomeToDokkan":
            MessageLookupByLibrary.simpleMessage("Welcome to Dokkan"),
        "youCanStartOrderNow":
            MessageLookupByLibrary.simpleMessage("You can start order now"),
        "yourMobile": MessageLookupByLibrary.simpleMessage("Mobile")
      };
}
