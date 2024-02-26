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

  static String m0(codeLength, mobileNumber) =>
      "ادخل ال\$${codeLength} ارقام التي ارسلناها الي رقم \$${mobileNumber}";

  static String m1(PermissionName) =>
      "\$${PermissionName} تم رفضه. تطبيقنا يتطلب هذا الإذن للمتابعة.";

  static String m2(time) => "يمكن إعادة ارسال الكود بعد \$${time} ثانية";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "AtLeastOneSpecialCharacter":
            MessageLookupByLibrary.simpleMessage("يجب أن تحتوي على رمز (@#_,)"),
        "Login": MessageLookupByLibrary.simpleMessage("تسجيل الدخول"),
        "atLeastOneCapChar": MessageLookupByLibrary.simpleMessage(
            "يجب أن تحتوي على حرف كبير على الأقل"),
        "atLeastOneNumber": MessageLookupByLibrary.simpleMessage(
            "يجب أن تحتوي على رقم واحد على الأقل"),
        "atLeastOneSmallLetter": MessageLookupByLibrary.simpleMessage(
            "يجب أن تحتوي على حرف صغير على الأقل"),
        "chooseYourCountry": MessageLookupByLibrary.simpleMessage("اختر بلدك"),
        "confirmPassword":
            MessageLookupByLibrary.simpleMessage("تأكيد كلمة السر"),
        "doNotHaveAccount":
            MessageLookupByLibrary.simpleMessage("ليس لديك حساب؟"),
        "emailRequired":
            MessageLookupByLibrary.simpleMessage("البريد الإلكتروني مطلوب"),
        "enterConfirmPassword":
            MessageLookupByLibrary.simpleMessage("ادخل تاكيد كلمة السر"),
        "enterFullName":
            MessageLookupByLibrary.simpleMessage("ادخل اسمك بالكامل"),
        "enterMobileNumber":
            MessageLookupByLibrary.simpleMessage("ادخل رقم هاتفك"),
        "enterPlatformName":
            MessageLookupByLibrary.simpleMessage("ادخل اسم المنشأه"),
        "enterVerificationCode":
            MessageLookupByLibrary.simpleMessage("ادخل رمز التفعيل"),
        "enterVerificationCodeSentTo": m0,
        "enterYouRegisteredMobile":
            MessageLookupByLibrary.simpleMessage("ادخل رقم هاتفك المسجل"),
        "enterYourPassword":
            MessageLookupByLibrary.simpleMessage("ادخل كلمة السر"),
        "failed": MessageLookupByLibrary.simpleMessage("فشل"),
        "forgotPassword":
            MessageLookupByLibrary.simpleMessage("نسيت كلمة السر؟"),
        "fullName": MessageLookupByLibrary.simpleMessage("الاسم بالكامل"),
        "generalError": MessageLookupByLibrary.simpleMessage(
            "خطأ عام.\nيرجى المحاولة مرة أخرى في وقت لاحق!"),
        "haveAccount": MessageLookupByLibrary.simpleMessage("لديك حساب؟"),
        "inValidEmail":
            MessageLookupByLibrary.simpleMessage("بريد إلكتروني غير صالح"),
        "invalidMobile":
            MessageLookupByLibrary.simpleMessage("رقم الجوال غير صالح"),
        "loading": MessageLookupByLibrary.simpleMessage("جار التحميل"),
        "login": MessageLookupByLibrary.simpleMessage("تسجيل الدخول"),
        "loginEnter": MessageLookupByLibrary.simpleMessage("الدخول"),
        "next": MessageLookupByLibrary.simpleMessage("التالي"),
        "noInternetConnection": MessageLookupByLibrary.simpleMessage(
            "لا يوجد اتصال بالإنترنت.\nيرجى المحاولة مرة أخرى لاحقًا"),
        "noSpaceAllowed":
            MessageLookupByLibrary.simpleMessage("يجب ألا تحتوي على مسافات"),
        "ok": MessageLookupByLibrary.simpleMessage("حسنًا"),
        "openSetting": m1,
        "password": MessageLookupByLibrary.simpleMessage("كلمة السر"),
        "passwordMinimumCharacters":
            MessageLookupByLibrary.simpleMessage("يجب ألا تقل عن 8 حروف"),
        "passwordNotMatched": MessageLookupByLibrary.simpleMessage(
            "كلمة المرور وتأكيد كلمة المرور غير متطابقين"),
        "platformName": MessageLookupByLibrary.simpleMessage("اسم المنشأه"),
        "registerMessageOtp": MessageLookupByLibrary.simpleMessage(
            "أول ما تدوس عالتالي هنبعتلك رسالة تفعيل لحسابك"),
        "registerNewAccount":
            MessageLookupByLibrary.simpleMessage("تسجيل حساب جديد"),
        "registerNow": MessageLookupByLibrary.simpleMessage("ليس لديك حساب؟"),
        "required": MessageLookupByLibrary.simpleMessage("حقل مطلوب"),
        "resendOtpAfter": m2,
        "resetPassword":
            MessageLookupByLibrary.simpleMessage("إعادة تعيين كلمة السر"),
        "sendOTP": MessageLookupByLibrary.simpleMessage("ارسال كود التحقيق"),
        "sendOtpAgain":
            MessageLookupByLibrary.simpleMessage("ارسال الكود مرة أخري"),
        "skip": MessageLookupByLibrary.simpleMessage("تخطي"),
        "success": MessageLookupByLibrary.simpleMessage("نجاح"),
        "validateOtp": MessageLookupByLibrary.simpleMessage("تحقيق"),
        "yourMobile": MessageLookupByLibrary.simpleMessage("رقم الهاتف")
      };
}
