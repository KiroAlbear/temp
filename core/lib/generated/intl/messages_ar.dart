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

  static String m0(percent) => "خصم ${percent}";

  static String m1(codeLength, mobileNumber) =>
      "ادخل ال${codeLength} ارقام التي ارسلناها الي رقم ${mobileNumber}";

  static String m2(PermissionName) =>
      "${PermissionName} تم رفضه. تطبيقنا يتطلب هذا الإذن للمتابعة.";

  static String m3(time) => "يمكن إعادة ارسال الكود بعد ${time} ثانية";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "AtLeastOneSpecialCharacter":
            MessageLookupByLibrary.simpleMessage("يجب أن تحتوي على رمز (@#_,)"),
        "Login": MessageLookupByLibrary.simpleMessage("تسجيل الدخول"),
        "accountBalance": MessageLookupByLibrary.simpleMessage("رصيد الحساب"),
        "accountInfo": MessageLookupByLibrary.simpleMessage("بيانات حسابي"),
        "addToCart": MessageLookupByLibrary.simpleMessage("أضف الي السلة"),
        "atLeastOneCapChar": MessageLookupByLibrary.simpleMessage(
            "يجب أن تحتوي على حرف كبير على الأقل"),
        "atLeastOneNumber": MessageLookupByLibrary.simpleMessage(
            "يجب أن تحتوي على رقم واحد على الأقل"),
        "atLeastOneSmallLetter": MessageLookupByLibrary.simpleMessage(
            "يجب أن تحتوي على حرف صغير على الأقل"),
        "basket": MessageLookupByLibrary.simpleMessage("السلة"),
        "bestOffers": MessageLookupByLibrary.simpleMessage("أقوى العروض"),
        "biometricLoginMessage":
            MessageLookupByLibrary.simpleMessage("يرجى المصادقة لتسجيل الدخول"),
        "browseSections": MessageLookupByLibrary.simpleMessage("تصفح الأقسام"),
        "cancel": MessageLookupByLibrary.simpleMessage("إلغاء"),
        "changePassword":
            MessageLookupByLibrary.simpleMessage("تغيير كلمة السر"),
        "chooseYourCountry": MessageLookupByLibrary.simpleMessage("اختر بلدك"),
        "city": MessageLookupByLibrary.simpleMessage("المحافظة"),
        "closeApplicationMessage": MessageLookupByLibrary.simpleMessage(
            "هل أنت متأكد أنك تريد الخروج من دُكان؟"),
        "confirmPassword":
            MessageLookupByLibrary.simpleMessage("تأكيد كلمة السر"),
        "contactUs": MessageLookupByLibrary.simpleMessage("تواصل معنا"),
        "createAccount": MessageLookupByLibrary.simpleMessage("انشاء حساب"),
        "currentOrders":
            MessageLookupByLibrary.simpleMessage("الطلبات الحالية"),
        "currentPassword":
            MessageLookupByLibrary.simpleMessage("كلمة السر الحالية"),
        "deleteAccount": MessageLookupByLibrary.simpleMessage("حذف الحساب"),
        "deleteAccountMessage": MessageLookupByLibrary.simpleMessage(
            "هل أنت متأكد من أنك تريد حذف الحساب؟"),
        "discount": m0,
        "doNotHaveAccount":
            MessageLookupByLibrary.simpleMessage("ليس لديك حساب؟"),
        "editLocation": MessageLookupByLibrary.simpleMessage("تعديل الموقع"),
        "emailRequired":
            MessageLookupByLibrary.simpleMessage("البريد الإلكتروني مطلوب"),
        "enterCity": MessageLookupByLibrary.simpleMessage("ادخل اسم المحافظة"),
        "enterConfirmPassword":
            MessageLookupByLibrary.simpleMessage("ادخل تاكيد كلمة السر"),
        "enterFullName":
            MessageLookupByLibrary.simpleMessage("ادخل اسمك بالكامل"),
        "enterMobileNumber":
            MessageLookupByLibrary.simpleMessage("ادخل رقم هاتفك"),
        "enterNeighborhood":
            MessageLookupByLibrary.simpleMessage("ادخل اسم الحي"),
        "enterPlatformName":
            MessageLookupByLibrary.simpleMessage("ادخل اسم المنشأه"),
        "enterStreetName": MessageLookupByLibrary.simpleMessage(
            "ادخل رقم البناية واسم الشارع"),
        "enterVerificationCode":
            MessageLookupByLibrary.simpleMessage("ادخل رمز التفعيل"),
        "enterVerificationCodeSentTo": m1,
        "enterYouRegisteredMobile":
            MessageLookupByLibrary.simpleMessage("ادخل رقم هاتفك المسجل"),
        "enterYourPassword":
            MessageLookupByLibrary.simpleMessage("ادخل كلمة السر"),
        "faceBook": MessageLookupByLibrary.simpleMessage("فيس بوك"),
        "failed": MessageLookupByLibrary.simpleMessage("فشل"),
        "faq": MessageLookupByLibrary.simpleMessage("الأسئلة الشائعة"),
        "favourite": MessageLookupByLibrary.simpleMessage("المفضلة"),
        "favourites": MessageLookupByLibrary.simpleMessage("المفضلة"),
        "forgotPassword":
            MessageLookupByLibrary.simpleMessage("نسيت كلمة السر؟"),
        "fullName": MessageLookupByLibrary.simpleMessage("الاسم بالكامل"),
        "generalError": MessageLookupByLibrary.simpleMessage(
            "خطأ عام.\nيرجى المحاولة مرة أخرى في وقت لاحق!"),
        "haveAccount": MessageLookupByLibrary.simpleMessage("لديك حساب؟"),
        "home": MessageLookupByLibrary.simpleMessage("الرئيسية"),
        "hotline": MessageLookupByLibrary.simpleMessage("الخط الساخن"),
        "howCanWeHelp": MessageLookupByLibrary.simpleMessage("ازاي نساعدك"),
        "inValidEmail":
            MessageLookupByLibrary.simpleMessage("بريد إلكتروني غير صالح"),
        "invalidMobile":
            MessageLookupByLibrary.simpleMessage("رقم الجوال غير صالح"),
        "itemsDetails": MessageLookupByLibrary.simpleMessage("تفاصيل المنتجات"),
        "loading": MessageLookupByLibrary.simpleMessage("جار التحميل"),
        "locationYourLocation":
            MessageLookupByLibrary.simpleMessage("حدد مكان محللك"),
        "login": MessageLookupByLibrary.simpleMessage("تسجيل الدخول"),
        "loginEnter": MessageLookupByLibrary.simpleMessage("الدخول"),
        "logout": MessageLookupByLibrary.simpleMessage("تسجيل خروج"),
        "logoutMessage": MessageLookupByLibrary.simpleMessage(
            "هل أنت متأكد من أنك تريد تسجيل الخروج؟"),
        "more": MessageLookupByLibrary.simpleMessage("المزيد"),
        "neighborhood": MessageLookupByLibrary.simpleMessage("الحي"),
        "next": MessageLookupByLibrary.simpleMessage("التالي"),
        "noInternetConnection": MessageLookupByLibrary.simpleMessage(
            "لا يوجد اتصال بالإنترنت.\nيرجى المحاولة مرة أخرى لاحقًا"),
        "noSpaceAllowed":
            MessageLookupByLibrary.simpleMessage("يجب ألا تحتوي على مسافات"),
        "ok": MessageLookupByLibrary.simpleMessage("حسنًا"),
        "openSetting": m2,
        "orderAccepting":
            MessageLookupByLibrary.simpleMessage("الموافقة على الطلب"),
        "orderAgain": MessageLookupByLibrary.simpleMessage("أطلب مرة كمان"),
        "orderCancelBackButton": MessageLookupByLibrary.simpleMessage("الرجوع"),
        "orderCancelConfirmButton":
            MessageLookupByLibrary.simpleMessage("تأكيد الإلغاء"),
        "orderCancelConfirmation": MessageLookupByLibrary.simpleMessage(
            "هل أنت متأكد من إلغاء الطلب؟"),
        "orderCancelReasonHint":
            MessageLookupByLibrary.simpleMessage("سبب إلغاء الطلب"),
        "orderCancelReasonTitle":
            MessageLookupByLibrary.simpleMessage("سبب إلغاء طلبك"),
        "orderDelivered": MessageLookupByLibrary.simpleMessage("تسليم الطلب"),
        "orderDetails": MessageLookupByLibrary.simpleMessage("تفاصيل الطلب"),
        "orderInProgress": MessageLookupByLibrary.simpleMessage("قيد التنفيذ"),
        "orderItemCount": MessageLookupByLibrary.simpleMessage("عدد القطع:"),
        "orderNotRecieved":
            MessageLookupByLibrary.simpleMessage("تم الغاء الطلب"),
        "orderNumber": MessageLookupByLibrary.simpleMessage("الطلب رقم:"),
        "orderOutside": MessageLookupByLibrary.simpleMessage("خارج للتوصيل"),
        "orderRecieved":
            MessageLookupByLibrary.simpleMessage("تم استلام الطلب"),
        "orderSending": MessageLookupByLibrary.simpleMessage("ارسال الطلب"),
        "orderShipping": MessageLookupByLibrary.simpleMessage("شحن الطلب"),
        "orderTotal": MessageLookupByLibrary.simpleMessage("الإجمالي:"),
        "password": MessageLookupByLibrary.simpleMessage("كلمة السر"),
        "passwordMinimumCharacters":
            MessageLookupByLibrary.simpleMessage("يجب ألا تقل عن 8 حروف"),
        "passwordNotMatched": MessageLookupByLibrary.simpleMessage(
            "كلمة المرور وتأكيد كلمة المرور غير متطابقين"),
        "pastOrders": MessageLookupByLibrary.simpleMessage("الطلبات السابقة"),
        "pickLocationEnsureMessage": MessageLookupByLibrary.simpleMessage(
            "هل أنت متأكد أنك تريد تحديد هذا الموقع؟"),
        "platformName": MessageLookupByLibrary.simpleMessage("اسم المنشأه"),
        "previous": MessageLookupByLibrary.simpleMessage("السابق"),
        "previousOrder": MessageLookupByLibrary.simpleMessage("طلباتي السابقة"),
        "products": MessageLookupByLibrary.simpleMessage("المنتجات"),
        "promotion": MessageLookupByLibrary.simpleMessage("العروض"),
        "registerMessageOtp": MessageLookupByLibrary.simpleMessage(
            "أول ما تدوس عالتالي هنبعتلك رسالة تفعيل لحسابك"),
        "registerNewAccount":
            MessageLookupByLibrary.simpleMessage("تسجيل حساب جديد"),
        "registerNow": MessageLookupByLibrary.simpleMessage("انشئ حساب جديد"),
        "required": MessageLookupByLibrary.simpleMessage("حقل مطلوب"),
        "resendOtpAfter": m3,
        "resetPassword":
            MessageLookupByLibrary.simpleMessage("إعادة تعيين كلمة السر"),
        "save": MessageLookupByLibrary.simpleMessage("حفظ"),
        "search": MessageLookupByLibrary.simpleMessage("بحث"),
        "searchProduct":
            MessageLookupByLibrary.simpleMessage("بتدور على منتج معين؟"),
        "selectLocation": MessageLookupByLibrary.simpleMessage("حدد موقعك"),
        "sendOTP": MessageLookupByLibrary.simpleMessage("ارسال كود التحقيق"),
        "sendOtpAgain":
            MessageLookupByLibrary.simpleMessage("ارسال الكود مرة أخري"),
        "settings": MessageLookupByLibrary.simpleMessage("الإعدادات"),
        "skip": MessageLookupByLibrary.simpleMessage("تخطي"),
        "start": MessageLookupByLibrary.simpleMessage("ابدأ"),
        "streetName":
            MessageLookupByLibrary.simpleMessage("رقم البناية / اسم الشارع"),
        "success": MessageLookupByLibrary.simpleMessage("نجاح"),
        "supportAndAssistance":
            MessageLookupByLibrary.simpleMessage("الدعم والمساعدة"),
        "usagePolicy": MessageLookupByLibrary.simpleMessage("سياسة الاستخدام"),
        "validateOtp": MessageLookupByLibrary.simpleMessage("تحقيق"),
        "welcomeToDokkan":
            MessageLookupByLibrary.simpleMessage("مرحباً بك في دُكان"),
        "whatsApp": MessageLookupByLibrary.simpleMessage("واتساب"),
        "yes": MessageLookupByLibrary.simpleMessage("نعم"),
        "youCanStartOrderNow":
            MessageLookupByLibrary.simpleMessage("تقدر تطلب دلوقتي"),
        "yourMobile": MessageLookupByLibrary.simpleMessage("رقم الهاتف")
      };
}
