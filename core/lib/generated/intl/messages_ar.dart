// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ar locale. All the
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
  String get localeName => 'ar';

  static String m0(PermissionName) =>
      "\$${PermissionName} تم رفضه. تطبيقنا يتطلب هذا الإذن للمتابعة.";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "chooseYourCountry": MessageLookupByLibrary.simpleMessage("اختر بلدك"),
        "doNotHaveAccount":
            MessageLookupByLibrary.simpleMessage("ليس لديك حساب؟"),
        "emailRequired":
            MessageLookupByLibrary.simpleMessage("البريد الإلكتروني مطلوب"),
        "enterMobileNumber":
            MessageLookupByLibrary.simpleMessage("ادخل رقم هاتفك"),
        "enterYourPassword":
            MessageLookupByLibrary.simpleMessage("ادخل كلمة السر"),
        "failed": MessageLookupByLibrary.simpleMessage("فشل"),
        "forgotPassword":
            MessageLookupByLibrary.simpleMessage("نسيت كلمة السر؟"),
        "generalError": MessageLookupByLibrary.simpleMessage(
            "خطأ عام.\nيرجى المحاولة مرة أخرى في وقت لاحق!"),
        "inValidEmail":
            MessageLookupByLibrary.simpleMessage("بريد إلكتروني غير صالح"),
        "invalidMobile":
            MessageLookupByLibrary.simpleMessage("رقم الجوال غير صالح"),
        "loading": MessageLookupByLibrary.simpleMessage("جار التحميل"),
        "login": MessageLookupByLibrary.simpleMessage("تسجيل الدخول"),
        "loginEnter": MessageLookupByLibrary.simpleMessage("الدخول"),
        "noInternetConnection": MessageLookupByLibrary.simpleMessage(
            "لا يوجد اتصال بالإنترنت.\nيرجى المحاولة مرة أخرى لاحقًا"),
        "ok": MessageLookupByLibrary.simpleMessage("حسنًا"),
        "openSetting": m0,
        "password": MessageLookupByLibrary.simpleMessage("كلمة السر"),
        "passwordNotMatched": MessageLookupByLibrary.simpleMessage(
            "كلمة المرور وتأكيد كلمة المرور غير متطابقين"),
        "registerNow": MessageLookupByLibrary.simpleMessage("ليس لديك حساب؟"),
        "required": MessageLookupByLibrary.simpleMessage("حقل مطلوب"),
        "success": MessageLookupByLibrary.simpleMessage("نجاح"),
        "yourMobile": MessageLookupByLibrary.simpleMessage("رقم الهاتف")
      };
}
