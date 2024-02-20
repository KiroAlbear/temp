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

  static String m0(PermissionName) =>
      "\$${PermissionName} has been denied. our app required this permission in order to continue.";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "chooseYourCountry":
            MessageLookupByLibrary.simpleMessage("Choose your country"),
        "doNotHaveAccount":
            MessageLookupByLibrary.simpleMessage("Don\'t have account?"),
        "emailRequired": MessageLookupByLibrary.simpleMessage("Email required"),
        "enterMobileNumber":
            MessageLookupByLibrary.simpleMessage("Enter mobile number"),
        "enterYourPassword":
            MessageLookupByLibrary.simpleMessage("Enter your password"),
        "failed": MessageLookupByLibrary.simpleMessage("Failed"),
        "forgotPassword":
            MessageLookupByLibrary.simpleMessage("Forgot password?"),
        "generalError": MessageLookupByLibrary.simpleMessage(
            "General error.\nPlease try again later!"),
        "inValidEmail": MessageLookupByLibrary.simpleMessage("Invalid email"),
        "invalidMobile": MessageLookupByLibrary.simpleMessage("Invalid mobile"),
        "loading": MessageLookupByLibrary.simpleMessage("Loading"),
        "login": MessageLookupByLibrary.simpleMessage("Login"),
        "loginEnter": MessageLookupByLibrary.simpleMessage("Enter"),
        "noInternetConnection": MessageLookupByLibrary.simpleMessage(
            "No internet Connection.\nPlease try again later"),
        "ok": MessageLookupByLibrary.simpleMessage("Ok"),
        "openSetting": m0,
        "password": MessageLookupByLibrary.simpleMessage("Password"),
        "passwordNotMatched": MessageLookupByLibrary.simpleMessage(
            "Password and confirm password didn\'t match"),
        "registerNow": MessageLookupByLibrary.simpleMessage("Register"),
        "required": MessageLookupByLibrary.simpleMessage("Filed required"),
        "success": MessageLookupByLibrary.simpleMessage("Success"),
        "yourMobile": MessageLookupByLibrary.simpleMessage("Mobile")
      };
}
