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
        "accountBalance": MessageLookupByLibrary.simpleMessage("رصيد الحساب"),
        "confirmLocation": MessageLookupByLibrary.simpleMessage("تأكيد الموقع"),
        "accountInfo": MessageLookupByLibrary.simpleMessage("بيانات حسابي"),
        "addToCart": MessageLookupByLibrary.simpleMessage("أضف الي السلة"),
        "changePasswordError":
            MessageLookupByLibrary.simpleMessage("خطأ في تغيير كلمة المرور"),
        "atLeastOneCapChar": MessageLookupByLibrary.simpleMessage(
            "يجب أن تحتوي على حرف كبير على الأقل"),
        "atLeastOneNumber":
            MessageLookupByLibrary.simpleMessage("يجب أن تحتوي على أرقام"),
        "atLeastOneSmallLetter":
            MessageLookupByLibrary.simpleMessage("يجب أن تحتوي على حروف"),
        "atLeastOneSpecialCharacter":
            MessageLookupByLibrary.simpleMessage("يجب أن تحتوي على رمز (@#_,)"),
        "basket": MessageLookupByLibrary.simpleMessage("السلة"),
        "bestOffers": MessageLookupByLibrary.simpleMessage("أقوى العروض"),
        "lastOffers": MessageLookupByLibrary.simpleMessage("آخر العروض"),
        "biometricLoginMessage":
            MessageLookupByLibrary.simpleMessage("يرجى المصادقة لتسجيل الدخول"),
        "browseSections": MessageLookupByLibrary.simpleMessage("تصفح الأقسام"),
        "camera": MessageLookupByLibrary.simpleMessage("الكاميرا"),
        "cancel": MessageLookupByLibrary.simpleMessage("إلغاء"),
        "cancelOrder": MessageLookupByLibrary.simpleMessage("إلغاء الطلب"),
        "cartCashOnDelivery":
            MessageLookupByLibrary.simpleMessage("كاش عند الاستلام"),
        "payCashOnDelivery":
            MessageLookupByLibrary.simpleMessage("الدفع كاش عند الاستلام"),
        "cartConfirmOrder": MessageLookupByLibrary.simpleMessage("تأكيد الطلب"),
        "cartDeleteMessage": MessageLookupByLibrary.simpleMessage(
            "هل انت متاكد من ازاله المنتج من السلة؟"),
        "cartDokkanWallet": MessageLookupByLibrary.simpleMessage("محفظة"),
        "cartDokkanWalletNumber":
            MessageLookupByLibrary.simpleMessage("رقم المحفظة"),
        "cartDokkanBankCard":
            MessageLookupByLibrary.simpleMessage("كارت البنك"),
        "cartEmpty":
            MessageLookupByLibrary.simpleMessage("لا يوجد طلبات حالياً"),
        "cartMaximumProductsReached": MessageLookupByLibrary.simpleMessage(
            "أقصي كميه يمكنك اضافتها لهذ المنتج هي"),
        "cartMinimumOrder":
            MessageLookupByLibrary.simpleMessage("الحد الأدنى للطلب !"),
        "cartMinimumProductsReached": MessageLookupByLibrary.simpleMessage(
            "أقل كميه يمكنك اضافتها لهذ المنتج هي"),
        "cartOrderNow": MessageLookupByLibrary.simpleMessage("تأكيد الطلب"),
        "cartOrderOrderDetails":
            MessageLookupByLibrary.simpleMessage("تفاصيل طلبك"),
        "cartPaymentOptions":
            MessageLookupByLibrary.simpleMessage("اختر وسيلة الدفع"),
        "cartProductDetails":
            MessageLookupByLibrary.simpleMessage("تفاصيل المنتجات"),
        "cartProductsSummary":
            MessageLookupByLibrary.simpleMessage("ملخص المنتجات"),
        "cartProductQuantityNotAvailable":
            MessageLookupByLibrary.simpleMessage("متوفر فقط بكمية"),
        "cartProductsNotAvailable": MessageLookupByLibrary.simpleMessage(
            "يوجد بعض المنتجات غير متوفرة"),
        "cartSuccessConfirmation":
            MessageLookupByLibrary.simpleMessage("تم تأكيد طلبك بنجاح"),
        "cartSuccessIsDelivering": MessageLookupByLibrary.simpleMessage(
            "طلبك هيوصلك خلال 24 ساعة \nتقدر دلوقتي تتابع مسار طلبكً"),
        "cartSuccessTrackButton":
            MessageLookupByLibrary.simpleMessage("تتبع مسار الطلب"),
        "cartTitle": MessageLookupByLibrary.simpleMessage("السلة"),
        "changePassword":
            MessageLookupByLibrary.simpleMessage("تغيير كلمة السر"),
        "chooseCity": MessageLookupByLibrary.simpleMessage("اختر محافظتك"),
        "chooseYourCountry": MessageLookupByLibrary.simpleMessage("اختر بلدك"),
        "city": MessageLookupByLibrary.simpleMessage("المحافظة"),
        "closeApplicationMessage": MessageLookupByLibrary.simpleMessage(
            "هل أنت متأكد أنك تريد الخروج من ديل؟"),
        "confirm": MessageLookupByLibrary.simpleMessage("تأكيد"),
        "confirmNewPassword": MessageLookupByLibrary.simpleMessage(
            "ادخل تاكيد كلمة السر الجديدة"),
        "confirmPassword":
            MessageLookupByLibrary.simpleMessage("تأكيد كلمة السر"),
        "contactUs": MessageLookupByLibrary.simpleMessage("تواصل معنا"),
        "createAccount": MessageLookupByLibrary.simpleMessage("انشاء حساب"),
        "currentOrders":
            MessageLookupByLibrary.simpleMessage("الطلبات الحالية"),
        "address": MessageLookupByLibrary.simpleMessage("العنوان"),
        "currentPassword":
            MessageLookupByLibrary.simpleMessage("كلمة السر الحالية"),
        "deleteAccount": MessageLookupByLibrary.simpleMessage("حذف الحساب"),
        "createAccountMessage": MessageLookupByLibrary.simpleMessage(
            "أنشئ حسابك وابدء في طلب كل احتياجاتك من نفس المكان دلوقتي"),
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
            MessageLookupByLibrary.simpleMessage("ادخل الأسم ثلاثي"),
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
        "enterYouRegisteredMobile": MessageLookupByLibrary.simpleMessage(
            "أدخل رقم الهاتف المسجل لدينا"),
        "enterYourPassword":
            MessageLookupByLibrary.simpleMessage("ادخل كلمة السر"),
        "faceBook": MessageLookupByLibrary.simpleMessage("فيس بوك"),
        "failed": MessageLookupByLibrary.simpleMessage("فشل"),
        "faq": MessageLookupByLibrary.simpleMessage("الأسئلة الشائعة"),
        "favourite": MessageLookupByLibrary.simpleMessage("المفضلة"),
        "favourites": MessageLookupByLibrary.simpleMessage("المفضلة"),
        "forgotPassword":
            MessageLookupByLibrary.simpleMessage("نسيت كلمة السر؟"),
        "resetPassword":
            MessageLookupByLibrary.simpleMessage("إعادة تعيين كلمة السر"),
        "fullName":
            MessageLookupByLibrary.simpleMessage("اسم صاحب المنشأة ثلاثي"),
        "threeFullName": MessageLookupByLibrary.simpleMessage("الاسم الثلاثي"),
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
        "invalidWallet":
            MessageLookupByLibrary.simpleMessage("يجب كتابة ١١ رقم"),
        "invalidPayment":
            MessageLookupByLibrary.simpleMessage("حدثت مشكلة في الدفع"),
        "itemsDetails": MessageLookupByLibrary.simpleMessage("تفاصيل المنتجات"),
        "loading": MessageLookupByLibrary.simpleMessage("جار التحميل"),
        "locationYourLocation":
            MessageLookupByLibrary.simpleMessage("بحث عن الموقع"),
        "login": MessageLookupByLibrary.simpleMessage("تسجيل الدخول"),
        "loginEnter": MessageLookupByLibrary.simpleMessage("تسجيل الدخول"),
        "loginNow": MessageLookupByLibrary.simpleMessage("تسجيل الدخول الآن"),
        "logout": MessageLookupByLibrary.simpleMessage("تسجيل خروج"),
        "logoutMessage": MessageLookupByLibrary.simpleMessage(
            "هل أنت متأكد من أنك تريد تسجيل الخروج؟"),
        "mobileAlreadyRegistered": MessageLookupByLibrary.simpleMessage(
            "رقم الهاتف مسجل بالفعل من قبل"),
        "mobileExistBefore": MessageLookupByLibrary.simpleMessage(
            "رقم الهاتف مسجل لدينا بالفعل"),
        "mobileIsNotExist":
            MessageLookupByLibrary.simpleMessage("رقم الهاتف غير موجود"),
        "more": MessageLookupByLibrary.simpleMessage("المزيد"),
        "myOrders": MessageLookupByLibrary.simpleMessage("طلباتي"),
        "neighborhood": MessageLookupByLibrary.simpleMessage("الحي"),
        "enterNewPassword":
            MessageLookupByLibrary.simpleMessage("ادخل كلمة السر الجديدة"),
        "newPassword":
            MessageLookupByLibrary.simpleMessage("كلمة السر الجديدة"),
        "next": MessageLookupByLibrary.simpleMessage("التالي"),
        "noInternetConnection": MessageLookupByLibrary.simpleMessage(
            "لا يوجد اتصال بالإنترنت.\nيرجى المحاولة مرة أخرى لاحقًا"),
        "noSpaceAllowed":
            MessageLookupByLibrary.simpleMessage("يجب ألا تحتوي على مسافات"),
        "offersTitle": MessageLookupByLibrary.simpleMessage("العروض"),
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
        "orderCancelReasonValidation": MessageLookupByLibrary.simpleMessage(
            "الرجاء إدخال سبب إلغاء الطلب"),
        "orderDelivered": MessageLookupByLibrary.simpleMessage("تسليم الطلب"),
        "orderDetails": MessageLookupByLibrary.simpleMessage("تفاصيل الطلب"),
        "orderInProgress": MessageLookupByLibrary.simpleMessage("قيد التنفيذ"),
        "orderItem": MessageLookupByLibrary.simpleMessage("قطعة"),
        "orderItemCount": MessageLookupByLibrary.simpleMessage("عدد القطع:"),
        "orderNotRecieved":
            MessageLookupByLibrary.simpleMessage("تم الغاء الطلب"),
        "orderNumber": MessageLookupByLibrary.simpleMessage("الطلب رقم:"),
        "orderOutside": MessageLookupByLibrary.simpleMessage("خارج للتوصيل"),
        "orderRecieved":
            MessageLookupByLibrary.simpleMessage("تم استلام الطلب"),
        "orderSending": MessageLookupByLibrary.simpleMessage("استلام الطلب"),
        "orderShipping": MessageLookupByLibrary.simpleMessage("شحن الطلب"),
        "orderTotal": MessageLookupByLibrary.simpleMessage("الإجمالي:"),
        "cartDetailsTotal": MessageLookupByLibrary.simpleMessage("الإجمالي"),
        "ordersNotFound": MessageLookupByLibrary.simpleMessage(
            "لم تقم بطلب اي منتج حتي الان"),
        "otpIsNotValid":
            MessageLookupByLibrary.simpleMessage("خطأ في رمز التحقق"),
        "otpAuthenticate": MessageLookupByLibrary.simpleMessage("تحقق"),
        "otpPhoneIsNotValid":
            MessageLookupByLibrary.simpleMessage("خطأ في رقم الهاتف"),
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
        "productIsNotAvailable":
            MessageLookupByLibrary.simpleMessage("المنتج غير متوفر"),
        "products": MessageLookupByLibrary.simpleMessage("المنتجات"),
        "productsFilterAll": MessageLookupByLibrary.simpleMessage("الكل"),
        "promoDetails": MessageLookupByLibrary.simpleMessage("تفاصيل العرض"),
        "promoItems": MessageLookupByLibrary.simpleMessage("منتجات العرض"),
        "promotion": MessageLookupByLibrary.simpleMessage("العروض"),
        "registerMessageOtp": MessageLookupByLibrary.simpleMessage(
            "أول ما تدوس عالتالي هنبعتلك رسالة تفعيل لحسابك"),
        "registerNewAccount":
            MessageLookupByLibrary.simpleMessage("تسجيل حساب جديد"),
        "registerNow": MessageLookupByLibrary.simpleMessage("انشئ حساب جديد"),
        "required": MessageLookupByLibrary.simpleMessage("حقل مطلوب"),
        "resendOtpAfter": m3,
        "resetPasswordSetting":
            MessageLookupByLibrary.simpleMessage("إعادة ضبط كلمة السر"),
        "save": MessageLookupByLibrary.simpleMessage("حفظ"),
        "saveChange": MessageLookupByLibrary.simpleMessage("حفظ التغيير"),
        "editData": MessageLookupByLibrary.simpleMessage("تعديل البيانات"),
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
        "sendOTP": MessageLookupByLibrary.simpleMessage("إرسال رمز التحقق"),
        "sendOtpAgain":
            MessageLookupByLibrary.simpleMessage("إعادة إرسال رمز التحقق"),
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
        "updateProfileLocation":
            MessageLookupByLibrary.simpleMessage("موقع المنشأة"),
        "updateProfilePersonalData":
            MessageLookupByLibrary.simpleMessage("البيانات الشخصية"),
        "updateProfileTitle":
            MessageLookupByLibrary.simpleMessage("بيانات حسابي"),
        "usagePolicy": MessageLookupByLibrary.simpleMessage("سياسة الاستخدام"),
        "usagePolicyTitle":
            MessageLookupByLibrary.simpleMessage("سياسة الاستخدام"),
        "validateOtp": MessageLookupByLibrary.simpleMessage("تحقيق"),
        "welcomeToDokkan":
            MessageLookupByLibrary.simpleMessage("أهلاً بيك في تطبيق"),
        "whatsApp": MessageLookupByLibrary.simpleMessage("واتساب"),
        "yes": MessageLookupByLibrary.simpleMessage("نعم"),
        "youCanStartOrderNow": MessageLookupByLibrary.simpleMessage(
            "تقدر تطلب كل احتياجاتك من نفس المكان دلوقتي"),
        "startOrderNow": MessageLookupByLibrary.simpleMessage(
            "اطلب كل احتياجاتك من نفس المكان دلوقتي"),
        "youNeedToLoginToUseApp":
            MessageLookupByLibrary.simpleMessage("انت تحتاج الي تسجيل الدخول"),
        "yourMobile": MessageLookupByLibrary.simpleMessage("رقم الهاتف"),
        "goToMainPage":
            MessageLookupByLibrary.simpleMessage("الذهاب الي الرئيسية"),
      };
}
