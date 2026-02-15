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

  static String m0(price, currency) => "تأكيد الحجز (${price} ${currency})";

  static String m1(method) => "تم الدفع عبر ${method}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "aboutService": MessageLookupByLibrary.simpleMessage("عن الخدمة"),
    "accountSettings": MessageLookupByLibrary.simpleMessage("إعدادات الحساب"),
    "active": MessageLookupByLibrary.simpleMessage("نشطة"),
    "addNotesHint": MessageLookupByLibrary.simpleMessage(
      "أضف أي تفاصيل أخرى...",
    ),
    "addService": MessageLookupByLibrary.simpleMessage("إضافة خدمة"),
    "addServiceImage": MessageLookupByLibrary.simpleMessage("صورة الخدمة"),
    "addServiceTitle": MessageLookupByLibrary.simpleMessage("إضافة خدمة جديدة"),
    "additionalNotes": MessageLookupByLibrary.simpleMessage("ملاحظات إضافية"),
    "all": MessageLookupByLibrary.simpleMessage("الكل"),
    "alreadyHaveAccount": MessageLookupByLibrary.simpleMessage(
      "لديك حساب بالفعل؟ ",
    ),
    "appName": MessageLookupByLibrary.simpleMessage("خدماتي"),
    "applyFilters": MessageLookupByLibrary.simpleMessage("تطبيق الفلاتر"),
    "appointment": MessageLookupByLibrary.simpleMessage("موعد"),
    "appointmentDescription": MessageLookupByLibrary.simpleMessage(
      "حجز موعد مسبق",
    ),
    "availability": MessageLookupByLibrary.simpleMessage("التوفر"),
    "availabilitySubtitle": MessageLookupByLibrary.simpleMessage(
      "متى تكون متاحاً",
    ),
    "bookNow": MessageLookupByLibrary.simpleMessage("احجز الآن"),
    "bookingDate": MessageLookupByLibrary.simpleMessage("تاريخ الحجز"),
    "bookingDetails": MessageLookupByLibrary.simpleMessage("تفاصيل الحجز"),
    "bookingFailed": MessageLookupByLibrary.simpleMessage("فشل الحجز"),
    "bookingSuccess": MessageLookupByLibrary.simpleMessage("تم الحجز بنجاح!"),
    "bookings": MessageLookupByLibrary.simpleMessage("الحجوزات"),
    "cancel": MessageLookupByLibrary.simpleMessage("إلغاء"),
    "cancelled": MessageLookupByLibrary.simpleMessage("الملغاة"),
    "categories": MessageLookupByLibrary.simpleMessage("الفئات"),
    "category": MessageLookupByLibrary.simpleMessage("الفئة"),
    "changePassword": MessageLookupByLibrary.simpleMessage("تغيير كلمة المرور"),
    "clearFilters": MessageLookupByLibrary.simpleMessage("مسح الفلاتر"),
    "completed": MessageLookupByLibrary.simpleMessage("مكتمل"),
    "completedServices": MessageLookupByLibrary.simpleMessage("مكتملة"),
    "confirm": MessageLookupByLibrary.simpleMessage("تأكيد"),
    "confirmBookingWithPrice": m0,
    "confirmPassword": MessageLookupByLibrary.simpleMessage(
      "تأكيد كلمة المرور",
    ),
    "confirmYourPassword": MessageLookupByLibrary.simpleMessage(
      "أكد كلمة المرور",
    ),
    "confirmed": MessageLookupByLibrary.simpleMessage("مؤكد"),
    "createAccount": MessageLookupByLibrary.simpleMessage("إنشاء حساب"),
    "currency": MessageLookupByLibrary.simpleMessage("جنيه"),
    "darkMode": MessageLookupByLibrary.simpleMessage("الوضع الليلي"),
    "declined": MessageLookupByLibrary.simpleMessage("تم الرفض"),
    "delete": MessageLookupByLibrary.simpleMessage("حذف"),
    "deleteService": MessageLookupByLibrary.simpleMessage("حذف الخدمة"),
    "deleteServiceConfirmation": MessageLookupByLibrary.simpleMessage(
      "هل أنت متأكد من حذف هذه الخدمة؟",
    ),
    "done": MessageLookupByLibrary.simpleMessage("تم"),
    "dontHaveAccount": MessageLookupByLibrary.simpleMessage("ليس لديك حساب؟ "),
    "duration": MessageLookupByLibrary.simpleMessage("المدة"),
    "durationHint": MessageLookupByLibrary.simpleMessage("مثال: 30"),
    "edit": MessageLookupByLibrary.simpleMessage("تعديل"),
    "editProfile": MessageLookupByLibrary.simpleMessage("تعديل الملف الشخصي"),
    "email": MessageLookupByLibrary.simpleMessage("البريد الإلكتروني"),
    "emailNotVerified": MessageLookupByLibrary.simpleMessage(
      "لم يتم تأكيد البريد الإلكتروني بعد. يرجى التحقق من صندوق الوارد.",
    ),
    "emailSent": MessageLookupByLibrary.simpleMessage(
      "تم إرسال رسالة التأكيد!",
    ),
    "endTime": MessageLookupByLibrary.simpleMessage("إلى"),
    "enterCategory": MessageLookupByLibrary.simpleMessage(
      "أدخل الفئة (مثل: سباكة، تنظيف)",
    ),
    "enterDescription": MessageLookupByLibrary.simpleMessage("صف خدمتك"),
    "enterPrice": MessageLookupByLibrary.simpleMessage("أدخل السعر"),
    "enterServiceTitle": MessageLookupByLibrary.simpleMessage(
      "أدخل اسم الخدمة",
    ),
    "enterYourEmail": MessageLookupByLibrary.simpleMessage(
      "أدخل بريدك الإلكتروني",
    ),
    "enterYourName": MessageLookupByLibrary.simpleMessage("أدخل اسمك الكامل"),
    "enterYourPassword": MessageLookupByLibrary.simpleMessage(
      "أدخل كلمة المرور",
    ),
    "enterYourPhone": MessageLookupByLibrary.simpleMessage("أدخل رقم موبايلك"),
    "errorDataNotFound": MessageLookupByLibrary.simpleMessage(
      "لم يتم العثور على البيانات",
    ),
    "errorEmailAlreadyInUse": MessageLookupByLibrary.simpleMessage(
      "هذا البريد الإلكتروني مسجل بالفعل",
    ),
    "errorInvalidEmail": MessageLookupByLibrary.simpleMessage(
      "عنوان بريد إلكتروني غير صالح",
    ),
    "errorLoginFailed": MessageLookupByLibrary.simpleMessage(
      "فشل تسجيل الدخول. يرجى المحاولة مرة أخرى",
    ),
    "errorNetworkRequestFailed": MessageLookupByLibrary.simpleMessage(
      "خطأ في الشبكة. يرجى التحقق من اتصالك",
    ),
    "errorOperationNotAllowed": MessageLookupByLibrary.simpleMessage(
      "هذه العملية غير مسموح بها",
    ),
    "errorPermissionDenied": MessageLookupByLibrary.simpleMessage(
      "الصلاحية مرفوضة",
    ),
    "errorRegistrationFailed": MessageLookupByLibrary.simpleMessage(
      "فشل التسجيل. يرجى المحاولة مرة أخرى",
    ),
    "errorSaveFailed": MessageLookupByLibrary.simpleMessage("فشل حفظ البيانات"),
    "errorTooManyRequests": MessageLookupByLibrary.simpleMessage(
      "محاولات كثيرة. يرجى المحاولة لاحقاً",
    ),
    "errorUnknown": MessageLookupByLibrary.simpleMessage("حدث خطأ غير معروف"),
    "errorUserDisabled": MessageLookupByLibrary.simpleMessage(
      "تم تعطيل هذا الحساب",
    ),
    "errorUserNotFound": MessageLookupByLibrary.simpleMessage(
      "لا يوجد حساب بهذا البريد الإلكتروني",
    ),
    "errorWeakPassword": MessageLookupByLibrary.simpleMessage(
      "كلمة المرور ضعيفة جداً",
    ),
    "errorWrongPassword": MessageLookupByLibrary.simpleMessage(
      "كلمة المرور غير صحيحة",
    ),
    "explore": MessageLookupByLibrary.simpleMessage("استكشف"),
    "favoriteServices": MessageLookupByLibrary.simpleMessage("الخدمات المفضلة"),
    "featuredServices": MessageLookupByLibrary.simpleMessage("الخدمات المميزة"),
    "filters": MessageLookupByLibrary.simpleMessage("الفلاتر"),
    "forgotPassword": MessageLookupByLibrary.simpleMessage("نسيت كلمة المرور؟"),
    "fri": MessageLookupByLibrary.simpleMessage("جمعة"),
    "from": MessageLookupByLibrary.simpleMessage("من"),
    "fullName": MessageLookupByLibrary.simpleMessage("الاسم الكامل"),
    "getStarted": MessageLookupByLibrary.simpleMessage("ابدأ الآن"),
    "getStartedFree": MessageLookupByLibrary.simpleMessage("ابدأ مجاناً"),
    "helpSupport": MessageLookupByLibrary.simpleMessage("المساعدة والدعم"),
    "home": MessageLookupByLibrary.simpleMessage("الرئيسية"),
    "iVerified": MessageLookupByLibrary.simpleMessage(
      "لقد أكدت بريدي الإلكتروني",
    ),
    "imageComingSoon": MessageLookupByLibrary.simpleMessage("رفع الصور قريباً"),
    "imageSubtitle": MessageLookupByLibrary.simpleMessage("أضف صور لأعمالك"),
    "inactive": MessageLookupByLibrary.simpleMessage("غير نشطة"),
    "loadingBookings": MessageLookupByLibrary.simpleMessage(
      "جاري تحميل الحجوزات...",
    ),
    "loadingHomeData": MessageLookupByLibrary.simpleMessage(
      "جاري تحميل البيانات...",
    ),
    "loadingServices": MessageLookupByLibrary.simpleMessage(
      "جاري تحميل الخدمات...",
    ),
    "location": MessageLookupByLibrary.simpleMessage("الموقع"),
    "locationSubtitle": MessageLookupByLibrary.simpleMessage(
      "أين تقدم هذه الخدمة",
    ),
    "login": MessageLookupByLibrary.simpleMessage("تسجيل الدخول"),
    "logout": MessageLookupByLibrary.simpleMessage("تسجيل الخروج"),
    "logoutConfirmation": MessageLookupByLibrary.simpleMessage(
      "هل أنت متأكد من تسجيل الخروج؟",
    ),
    "mapConfirmLocation": MessageLookupByLibrary.simpleMessage("تأكيد الموقع"),
    "mapLoadingLocation": MessageLookupByLibrary.simpleMessage(
      "جاري تحميل العنوان...",
    ),
    "mapPickLocation": MessageLookupByLibrary.simpleMessage("اختر الموقع"),
    "mapUseCurrentLocation": MessageLookupByLibrary.simpleMessage(
      "استخدم موقعي الحالي",
    ),
    "memberSince": MessageLookupByLibrary.simpleMessage("عضو منذ"),
    "min": MessageLookupByLibrary.simpleMessage("د"),
    "minimumRating": MessageLookupByLibrary.simpleMessage(
      "الحد الأدنى للتقييم",
    ),
    "minutes": MessageLookupByLibrary.simpleMessage("دقيقة"),
    "mon": MessageLookupByLibrary.simpleMessage("اثنين"),
    "mostPopular": MessageLookupByLibrary.simpleMessage("الأكثر شعبية"),
    "myAddresses": MessageLookupByLibrary.simpleMessage("عناويني"),
    "myBookings": MessageLookupByLibrary.simpleMessage("حجوزاتي"),
    "myServicesTitle": MessageLookupByLibrary.simpleMessage("خدماتي"),
    "next": MessageLookupByLibrary.simpleMessage("التالي"),
    "noCancelledBookings": MessageLookupByLibrary.simpleMessage(
      "لا توجد حجوزات ملغاة",
    ),
    "noImage": MessageLookupByLibrary.simpleMessage("لا توجد صورة متوفرة"),
    "noPastBookings": MessageLookupByLibrary.simpleMessage(
      "لا توجد حجوزات سابقة",
    ),
    "noResultsFor": MessageLookupByLibrary.simpleMessage("لا توجد نتائج لـ"),
    "noServices": MessageLookupByLibrary.simpleMessage("لا توجد خدمات متاحة"),
    "noServicesYet": MessageLookupByLibrary.simpleMessage("لا توجد خدمات بعد"),
    "noUpcomingBookings": MessageLookupByLibrary.simpleMessage(
      "لا توجد حجوزات قادمة",
    ),
    "notifications": MessageLookupByLibrary.simpleMessage("الإشعارات"),
    "onDemand": MessageLookupByLibrary.simpleMessage("فوري"),
    "onDemandDescription": MessageLookupByLibrary.simpleMessage(
      "طلب فوري الآن",
    ),
    "onboardingDesc1": MessageLookupByLibrary.simpleMessage(
      "تواصل مع أفضل مقدمي الخدمات في منطقتك.",
    ),
    "onboardingDesc2": MessageLookupByLibrary.simpleMessage(
      "احجز مواعيدك بضغطة زر.",
    ),
    "onboardingDesc3": MessageLookupByLibrary.simpleMessage(
      "ادفع بأمان من خلال التطبيق.",
    ),
    "onboardingTitle1": MessageLookupByLibrary.simpleMessage(
      "اعثر على خدمات محلية",
    ),
    "onboardingTitle2": MessageLookupByLibrary.simpleMessage("حجز سهل"),
    "onboardingTitle3": MessageLookupByLibrary.simpleMessage("دفع آمن"),
    "paidVia": m1,
    "password": MessageLookupByLibrary.simpleMessage("كلمة المرور"),
    "passwordMinLength": MessageLookupByLibrary.simpleMessage(
      "يجب أن تكون كلمة المرور 6 أحرف على الأقل",
    ),
    "passwordsDontMatch": MessageLookupByLibrary.simpleMessage(
      "كلمات المرور غير متطابقة",
    ),
    "past": MessageLookupByLibrary.simpleMessage("السابقة"),
    "payWithPaymob": MessageLookupByLibrary.simpleMessage("الدفع عبر Paymob"),
    "payWithPaypal": MessageLookupByLibrary.simpleMessage("الدفع عبر PayPal"),
    "payWithStripe": MessageLookupByLibrary.simpleMessage("الدفع عبر Stripe"),
    "payment": MessageLookupByLibrary.simpleMessage("الدفع"),
    "paymentMethods": MessageLookupByLibrary.simpleMessage("طرق الدفع"),
    "paymentSuccessful": MessageLookupByLibrary.simpleMessage(
      "تمت عملية الدفع بنجاح!",
    ),
    "paymentTotalAmount": MessageLookupByLibrary.simpleMessage(
      "المبلغ الإجمالي",
    ),
    "paymobTestMode": MessageLookupByLibrary.simpleMessage(
      "🧪 وضع التجريب - استخدم بطاقات اختبار",
    ),
    "paypalNote": MessageLookupByLibrary.simpleMessage(
      "تواصل معنا لأي استفسارات حول طلبك.",
    ),
    "pending": MessageLookupByLibrary.simpleMessage("قيد الانتظار"),
    "perHour": MessageLookupByLibrary.simpleMessage("في الساعة"),
    "perVisit": MessageLookupByLibrary.simpleMessage("لكل زيارة"),
    "phoneNumber": MessageLookupByLibrary.simpleMessage("رقم الموبايل"),
    "pleaseEnterCategory": MessageLookupByLibrary.simpleMessage(
      "الرجاء إدخال الفئة",
    ),
    "pleaseEnterDescription": MessageLookupByLibrary.simpleMessage(
      "الرجاء إدخال الوصف",
    ),
    "pleaseEnterDuration": MessageLookupByLibrary.simpleMessage(
      "الرجاء إدخال المدة",
    ),
    "pleaseEnterEmail": MessageLookupByLibrary.simpleMessage(
      "الرجاء إدخال بريدك الإلكتروني",
    ),
    "pleaseEnterFullName": MessageLookupByLibrary.simpleMessage(
      "الرجاء إدخال اسمك الكامل (الاسم الأول والأخير)",
    ),
    "pleaseEnterName": MessageLookupByLibrary.simpleMessage(
      "الرجاء إدخال اسمك",
    ),
    "pleaseEnterPassword": MessageLookupByLibrary.simpleMessage(
      "الرجاء إدخال كلمة المرور",
    ),
    "pleaseEnterPhone": MessageLookupByLibrary.simpleMessage(
      "الرجاء إدخال رقم الموبايل",
    ),
    "pleaseEnterPrice": MessageLookupByLibrary.simpleMessage(
      "الرجاء إدخال السعر",
    ),
    "pleaseEnterTitle": MessageLookupByLibrary.simpleMessage(
      "الرجاء إدخال اسم الخدمة",
    ),
    "pleaseEnterValidEmail": MessageLookupByLibrary.simpleMessage(
      "الرجاء إدخال بريد إلكتروني صحيح",
    ),
    "pleaseEnterValidPhone": MessageLookupByLibrary.simpleMessage(
      "الرجاء إدخال رقم موبايل صحيح",
    ),
    "pleaseSelectLocation": MessageLookupByLibrary.simpleMessage(
      "الرجاء اختيار الموقع",
    ),
    "popularProviders": MessageLookupByLibrary.simpleMessage(
      "مقدمو الخدمات المشهورون",
    ),
    "price": MessageLookupByLibrary.simpleMessage("السعر"),
    "priceHighToLow": MessageLookupByLibrary.simpleMessage(
      "السعر: من الأعلى للأقل",
    ),
    "priceLowToHigh": MessageLookupByLibrary.simpleMessage(
      "السعر: من الأقل للأعلى",
    ),
    "priceRange": MessageLookupByLibrary.simpleMessage("نطاق السعر"),
    "priceUnit": MessageLookupByLibrary.simpleMessage("وحدة السعر"),
    "pricingSubtitle": MessageLookupByLibrary.simpleMessage("حدد سعر خدمتك"),
    "pricingTitle": MessageLookupByLibrary.simpleMessage("التسعير"),
    "privacyPolicy": MessageLookupByLibrary.simpleMessage("سياسة الخصوصية"),
    "processingPayment": MessageLookupByLibrary.simpleMessage(
      "جاري معالجة الدفع...",
    ),
    "profile": MessageLookupByLibrary.simpleMessage("الملف الشخصي"),
    "provider": MessageLookupByLibrary.simpleMessage("مزود الخدمة"),
    "quickActions": MessageLookupByLibrary.simpleMessage("إجراءات سريعة"),
    "rating": MessageLookupByLibrary.simpleMessage("التقييم"),
    "resendEmail": MessageLookupByLibrary.simpleMessage("إعادة الإرسال"),
    "reviews": MessageLookupByLibrary.simpleMessage("التقييمات"),
    "sat": MessageLookupByLibrary.simpleMessage("سبت"),
    "saveService": MessageLookupByLibrary.simpleMessage("حفظ الخدمة"),
    "searchServices": MessageLookupByLibrary.simpleMessage("ابحث عن خدمة..."),
    "seeAll": MessageLookupByLibrary.simpleMessage("عرض الكل"),
    "selectDate": MessageLookupByLibrary.simpleMessage("اختر التاريخ"),
    "selectPaymentMethod": MessageLookupByLibrary.simpleMessage(
      "اختر طريقة الدفع",
    ),
    "selectTime": MessageLookupByLibrary.simpleMessage("اختر الوقت"),
    "serviceActive": MessageLookupByLibrary.simpleMessage("نشطة"),
    "serviceAdded": MessageLookupByLibrary.simpleMessage(
      "تمت إضافة الخدمة بنجاح",
    ),
    "serviceDescription": MessageLookupByLibrary.simpleMessage("الوصف"),
    "serviceInactive": MessageLookupByLibrary.simpleMessage("غير نشطة"),
    "serviceInfo": MessageLookupByLibrary.simpleMessage("معلومات الخدمة"),
    "serviceInfoSubtitle": MessageLookupByLibrary.simpleMessage(
      "التفاصيل الأساسية عن خدمتك",
    ),
    "serviceLocation": MessageLookupByLibrary.simpleMessage("موقع الخدمة"),
    "serviceTitle": MessageLookupByLibrary.simpleMessage("اسم الخدمة"),
    "serviceType": MessageLookupByLibrary.simpleMessage("نوع الخدمة"),
    "serviceTypeSection": MessageLookupByLibrary.simpleMessage("نوع الخدمة"),
    "serviceTypeSectionSubtitle": MessageLookupByLibrary.simpleMessage(
      "كيف سيحجز العملاء",
    ),
    "settings": MessageLookupByLibrary.simpleMessage("الإعدادات"),
    "signIn": MessageLookupByLibrary.simpleMessage("تسجيل الدخول"),
    "signInToContinue": MessageLookupByLibrary.simpleMessage(
      "سجل الدخول للمتابعة",
    ),
    "signUp": MessageLookupByLibrary.simpleMessage("إنشاء حساب"),
    "skip": MessageLookupByLibrary.simpleMessage("تخطي"),
    "sortBy": MessageLookupByLibrary.simpleMessage("ترتيب حسب"),
    "startAddingServices": MessageLookupByLibrary.simpleMessage(
      "ابدأ بإضافة خدماتك للوصول للعملاء",
    ),
    "startTime": MessageLookupByLibrary.simpleMessage("من"),
    "sun": MessageLookupByLibrary.simpleMessage("أحد"),
    "tapToAddImage": MessageLookupByLibrary.simpleMessage("اضغط لإضافة صورة"),
    "tapToSelectLocation": MessageLookupByLibrary.simpleMessage(
      "اضغط لاختيار الموقع",
    ),
    "termsOfService": MessageLookupByLibrary.simpleMessage("شروط الخدمة"),
    "thu": MessageLookupByLibrary.simpleMessage("خميس"),
    "timeSlot": MessageLookupByLibrary.simpleMessage("الوقت"),
    "topRated": MessageLookupByLibrary.simpleMessage("الأعلى تقييماً"),
    "totalBookings": MessageLookupByLibrary.simpleMessage("إجمالي الحجوزات"),
    "totalSpent": MessageLookupByLibrary.simpleMessage("إجمالي الإنفاق"),
    "transactionId": MessageLookupByLibrary.simpleMessage("رقم العملية"),
    "tryDifferentKeywords": MessageLookupByLibrary.simpleMessage(
      "جرب كلمات مختلفة أو امسح الفلاتر",
    ),
    "tue": MessageLookupByLibrary.simpleMessage("ثلاثاء"),
    "upcoming": MessageLookupByLibrary.simpleMessage("القادمة"),
    "verifyEmail": MessageLookupByLibrary.simpleMessage(
      "تأكيد البريد الإلكتروني",
    ),
    "verifyEmailDesc": MessageLookupByLibrary.simpleMessage(
      "لقد أرسلنا رابط تأكيد إلى",
    ),
    "verifyEmailTitle": MessageLookupByLibrary.simpleMessage(
      "تأكد من بريدك الإلكتروني",
    ),
    "viewDetails": MessageLookupByLibrary.simpleMessage("عرض التفاصيل"),
    "wed": MessageLookupByLibrary.simpleMessage("أربعاء"),
    "welcomeBack": MessageLookupByLibrary.simpleMessage("مرحباً بعودتك"),
    "workDays": MessageLookupByLibrary.simpleMessage("أيام العمل"),
    "workingHours": MessageLookupByLibrary.simpleMessage("ساعات العمل"),
  };
}
