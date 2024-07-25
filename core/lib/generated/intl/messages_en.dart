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

  static String m0(percent) => "Discount ${percent}";

  static String m1(codeLength, mobileNumber) =>
      "Enter ${codeLength} number sent to ${mobileNumber}";

  static String m2(PermissionName) =>
      "${PermissionName} has been denied. our app required this permission in order to continue.";

  static String m3(time) => "Resend OTP after ${time} seconds";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "AtLeastOneSpecialCharacter": MessageLookupByLibrary.simpleMessage(
            "At least one special Character"),
        "Login": MessageLookupByLibrary.simpleMessage("Login"),
        "accountBalance":
            MessageLookupByLibrary.simpleMessage("Account balance"),
        "accountInfo": MessageLookupByLibrary.simpleMessage("Account info"),
        "addToCart": MessageLookupByLibrary.simpleMessage("Add to cart"),
        "atLeastOneCapChar":
            MessageLookupByLibrary.simpleMessage("At least one capital letter"),
        "atLeastOneNumber":
            MessageLookupByLibrary.simpleMessage("Must contain numbers"),
        "atLeastOneSmallLetter":
            MessageLookupByLibrary.simpleMessage("Must contain letters"),
        "basket": MessageLookupByLibrary.simpleMessage("Basket"),
        "bestOffers": MessageLookupByLibrary.simpleMessage("Best offers"),
        "biometricLoginMessage": MessageLookupByLibrary.simpleMessage(
            "Please authenticate to login"),
        "browseSections":
            MessageLookupByLibrary.simpleMessage("Browse sections"),
        "camera": MessageLookupByLibrary.simpleMessage("Camera"),
        "cancel": MessageLookupByLibrary.simpleMessage("Cancel"),
        "changePassword":
            MessageLookupByLibrary.simpleMessage("Change password"),
        "chooseCity": MessageLookupByLibrary.simpleMessage("Choose your city"),
        "chooseYourCountry":
            MessageLookupByLibrary.simpleMessage("Choose your country"),
        "city": MessageLookupByLibrary.simpleMessage("Governorate"),
        "closeApplicationMessage": MessageLookupByLibrary.simpleMessage(
            "Are you sure you want to exit Dokkan?"),
        "confirmNewPassword": MessageLookupByLibrary.simpleMessage(
            "Enter to confirm the new password"),
        "confirmPassword":
            MessageLookupByLibrary.simpleMessage("Confirm password"),
        "contactUs": MessageLookupByLibrary.simpleMessage("Contact us"),
        "createAccount": MessageLookupByLibrary.simpleMessage("Create account"),
        "currentOrder": MessageLookupByLibrary.simpleMessage("Current orders"),
        "currentPassword":
            MessageLookupByLibrary.simpleMessage("Current password"),
        "deleteAccount": MessageLookupByLibrary.simpleMessage("Delete account"),
        "deleteAccountMessage": MessageLookupByLibrary.simpleMessage(
            "\nAre you sure you want to delete your account?\nThis will erase all your data and previous requests."),
        "discount": m0,
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
        "enterVerificationCodeSentTo": m1,
        "enterYouRegisteredMobile": MessageLookupByLibrary.simpleMessage(
            "Enter your registered mobile"),
        "enterYourPassword":
            MessageLookupByLibrary.simpleMessage("Enter your password"),
        "faceBook": MessageLookupByLibrary.simpleMessage("Facebook"),
        "failed": MessageLookupByLibrary.simpleMessage("Failed"),
        "faq": MessageLookupByLibrary.simpleMessage("FAQ"),
        "favourite": MessageLookupByLibrary.simpleMessage("Favourite"),
        "favourites": MessageLookupByLibrary.simpleMessage("Favourites"),
        "forgotPassword":
            MessageLookupByLibrary.simpleMessage("Forgot password?"),
        "fullName": MessageLookupByLibrary.simpleMessage("Full name"),
        "gallery": MessageLookupByLibrary.simpleMessage("Gallery"),
        "generalError": MessageLookupByLibrary.simpleMessage(
            "General error.\nPlease try again later!"),
        "haveAccount":
            MessageLookupByLibrary.simpleMessage("Already have an account?"),
        "home": MessageLookupByLibrary.simpleMessage("Home"),
        "hotline": MessageLookupByLibrary.simpleMessage("Hotline"),
        "howCanWeHelp":
            MessageLookupByLibrary.simpleMessage("How can we help?"),
        "inValidEmail": MessageLookupByLibrary.simpleMessage("Invalid email"),
        "invalidMobile": MessageLookupByLibrary.simpleMessage("Invalid mobile"),
        "loading": MessageLookupByLibrary.simpleMessage("Loading"),
        "locationYourLocation":
            MessageLookupByLibrary.simpleMessage("Locate your location"),
        "login": MessageLookupByLibrary.simpleMessage("Login"),
        "loginEnter": MessageLookupByLibrary.simpleMessage("Enter"),
        "loginNow": MessageLookupByLibrary.simpleMessage("Login now"),
        "logout": MessageLookupByLibrary.simpleMessage("Logout"),
        "logoutMessage": MessageLookupByLibrary.simpleMessage(
            "Are you sure you want to logout?"),
        "mobileAlreadyRegistered": MessageLookupByLibrary.simpleMessage(
            "Mobile already registered before"),
        "more": MessageLookupByLibrary.simpleMessage("More"),
        "neighborhood": MessageLookupByLibrary.simpleMessage("District"),
        "newPassword":
            MessageLookupByLibrary.simpleMessage("Enter the new password"),
        "next": MessageLookupByLibrary.simpleMessage("Next"),
        "noInternetConnection": MessageLookupByLibrary.simpleMessage(
            "No internet Connection.\nPlease try again later"),
        "noSpaceAllowed":
            MessageLookupByLibrary.simpleMessage("No space allowed"),
        "ok": MessageLookupByLibrary.simpleMessage("Ok"),
        "openSetting": m2,
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
        "previousOrder":
            MessageLookupByLibrary.simpleMessage("Previous orders"),
        "products": MessageLookupByLibrary.simpleMessage("Products"),
        "promoDetails": MessageLookupByLibrary.simpleMessage("Promo details"),
        "promotion": MessageLookupByLibrary.simpleMessage("Promotion"),
        "registerMessageOtp": MessageLookupByLibrary.simpleMessage(
            "Once you press on next you will receive message to activate your account"),
        "registerNewAccount":
            MessageLookupByLibrary.simpleMessage("Register new account"),
        "registerNow": MessageLookupByLibrary.simpleMessage("Register"),
        "required": MessageLookupByLibrary.simpleMessage("Filed required"),
        "resendOtpAfter": m3,
        "resetPassword": MessageLookupByLibrary.simpleMessage("Reset password"),
        "save": MessageLookupByLibrary.simpleMessage("Save"),
        "scanBarcode":
            MessageLookupByLibrary.simpleMessage("Search by Barcode"),
        "scanText": MessageLookupByLibrary.simpleMessage(
            "Make sure barcode is\nblack mark to scan"),
        "search": MessageLookupByLibrary.simpleMessage("Search"),
        "searchProduct": MessageLookupByLibrary.simpleMessage(
            "Looking for a specific product?"),
        "selectLocation":
            MessageLookupByLibrary.simpleMessage("Select your location"),
        "selectPhotoFromCameraOrGallery": MessageLookupByLibrary.simpleMessage(
            "Which you would like to use?"),
        "sendOTP": MessageLookupByLibrary.simpleMessage("Send OTP"),
        "sendOtpAgain": MessageLookupByLibrary.simpleMessage("Send OTP again"),
        "settings": MessageLookupByLibrary.simpleMessage("Settings"),
        "skip": MessageLookupByLibrary.simpleMessage("Skip"),
        "start": MessageLookupByLibrary.simpleMessage("Start"),
        "streetName": MessageLookupByLibrary.simpleMessage(
            "Building number / street name"),
        "success": MessageLookupByLibrary.simpleMessage("Success"),
        "supportAndAssistance":
            MessageLookupByLibrary.simpleMessage("Support & Assistance"),
        "updateProfileBuildingData":
            MessageLookupByLibrary.simpleMessage("Building Information"),
        "updateProfileBuildingName":
            MessageLookupByLibrary.simpleMessage("Building Name"),
        "updateProfileBuildingNumber": MessageLookupByLibrary.simpleMessage(
            "Building number / Street name"),
        "updateProfileDistrict":
            MessageLookupByLibrary.simpleMessage("District"),
        "updateProfileGovernorate":
            MessageLookupByLibrary.simpleMessage("Governorate"),
        "updateProfileLocation":
            MessageLookupByLibrary.simpleMessage("Location"),
        "updateProfilePersonalData":
            MessageLookupByLibrary.simpleMessage("Personal Information"),
        "updateProfileTitle":
            MessageLookupByLibrary.simpleMessage("Update profile"),
        "usagePolicy": MessageLookupByLibrary.simpleMessage("Usage Policy"),
        "validateOtp": MessageLookupByLibrary.simpleMessage("Validate"),
        "welcomeToDokkan":
            MessageLookupByLibrary.simpleMessage("Welcome to Dokkan"),
        "whatsApp": MessageLookupByLibrary.simpleMessage("WhatsApp"),
        "yes": MessageLookupByLibrary.simpleMessage("Yes"),
        "youCanStartOrderNow":
            MessageLookupByLibrary.simpleMessage("You can start order now"),
        "youNeedToLoginToUseApp":
            MessageLookupByLibrary.simpleMessage("You need to login"),
        "yourMobile": MessageLookupByLibrary.simpleMessage("Mobile")
      };
}
