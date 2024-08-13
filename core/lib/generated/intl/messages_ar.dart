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
        "atLeastOneNumber":
            MessageLookupByLibrary.simpleMessage("يجب أن تحتوي على أرقام"),
        "atLeastOneSmallLetter":
            MessageLookupByLibrary.simpleMessage("يجب أن تحتوي على حروف"),
        "basket": MessageLookupByLibrary.simpleMessage("السلة"),
        "bestOffers": MessageLookupByLibrary.simpleMessage("أقوى العروض"),
        "biometricLoginMessage":
            MessageLookupByLibrary.simpleMessage("يرجى المصادقة لتسجيل الدخول"),
        "browseSections": MessageLookupByLibrary.simpleMessage("تصفح الأقسام"),
        "camera": MessageLookupByLibrary.simpleMessage("الكاميرا"),
        "cancel": MessageLookupByLibrary.simpleMessage("إلغاء"),
        "changePassword":
            MessageLookupByLibrary.simpleMessage("تغيير كلمة السر"),
        "chooseCity": MessageLookupByLibrary.simpleMessage("اختر محافظتك"),
        "chooseYourCountry": MessageLookupByLibrary.simpleMessage("اختر بلدك"),
        "city": MessageLookupByLibrary.simpleMessage("المحافظة"),
        "closeApplicationMessage": MessageLookupByLibrary.simpleMessage(
            "هل أنت متأكد أنك تريد الخروج من دُكان؟"),
        "confirm": MessageLookupByLibrary.simpleMessage("تأكيد"),
        "confirmNewPassword": MessageLookupByLibrary.simpleMessage(
            "ادخل تاكيد كلمة السر الجديدة"),
        "confirmPassword":
            MessageLookupByLibrary.simpleMessage("تأكيد كلمة السر"),
        "contactUs": MessageLookupByLibrary.simpleMessage("تواصل معنا"),
        "createAccount": MessageLookupByLibrary.simpleMessage("انشاء حساب"),
        "currentOrder": MessageLookupByLibrary.simpleMessage("الطلبات الحالية"),
        "currentPassword":
            MessageLookupByLibrary.simpleMessage("كلمة السر الحالية"),
        "deleteAccount": MessageLookupByLibrary.simpleMessage("حذف الحساب"),
        "deleteAccountMessage": MessageLookupByLibrary.simpleMessage(
            "هل انت متأكد من حذف حسابك؟\nدا هيمسح كل بياناتك وطلباتك السابقة."),
        "discount": m0,
        "doNotHaveAccount":
            MessageLookupByLibrary.simpleMessage("ليس لديك حساب؟"),
        "editLocation": MessageLookupByLibrary.simpleMessage("تعديل الموقع"),
        "emailRequired":
            MessageLookupByLibrary.simpleMessage("البريد الإلكتروني مطلوب"),
        "emptyFavourite":
            MessageLookupByLibrary.simpleMessage("لا يوجد منتجات مفضلة لديك"),
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
        "gallery": MessageLookupByLibrary.simpleMessage("معرض الصور"),
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
        "loading": MessageLookupByLibrary.simpleMessage("جار التحميل"),
        "locationYourLocation":
            MessageLookupByLibrary.simpleMessage("حدد مكان محلك"),
        "login": MessageLookupByLibrary.simpleMessage("تسجيل الدخول"),
        "loginEnter": MessageLookupByLibrary.simpleMessage("الدخول"),
        "loginNow": MessageLookupByLibrary.simpleMessage("تسجيل الدخول الآن"),
        "logout": MessageLookupByLibrary.simpleMessage("تسجيل خروج"),
        "logoutMessage": MessageLookupByLibrary.simpleMessage(
            "هل أنت متأكد من أنك تريد تسجيل الخروج؟"),
        "mobileAlreadyRegistered": MessageLookupByLibrary.simpleMessage(
            "رقم الهاتف مسجل بالفعل من قبل"),
        "mobileExistBefore": MessageLookupByLibrary.simpleMessage(
            "رقم الهاتف مسجل لدينا بالفعل"),
        "more": MessageLookupByLibrary.simpleMessage("المزيد"),
        "neighborhood": MessageLookupByLibrary.simpleMessage("الحي"),
        "newPassword":
            MessageLookupByLibrary.simpleMessage("ادخل كلمة السر الجديدة"),
        "next": MessageLookupByLibrary.simpleMessage("التالي"),
        "noInternetConnection": MessageLookupByLibrary.simpleMessage(
            "لا يوجد اتصال بالإنترنت.\nيرجى المحاولة مرة أخرى لاحقًا"),
        "noSpaceAllowed":
            MessageLookupByLibrary.simpleMessage("يجب ألا تحتوي على مسافات"),
        "ok": MessageLookupByLibrary.simpleMessage("حسنًا"),
        "openSetting": m2,
        "password": MessageLookupByLibrary.simpleMessage("كلمة السر"),
        "passwordMinimumCharacters":
            MessageLookupByLibrary.simpleMessage("يجب ألا تقل عن 8 حروف"),
        "passwordNotMatched": MessageLookupByLibrary.simpleMessage(
            "كلمة المرور وتأكيد كلمة المرور غير متطابقين"),
        "pickLocationEnsureMessage": MessageLookupByLibrary.simpleMessage(
            "هل أنت متأكد أنك تريد تحديد هذا الموقع؟"),
        "platformName": MessageLookupByLibrary.simpleMessage("اسم المنشأه"),
        "previous": MessageLookupByLibrary.simpleMessage("السابق"),
        "previousOrder": MessageLookupByLibrary.simpleMessage("طلباتي السابقة"),
        "products": MessageLookupByLibrary.simpleMessage("المنتجات"),
        "promoDetails": MessageLookupByLibrary.simpleMessage("تفاصيل العرض"),
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
        "scanBarcode":
            MessageLookupByLibrary.simpleMessage("البحث عن طريق الباركود"),
        "scanText": MessageLookupByLibrary.simpleMessage(
            "تأكد من وجود الباركود ضمن\nالعلامات السوداء لمسح العنصر\nضوئيًا"),
        "search": MessageLookupByLibrary.simpleMessage("بحث"),
        "searchProduct":
            MessageLookupByLibrary.simpleMessage("بتدور على منتج معين؟"),
        "selectLocation": MessageLookupByLibrary.simpleMessage("حدد موقعك"),
        "selectPhotoFromCameraOrGallery":
            MessageLookupByLibrary.simpleMessage("ماذا تفضل؟"),
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
        "updateProfileBuildingData":
            MessageLookupByLibrary.simpleMessage("بيانات المنشأه"),
        "updateProfileBuildingName":
            MessageLookupByLibrary.simpleMessage("اسم المنشأه"),
        "updateProfileBuildingNumber":
            MessageLookupByLibrary.simpleMessage("رقم البناية / اسم الشارع"),
        "updateProfileDistrict": MessageLookupByLibrary.simpleMessage("الحي"),
        "updateProfileGovernorate":
            MessageLookupByLibrary.simpleMessage("المحافظة"),
        "updateProfileLocation": MessageLookupByLibrary.simpleMessage("الموقع"),
        "updateProfilePersonalData":
            MessageLookupByLibrary.simpleMessage("بياناتي الشخصية"),
        "updateProfileTitle":
            MessageLookupByLibrary.simpleMessage("بيانات حسابي"),
        "usagePolicy": MessageLookupByLibrary.simpleMessage("سياسة الاستخدام"),
        "validateOtp": MessageLookupByLibrary.simpleMessage("تحقيق"),
        "welcomeToDokkan":
            MessageLookupByLibrary.simpleMessage("مرحباً بك في دُكان"),
        "whatsApp": MessageLookupByLibrary.simpleMessage("واتساب"),
        "yes": MessageLookupByLibrary.simpleMessage("نعم"),
        "youCanStartOrderNow":
            MessageLookupByLibrary.simpleMessage("تقدر تطلب دلوقتي"),
        "youNeedToLoginToUseApp":
            MessageLookupByLibrary.simpleMessage("انت تحتاج الي تسجيل الدخول"),
        "yourMobile": MessageLookupByLibrary.simpleMessage("رقم الهاتف")
      };
}
