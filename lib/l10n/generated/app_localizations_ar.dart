// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get commonBack => 'رجوع';

  @override
  String get commonClose => 'إغلاق';

  @override
  String get commonCancel => 'إلغاء';

  @override
  String get commonSave => 'حفظ';

  @override
  String get commonDone => 'تم';

  @override
  String get commonEdit => 'تعديل';

  @override
  String get commonDelete => 'حذف';

  @override
  String get commonContinue => 'متابعة';

  @override
  String get commonSkip => 'تخطي';

  @override
  String get commonToday => 'اليوم';

  @override
  String get commonTomorrow => 'غدًا';

  @override
  String get commonYesterday => 'أمس';

  @override
  String get commonOptional => 'اختياري';

  @override
  String get commonNone => 'لا شيء';

  @override
  String get commonRetry => 'حاول مرة أخرى';

  @override
  String get commonViewAll => 'عرض الكل';

  @override
  String get commonSomethingWrong => 'حدث خطأ ما';

  @override
  String get commonSomethingWrongBody =>
      'تعذّر تحميل هذا القسم. بياناتك محفوظة بأمان على هذا الجهاز.';

  @override
  String get commonRequired => 'هذا الحقل مطلوب';

  @override
  String get commonInvalidNumber => 'أدخل رقمًا صالحًا';

  @override
  String get commonSaved => 'تم الحفظ';

  @override
  String get commonConfirm => 'تأكيد';

  @override
  String get commonDate => 'التاريخ';

  @override
  String get commonTime => 'الوقت';

  @override
  String get commonNote => 'ملاحظة';

  @override
  String get commonNotePlaceholder => 'أضف ملاحظة قصيرة';

  @override
  String get commonMinutes => 'الدقائق';

  @override
  String commonMinutesShort(int count) {
    return '$count د';
  }

  @override
  String get commonLinkedGoal => 'يُحتسب ضمن هدف';

  @override
  String get commonNoLinkedGoal => 'غير مرتبط بهدف';

  @override
  String commonPercentComplete(int percent) {
    return 'مكتمل بنسبة $percent%';
  }

  @override
  String commonOfTotal(int done, int total) {
    return '$done من $total';
  }

  @override
  String get commonOnTrack => 'على المسار الصحيح';

  @override
  String get commonNeedsAttention => 'يحتاج إلى متابعة';

  @override
  String get commonCompleted => 'مكتمل';

  @override
  String get commonPaused => 'متوقف مؤقتًا';

  @override
  String get commonActive => 'نشط';

  @override
  String get commonWeek => 'أسبوع';

  @override
  String get commonMonth => 'شهر';

  @override
  String get commonYear => 'سنة';

  @override
  String get commonThisWeek => 'هذا الأسبوع';

  @override
  String get commonThisMonth => 'هذا الشهر';

  @override
  String get commonLastMonth => 'الشهر الماضي';

  @override
  String get commonDecrease => 'إنقاص';

  @override
  String get commonIncrease => 'زيادة';

  @override
  String get commonAdd => 'إضافة';

  @override
  String get commonUndo => 'تراجع';

  @override
  String get commonMore => 'خيارات أخرى';

  @override
  String get commonDiscard => 'تجاهل';

  @override
  String get commonKeepEditing => 'متابعة التعديل';

  @override
  String get commonUnsavedTitle => 'تجاهل التغييرات؟';

  @override
  String get commonUnsavedBody => 'لم يتم حفظ تغييراتك بعد.';

  @override
  String get areaQuran => 'القرآن';

  @override
  String get areaWork => 'العمل';

  @override
  String get areaFinance => 'المال';

  @override
  String get areaHealth => 'الصحة';

  @override
  String get areaLearning => 'التعلّم';

  @override
  String get areaPersonal => 'شخصي';

  @override
  String get areaReview => 'مراجعة';

  @override
  String get areaQuranLong => 'القرآن والإيمان';

  @override
  String get areaWorkLong => 'العمل والنمو';

  @override
  String get areaFinanceLong => 'المال الشخصي';

  @override
  String get areaHealthLong => 'الصحة والعادات';

  @override
  String get areaLearningLong => 'التعلّم';

  @override
  String get areaPersonalLong => 'الحياة الشخصية';

  @override
  String get navToday => 'اليوم';

  @override
  String get navProgress => 'التقدّم';

  @override
  String get navGoals => 'الأهداف';

  @override
  String get navProfile => 'الملف الشخصي';

  @override
  String get navQuickAdd => 'إضافة سريعة';

  @override
  String get reminderMorningTitle => 'المراجعة الصباحية';

  @override
  String get reminderMorningBody => 'خذ دقيقة لاختيار أهم 3 أولويات لليوم.';

  @override
  String get reminderNightTitle => 'مراجعة المساء';

  @override
  String get reminderNightBody => 'اختم يومك بتأمل هادئ في 3 أسئلة.';

  @override
  String get reminderQuranReadingTitle => 'قراءة القرآن';

  @override
  String get reminderQuranReadingBody =>
      'واصل وردك من القرآن عندما تكون مستعدًا.';

  @override
  String get reminderQuranMemoTitle => 'مراجعة الحفظ';

  @override
  String get reminderQuranMemoBody => 'واصل حفظك الحالي متى وجدت لحظة هادئة.';

  @override
  String get reminderQuranRevisionTitle => 'المراجعة';

  @override
  String get reminderQuranRevisionBody => 'حافظ على ما حفظته بمراجعة قصيرة.';

  @override
  String reminderHabitTitle(String habit) {
    return '$habit';
  }

  @override
  String get reminderHabitBody => 'تذكير لطيف بعادتك اليوم.';

  @override
  String get reminderWorkTitle => 'المتابعات';

  @override
  String get reminderWorkBody =>
      'راجع العروض والعملاء المحتملين الذين يحتاجون إلى متابعة اليوم.';

  @override
  String get reminderWeeklyTitle => 'مراجعة الأسبوع';

  @override
  String get reminderWeeklyBody =>
      'مراجعتك الأسبوعية جاهزة. تأمل أسبوعك وحدد أولوياتك الثلاث القادمة.';

  @override
  String get reminderMonthlyTitle => 'مراجعة الشهر';

  @override
  String get reminderMonthlyBody => 'راجع شهرك وخطط للشهر القادم.';

  @override
  String get splashTagline => 'تقدّم، يومًا بعد يوم.';

  @override
  String get splashFooter => 'اصنع أيامًا أفضل.';

  @override
  String get authWelcomeBack => 'مرحبًا بعودتك';

  @override
  String get authWelcomeCreate => 'أنشئ حسابك';

  @override
  String get authSubtitle => 'واصل تقدّمك.';

  @override
  String get authCreateSubtitle =>
      'يبقى حسابك وبياناتك على هذا الجهاز، دون الحاجة إلى الإنترنت.';

  @override
  String get authTabSignIn => 'تسجيل الدخول';

  @override
  String get authTabCreate => 'إنشاء حساب';

  @override
  String get authEmail => 'البريد الإلكتروني';

  @override
  String get authEmailHint => 'name@example.com';

  @override
  String get authPassword => 'كلمة المرور';

  @override
  String get authFullName => 'الاسم الكامل';

  @override
  String get authNameHint => 'عمر الفاروق';

  @override
  String get authCreatePassword => 'أنشئ كلمة مرور';

  @override
  String get authPasswordHint => '8 أحرف على الأقل';

  @override
  String get authShowPassword => 'إظهار كلمة المرور';

  @override
  String get authHidePassword => 'إخفاء كلمة المرور';

  @override
  String get authRememberMe => 'تذكّرني';

  @override
  String get authForgot => 'نسيت كلمة المرور؟';

  @override
  String get authRuleLength => '8 أحرف أو أكثر';

  @override
  String get authRuleMix => 'حروف وأرقام';

  @override
  String get authTermsPrefix => 'بانضمامك إلى تقدّم، فإنك توافق على ';

  @override
  String get authTerms => 'الشروط';

  @override
  String get authAnd => ' و';

  @override
  String get authPrivacy => 'سياسة الخصوصية';

  @override
  String get authOrContinue => 'أو تابع باستخدام';

  @override
  String get authContinueDevice => 'المتابعة على هذا الجهاز';

  @override
  String get authNoAccount => 'ليس لديك حساب؟';

  @override
  String get authHaveAccount => 'لديك حساب بالفعل؟';

  @override
  String get authCreateLink => 'إنشاء حساب';

  @override
  String get authSignInLink => 'تسجيل الدخول';

  @override
  String get authErrEmail => 'أدخل بريدًا إلكترونيًا صالحًا';

  @override
  String get authErrPassword =>
      'استخدم 8 أحرف على الأقل تجمع بين الحروف والأرقام';

  @override
  String get authErrPasswordEmpty => 'أدخل كلمة المرور';

  @override
  String get authErrName => 'أدخل اسمك';

  @override
  String get authErrWrong =>
      'البريد الإلكتروني أو كلمة المرور لا يطابقان الحساب على هذا الجهاز.';

  @override
  String get authErrNoAccount =>
      'لا يوجد حساب على هذا الجهاز بعد. أنشئ حسابًا للبدء.';

  @override
  String get authErrExists =>
      'يوجد حساب على هذا الجهاز بالفعل. سجّل الدخول بدلًا من ذلك.';

  @override
  String get authErrPasswordRequired =>
      'الحساب على هذا الجهاز محمي بكلمة مرور. سجّل الدخول ببريدك الإلكتروني وكلمة المرور.';

  @override
  String get authResetTitle => 'إعادة تعيين كلمة المرور';

  @override
  String get authResetBody =>
      'يحتفظ تقدّم بحسابك على هذا الجهاز فقط، لذلك لا يوجد رابط استرداد عبر البريد الإلكتروني. إذا لم تتذكر كلمة المرور، يمكنك مسح حساب هذا الجهاز والبدء من جديد.';

  @override
  String get authResetWarning =>
      'يؤدي المسح إلى حذف كل الأهداف والسجلات والمراجعات المخزنة على هذا الجهاز نهائيًا.';

  @override
  String get authResetConfirmLabel => 'اكتب «مسح» للتأكيد';

  @override
  String get authResetKeyword => 'مسح';

  @override
  String get authResetButton => 'المسح والبدء من جديد';

  @override
  String get authResetDone => 'تم مسح حساب الجهاز. أنشئ حسابًا جديدًا للبدء.';

  @override
  String get authDeviceTitle => 'المتابعة على هذا الجهاز';

  @override
  String get authDeviceBody =>
      'استخدم تقدّم دون بريد إلكتروني أو كلمة مرور. تبقى بياناتك خاصة على هذا الهاتف، ويمكنك إضافة كلمة مرور لاحقًا من الإعدادات.';

  @override
  String get authDeviceNameLabel => 'بماذا نناديك؟';

  @override
  String get authDeviceButton => 'ابدأ';

  @override
  String get authTermsTitle => 'الشروط';

  @override
  String get authTermsP1 =>
      'تقدّم أداة شخصية للتخطيط، تساعدك على تنظيم أيامك وتسجيل تقدّمك والتأمل فيه. ولا يقدّم أي فتاوى أو استشارات طبية أو مالية.';

  @override
  String get authTermsP2 =>
      'تُخزَّن سجلاتك على هذا الجهاز فقط. أنت مسؤول عن تصدير نسخة منها إن أردت الاحتفاظ بنسخة احتياطية، لأن حذف التطبيق يزيل البيانات المحلية.';

  @override
  String get authTermsP3 =>
      'يُقدَّم التطبيق كما هو. استخدمه بما يدعم راحتك ونموّك.';

  @override
  String get authPrivacyTitle => 'سياسة الخصوصية';

  @override
  String get authPrivacyP1 =>
      'يعمل تقدّم دون اتصال بالكامل. لا تُرسَل أي بيانات حساب أو أهداف أو سجلات أو مراجعات أو معاملات مالية إلى أي خادم.';

  @override
  String get authPrivacyP2 =>
      'لا تُخزَّن كلمة مرورك أبدًا، بل تُحفَظ بصمة مشفّرة مملّحة منها فقط في التخزين الآمن للجهاز.';

  @override
  String get authPrivacyP3 =>
      'لا توجد أدوات تحليل أو تتبّع. لا تُنشأ ملفات التصدير إلا عندما تطلبها، ولا تُشارَك إلا حيث تختار.';

  @override
  String onbStep(int step, int total) {
    return 'الخطوة $step من $total';
  }

  @override
  String get onbAreasTitle => 'ما الذي تريد\nتحسينه؟';

  @override
  String get onbAreasSubtitle => 'اختر ما يهمك أكثر الآن.';

  @override
  String get onbAreaQuran => 'القرآن والإيمان';

  @override
  String get onbAreaWork => 'العمل';

  @override
  String get onbAreaFinance => 'المال';

  @override
  String get onbAreaHealth => 'الصحة';

  @override
  String get onbAreaLearning => 'التعلّم';

  @override
  String get onbAreaPersonal => 'الحياة الشخصية';

  @override
  String get onbAreaQuranHint => 'الاستمرارية';

  @override
  String get onbAreaWorkHint => 'حافظ على تركيزك';

  @override
  String get onbAreaFinanceHint => 'تتبّع وادّخر';

  @override
  String get onbAreaHealthHint => 'كن أقوى';

  @override
  String get onbAreaLearningHint => 'واصل النمو';

  @override
  String get onbAreaPersonalHint => 'حقّق التوازن';

  @override
  String get onbAreasError => 'اختر مجالًا واحدًا على الأقل للمتابعة.';

  @override
  String get onbTargetsTitle => 'ما أهدافك الرئيسية؟';

  @override
  String get onbTargetsSubtitle =>
      'اختر أهدافًا أولية لتبدأ بخطوات واضحة. ستصبح عادات يومية يمكنك تأشيرها.';

  @override
  String get onbAddCustom => 'إضافة هدف مخصص';

  @override
  String get onbCustomTitle => 'هدف مخصص';

  @override
  String get onbCustomHint => 'مثال: شرب 8 أكواب من الماء';

  @override
  String get onbCustomArea => 'المجال';

  @override
  String get onbCustomAdd => 'إضافة الهدف';

  @override
  String get onbTargetQuran1 => 'قراءة حزب يوميًا';

  @override
  String get onbTargetQuran2 => 'مراجعة الحفظ';

  @override
  String get onbTargetQuran3 => 'أذكار الصباح يوميًا';

  @override
  String get onbTargetWork1 => '4 ساعات من العمل العميق';

  @override
  String get onbTargetWork2 => 'متابعات يومية';

  @override
  String get onbTargetFinance1 => 'تسجيل المصروفات كل مساء';

  @override
  String get onbTargetFinance2 => 'تخصيص مبلغ للادخار';

  @override
  String get onbTargetHealth1 => 'المشي 8,000 خطوة';

  @override
  String get onbTargetHealth2 => 'النوم قبل 23:00';

  @override
  String get onbTargetLearning1 => 'التعلّم 30 دقيقة';

  @override
  String get onbTargetLearning2 => 'قراءة 10 صفحات';

  @override
  String get onbTargetPersonal1 => 'وقت نوعي مع العائلة';

  @override
  String get onbTargetPersonal2 => 'الاتصال بأحد الأقارب';

  @override
  String get onbPaceTitle => 'كيف تريد أن يكون إيقاع يومك؟';

  @override
  String get onbPaceSubtitle =>
      'اختر إيقاع يومك، وسيتكيّف تقدّم مع أسلوب حياتك.';

  @override
  String get paceMorning => 'تركيز صباحي';

  @override
  String get paceMorningHint => 'إنجاز الأهداف الأهم مبكرًا قبل المشتتات';

  @override
  String get paceBalanced => 'يوم متوازن';

  @override
  String get paceBalancedHint => 'التزامات موزعة بانتظام مع فترات راحة';

  @override
  String get paceAdaptive => 'مرن وقابل للتكيّف';

  @override
  String get paceAdaptiveHint => 'جدول مرن يتكيّف بسلاسة مع المتطلبات';

  @override
  String get onbCheckpoints => 'محطات يومية';

  @override
  String get onbMorningCheckpoint => 'نية الصباح';

  @override
  String get onbEveningCheckpoint => 'مراجعة المساء';

  @override
  String get onbCheckpointHint =>
      'اضغط على الوقت لتغييره. يمكنك تعديل التذكيرات لاحقًا.';

  @override
  String get onbReadyTitle => 'أنت جاهز للبدء';

  @override
  String get onbReadySubtitle => 'تم إعداد نظامك اليومي ليربط عاداتك بأهدافك.';

  @override
  String get onbFocusAreas => 'مجالات التركيز';

  @override
  String get onbFirstTargets => 'أهداف اليوم الأول';

  @override
  String get onbNoTargets =>
      'لم تختر أهدافًا أولية. يمكنك إضافة عادات في أي وقت.';

  @override
  String get onbDailyPace => 'إيقاع اليوم:';

  @override
  String get onbReadyNote => 'الخطوات الصغيرة الثابتة تصنع حياة مميزة.';

  @override
  String get onbFinish => 'إعداد هدفي الأول';

  @override
  String get goalSetupHeader => 'إعداد أهدافك';

  @override
  String get goalNewTitle => 'هدف جديد';

  @override
  String get goalEditTitle => 'تعديل الهدف';

  @override
  String goalSetupCounter(int n, int total) {
    return 'الهدف $n من $total';
  }

  @override
  String goalSetupPercent(int pct) {
    return 'اكتمل الإعداد بنسبة $pct%';
  }

  @override
  String get goalSetupHeadline => 'اجعل هدفك قابلًا للقياس';

  @override
  String get goalSetupSub => 'الأهداف الواضحة أسهل في المتابعة والتقدّم.';

  @override
  String get goalTitleLabel => 'عنوان الهدف';

  @override
  String get goalTitleHint => 'مثال: ادخار 600,000 دج';

  @override
  String get goalCategory => 'الفئة';

  @override
  String get goalType => 'نوع الهدف';

  @override
  String get goalTypeTarget => 'هدف رقمي';

  @override
  String get goalTypeRoutine => 'روتين';

  @override
  String get goalTypeMilestone => 'مرحلة';

  @override
  String get goalTypeTargetHint =>
      'الوصول إلى رقم، مثل عدد الصفحات أو الساعات أو المدخرات.';

  @override
  String get goalTypeRoutineHint =>
      'تكرار أمر ما عددًا من المرات كل يوم أو أسبوع أو شهر.';

  @override
  String get goalTypeMilestoneHint => 'إنجاز سلسلة من المراحل.';

  @override
  String get goalTargetUnit => 'الهدف والوحدة';

  @override
  String get goalUnit => 'الوحدة';

  @override
  String get goalUnitCustom => 'وحدة مخصصة';

  @override
  String get goalUnitCustomHint => 'مثال: كتب';

  @override
  String get goalStartingPoint => 'نقطة البداية';

  @override
  String get goalStartingPointHint => 'ما أنجزته حتى الآن';

  @override
  String goalAccumulated(Object pct) {
    return 'تم إنجاز $pct';
  }

  @override
  String goalRemaining(Object value) {
    return 'المتبقي $value';
  }

  @override
  String get goalRoutineTimes => 'عدد المرات في كل فترة';

  @override
  String get goalRoutineEvery => 'التكرار';

  @override
  String get goalTargetDate => 'تاريخ الهدف';

  @override
  String get goalNoDate => 'اختر تاريخًا';

  @override
  String get goalClearDate => 'إزالة التاريخ';

  @override
  String goalYearsLeft(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'تتبقى $n سنة',
      many: 'تتبقى $n سنة',
      few: 'تتبقى $n سنوات',
      two: 'تتبقى سنتان',
      one: 'تتبقى سنة واحدة',
      zero: 'أقل من سنة',
    );
    return '$_temp0';
  }

  @override
  String goalMonthsLeft(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'يتبقى $n شهر',
      many: 'يتبقى $n شهرًا',
      few: 'تتبقى $n أشهر',
      two: 'يتبقى شهران',
      one: 'يتبقى شهر واحد',
      zero: 'أقل من شهر',
    );
    return '$_temp0';
  }

  @override
  String goalDaysLeft(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'يتبقى $n يوم',
      many: 'يتبقى $n يومًا',
      few: 'تتبقى $n أيام',
      two: 'يتبقى يومان',
      one: 'يتبقى يوم واحد',
      zero: 'اليوم هو الموعد',
    );
    return '$_temp0';
  }

  @override
  String get goalPastDate => 'انقضى التاريخ';

  @override
  String get goalWhy => 'لماذا يهمك هذا الهدف؟';

  @override
  String get goalWhyHint => 'السبب الذي ستتذكره في الأيام الصعبة.';

  @override
  String get goalActionsTitle => 'إجراءات تدفع هذا الهدف إلى الأمام';

  @override
  String get goalActionsSubtitle => 'خطوات يومية أو متكررة مرتبطة بهذا الهدف.';

  @override
  String get goalAddAction => 'إضافة إجراء';

  @override
  String get goalEditAction => 'تعديل الإجراء';

  @override
  String get goalActionTitle => 'الإجراء';

  @override
  String get goalActionTitleHint => 'مثال: ادخار مبلغ شهري من الدخل';

  @override
  String get goalActionDetail => 'التفاصيل';

  @override
  String get goalActionDetailHint => 'مثال: 20,000 دج كل شهر';

  @override
  String get goalFrequency => 'التكرار';

  @override
  String get freqDaily => 'يوميًا';

  @override
  String get freqWeekly => 'أسبوعيًا';

  @override
  String get freqMonthly => 'شهريًا';

  @override
  String get freqOnce => 'مرة واحدة';

  @override
  String get goalMilestonesTitle => 'المراحل';

  @override
  String get goalMilestonesSubtitle => 'يُحسب التقدّم بنسبة المراحل المكتملة.';

  @override
  String get goalAddMilestone => 'إضافة مرحلة';

  @override
  String get goalMilestoneHint => 'عنوان المرحلة';

  @override
  String get goalTrajectoryTitle => 'الإيقاع المطلوب';

  @override
  String goalTrajectoryBody(Object amount, Object date) {
    return 'لبلوغ هدفك بحلول $date، استهدف نحو $amount شهريًا.';
  }

  @override
  String get goalTrajectoryDone => 'نقطة البداية تحقق هذا الهدف بالفعل.';

  @override
  String get goalTrajectoryNoDate =>
      'أضف تاريخًا للهدف لمعرفة الإيقاع المطلوب.';

  @override
  String goalRoutineSummary(Object count, Object period) {
    return '$count × $period';
  }

  @override
  String get goalErrTitle => 'أضف عنوانًا لهدفك';

  @override
  String get goalErrTarget => 'أدخل هدفًا أكبر من نقطة البداية';

  @override
  String get goalErrMilestones => 'أضف مرحلة واحدة على الأقل';

  @override
  String get goalSaveContinue => 'حفظ ومتابعة';

  @override
  String get goalSave => 'حفظ الهدف';

  @override
  String get goalFinishSetup => 'إنهاء الإعداد';

  @override
  String get goalSavedNext => 'تم حفظ الهدف. أضف هدفًا آخر أو أنهِ الإعداد.';

  @override
  String get goalMakePrimary => 'اجعل هذا هدفي الرئيسي';

  @override
  String get langTitle => 'اللغة';

  @override
  String get langComingSoon => 'قريبًا في تحديث قادم';

  @override
  String get langFootnote =>
      'تغيير اللغة لا يغيّر أهدافك أو سجلاتك أبدًا. الفرنسية قادمة في تحديث لاحق.';

  @override
  String todayGreetingMorning(Object name) {
    return 'صباح الخير، $name';
  }

  @override
  String todayGreetingAfternoon(Object name) {
    return 'مساء الخير، $name';
  }

  @override
  String todayGreetingEvening(Object name) {
    return 'مساء الخير، $name';
  }

  @override
  String get todayNotifications => 'الإشعارات';

  @override
  String get todayProfile => 'الملف الشخصي';

  @override
  String get todayMomentum => 'زخم اليوم';

  @override
  String todayVsYesterday(Object delta) {
    return '$delta مقارنة بالأمس';
  }

  @override
  String get todayComplete => 'مكتمل';

  @override
  String todayActionsCompleted(int done, int total) {
    return '$done من $total مهام مكتملة';
  }

  @override
  String todayActionsLeft(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'تتبقى $count مهمة',
      many: 'تتبقى $count مهمة',
      few: 'تتبقى $count مهام',
      two: 'تتبقى مهمتان',
      one: 'تتبقى مهمة واحدة',
      zero: 'أنجزت كل شيء',
    );
    return '$_temp0';
  }

  @override
  String get todayEmptyTitle => 'خطط ليومك';

  @override
  String get todayEmptyBody =>
      'أضف بعض مهام اليوم، أو ابدأ بمراجعة صباحية سريعة.';

  @override
  String get todayCheckInTitle => 'المراجعة الصباحية';

  @override
  String get todayCheckInBody => 'حدد مستوى طاقتك واختر أهم 3 أولويات لليوم.';

  @override
  String get todayCheckInCta => 'ابدأ';

  @override
  String get todayNightTitle => 'مراجعة المساء';

  @override
  String get todayNightBody => 'اختم يومك بثلاثة أسئلة هادئة.';

  @override
  String get todayNightCta => 'مراجعة';

  @override
  String get todayFocus => 'تركيز اليوم';

  @override
  String todayPriorities(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count أولوية',
      many: '$count أولوية',
      few: '$count أولويات',
      two: 'أولويتان',
      one: 'أولوية واحدة',
      zero: 'لا أولويات',
    );
    return '$_temp0';
  }

  @override
  String get todayNoPriorities =>
      'لم تختر أولويات بعد. اختر حتى ثلاثًا هي الأهم.';

  @override
  String get todayChoosePriorities => 'اختر الأولويات';

  @override
  String get todayActions => 'مهام اليوم';

  @override
  String todayCompletedOf(int done, int total) {
    return '$done من $total مكتملة';
  }

  @override
  String get todayAddAction => 'إضافة مهمة لليوم';

  @override
  String get todayViewPlan => 'عرض الخطة كاملة';

  @override
  String todayMoreActions(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '+ $count مهمة أخرى',
      many: '+ $count مهمة أخرى',
      few: '+ $count مهام أخرى',
      two: '+ مهمتان أخريان',
      one: '+ مهمة أخرى',
    );
    return '$_temp0';
  }

  @override
  String get todayYourProgress => 'تقدّمك';

  @override
  String get todayKeyAreas => 'مجالات حياتك الرئيسية';

  @override
  String get todayNoGoals => 'أنشئ هدفًا لترى تقدّمك في مجالات حياتك الرئيسية.';

  @override
  String get todayCreateGoal => 'إنشاء هدف';

  @override
  String get todayInsightTitle => 'نمط الزخم';

  @override
  String todayInsightArea(String area, int days, int total) {
    return 'استمراريتك في $area هي الأقوى هذا الأسبوع، بنشاط في $days من $total أيام.';
  }

  @override
  String todayInsightStrongDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count يوم قوي حتى الآن هذا الأسبوع. حافظ على الإيقاع.',
      many: '$count يومًا قويًا حتى الآن هذا الأسبوع. حافظ على الإيقاع.',
      few: '$count أيام قوية حتى الآن هذا الأسبوع. حافظ على الإيقاع.',
      two: 'يومان قويان حتى الآن هذا الأسبوع. حافظ على الإيقاع.',
      one: 'يوم قوي واحد حتى الآن هذا الأسبوع. حافظ على الإيقاع.',
    );
    return '$_temp0';
  }

  @override
  String get taskNew => 'مهمة جديدة';

  @override
  String get taskEdit => 'تعديل المهمة';

  @override
  String get taskTitle => 'ما الذي يجب إنجازه؟';

  @override
  String get taskTitleHint => 'مثال: تحضير عرض للعميل';

  @override
  String get taskArea => 'الفئة';

  @override
  String get taskSchedule => 'الموعد';

  @override
  String get taskPickDate => 'تاريخ…';

  @override
  String get taskTime => 'الوقت';

  @override
  String get taskAnytime => 'في أي وقت';

  @override
  String get taskDuration => 'المدة';

  @override
  String get taskNoDuration => 'بدون';

  @override
  String get taskGoal => 'الهدف المرتبط';

  @override
  String get taskNoGoal => 'بدون هدف';

  @override
  String get taskDetail => 'التفاصيل';

  @override
  String get taskDetailHint => 'مثال: سورة النور أو 5 عملاء محتملين';

  @override
  String get taskAdd => 'إضافة مهمة';

  @override
  String get taskSave => 'حفظ التغييرات';

  @override
  String get taskMarkDone => 'تحديد كمنجزة';

  @override
  String get taskMarkUndone => 'تحديد كغير منجزة';

  @override
  String get taskReschedule => 'إعادة الجدولة';

  @override
  String get taskMakePriority => 'جعلها أولوية';

  @override
  String get taskRemovePriority => 'إزالة من الأولويات';

  @override
  String get taskDelete => 'حذف المهمة';

  @override
  String get taskDeleteTitle => 'حذف هذه المهمة؟';

  @override
  String get taskDeleteBody => 'ستُزال المهمة وسجل نشاطها من هذا الجهاز.';

  @override
  String get taskDeleted => 'تم حذف المهمة';

  @override
  String get taskPriorityFull => 'لديك 3 أولويات بالفعل. أزل واحدة أولًا.';

  @override
  String get taskAdded => 'تمت إضافة المهمة';

  @override
  String get rescheduleTitle => 'إعادة الجدولة';

  @override
  String get rescheduleSubtitle => 'انقل هذه المهمة دون ضغط.';

  @override
  String get rescheduleLaterToday => 'لاحقًا اليوم';

  @override
  String get rescheduleTomorrow => 'غدًا';

  @override
  String get rescheduleNextWeek => 'الأسبوع القادم';

  @override
  String get reschedulePick => 'اختر تاريخًا';

  @override
  String get rescheduleKeepTime => 'الإبقاء على الوقت';

  @override
  String get rescheduleConfirm => 'نقل المهمة';

  @override
  String rescheduledTo(Object date) {
    return 'نُقلت إلى $date';
  }

  @override
  String get planTitleToday => 'اليوم';

  @override
  String get planCalendar => 'اختر يومًا';

  @override
  String get planMore => 'خيارات أخرى';

  @override
  String planCompleted(int done, int total) {
    return '$done من $total مكتملة';
  }

  @override
  String planPlanned(Object time) {
    return '$time مخطط لها';
  }

  @override
  String get planLoadLight => 'يبدو حمل اليوم خفيفًا.';

  @override
  String get planLoadBalanced => 'يبدو حمل اليوم متوازنًا.';

  @override
  String get planLoadHeavy => 'يبدو حمل اليوم ثقيلًا. فكّر في نقل بعض المهام.';

  @override
  String get capacityLight => 'يوم خفيف';

  @override
  String get capacityBalanced => 'يوم متوازن';

  @override
  String get capacityFocused => 'يوم مركّز';

  @override
  String get capacityLightHint => 'اجعل الأمور بسيطة';

  @override
  String get capacityBalancedHint => 'إيقاع عادي';

  @override
  String get capacityFocusedHint => 'عمل عميق أكثر';

  @override
  String get planTopPriorities => 'أهم الأولويات';

  @override
  String get planReorder => 'إعادة الترتيب';

  @override
  String get planDoneReorder => 'تم';

  @override
  String get planMorning => 'الصباح';

  @override
  String get planAfternoon => 'بعد الظهر';

  @override
  String get planEvening => 'المساء';

  @override
  String get planAnytime => 'في أي وقت';

  @override
  String planSectionCount(String label, int count) {
    return '$label · $count';
  }

  @override
  String planDoneCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count مهمة منجزة',
      many: '$count مهمة منجزة',
      few: '$count مهام منجزة',
      two: 'مهمتان منجزتان',
      one: 'مهمة منجزة',
      zero: 'لا شيء منجز',
    );
    return '$_temp0';
  }

  @override
  String get planAddAction => 'إضافة مهمة لهذا اليوم';

  @override
  String get planAllSet =>
      'كل شيء جاهز. يمكنك إعادة جدولة المهام أو نقلها في أي وقت.';

  @override
  String get planAllDone => 'أنجزت كل ما خططت له في هذا اليوم.';

  @override
  String get planEmptyTitle => 'لا شيء مخطط بعد';

  @override
  String get planEmptyBody => 'أضف مهمة أو ابدأ المراجعة الصباحية لترتيب يومك.';

  @override
  String get planMoveUnfinished => 'نقل غير المنجز إلى الغد';

  @override
  String planMovedCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'نُقلت $count مهمة إلى الغد',
      many: 'نُقلت $count مهمة إلى الغد',
      few: 'نُقلت $count مهام إلى الغد',
      two: 'نُقلت مهمتان إلى الغد',
      one: 'نُقلت مهمة واحدة إلى الغد',
    );
    return '$_temp0';
  }

  @override
  String get planClearCompleted => 'إخفاء المكتملة';

  @override
  String get planShowCompleted => 'إظهار المكتملة';

  @override
  String get planPastDay =>
      'انقضى هذا اليوم. لا يزال بإمكانك إنجاز المهام أو نقلها.';

  @override
  String get checkInHint => 'تستغرق أقل من دقيقة';

  @override
  String get checkInTitle => 'المراجعة الصباحية';

  @override
  String checkInHeadline(Object name) {
    return 'صباح الخير، $name';
  }

  @override
  String get checkInSub => 'لنحدد إيقاع اليوم.';

  @override
  String get checkInEnergy => 'كيف مستوى طاقتك؟';

  @override
  String get checkInEnergyHint => 'تقدير صادق';

  @override
  String get energyLow => 'منخفضة';

  @override
  String get energySteady => 'مستقرة';

  @override
  String get energyHigh => 'عالية';

  @override
  String get checkInPriorities => 'ما الأهم اليوم؟';

  @override
  String get checkInPrioritiesHint => 'اختر حتى 3 أولويات.';

  @override
  String checkInSelected(int count) {
    return '$count من 3';
  }

  @override
  String get checkInAddCustom => 'إضافة أولوية مخصصة';

  @override
  String get checkInCustomTitle => 'أولوية مخصصة';

  @override
  String get checkInCustomHint => 'مثال: إنهاء عرض العميل';

  @override
  String get checkInNoTasks =>
      'لا توجد مهام مخطط لها اليوم بعد. أضف أولوية مخصصة للبدء.';

  @override
  String get checkInCapacity => 'كم يمكنك أن تنجز بواقعية؟';

  @override
  String get checkInCapacityHint => 'اضبط توقعاتك لليوم.';

  @override
  String get checkInIntention => 'نية اليوم';

  @override
  String get checkInIntentionHint =>
      'ابقَ مركّزًا وتجنّب الاجتماعات غير الضرورية.';

  @override
  String get checkInStart => 'ابدأ يومي';

  @override
  String get checkInSkip => 'تخطَّ اليوم';

  @override
  String get checkInMax => 'يمكنك اختيار 3 أولويات كحد أقصى.';

  @override
  String get nightTitle => 'مراجعة المساء';

  @override
  String get nightBadge => 'دقيقتان للختام';

  @override
  String get nightHeadline => 'كيف كان يومك؟';

  @override
  String get nightSub => 'خذ وقفة قصيرة لتختم يومك بنية واضحة.';

  @override
  String get nightRating => 'كيف كان يومك؟';

  @override
  String get nightHard => '1 صعب';

  @override
  String get nightOkay => '3 مقبول';

  @override
  String get nightGreat => '5 رائع';

  @override
  String get nightSummary => 'ملخص اليوم';

  @override
  String nightPercent(int pct) {
    return 'مكتمل بنسبة $pct%';
  }

  @override
  String nightActions(int done, int total) {
    return '$done من $total مهام';
  }

  @override
  String nightRemaining(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'تتبقى $count مهمة',
      many: 'تتبقى $count مهمة',
      few: 'تتبقى $count مهام',
      two: 'تتبقى مهمتان',
      one: 'تتبقى مهمة',
      zero: 'لا شيء متبقٍ',
    );
    return '$_temp0';
  }

  @override
  String get nightNoPlan => 'لم تُخطَّط مهام اليوم. سجلاتك تُحتسب مع ذلك.';

  @override
  String get nightToneStrong => 'يوم قوي. أحسنت بالالتزام.';

  @override
  String get nightToneSteady => 'يوم جيد. زخم ثابت نحو الغد.';

  @override
  String get nightToneLight => 'يوم أخف. الغد بداية جديدة.';

  @override
  String get nightWentWell => 'ما الذي سار جيدًا؟';

  @override
  String get nightWentWellHint => 'ملاحظات اختيارية…';

  @override
  String get nightBetter => 'ما الذي يمكن تحسينه غدًا؟';

  @override
  String get nightBetterHint => 'ما التعديل الصغير الذي يساعدك غدًا؟';

  @override
  String get tagFocused => 'مركّز';

  @override
  String get tagGoodEnergy => 'طاقة جيدة';

  @override
  String get tagQuranDone => 'أتممت الورد';

  @override
  String get tagProgressWork => 'تقدّم في العمل';

  @override
  String get tagMoved => 'تحرّكت';

  @override
  String get tagFamily => 'وقت مع العائلة';

  @override
  String get tagDistracted => 'مشتت';

  @override
  String get tagOverplanned => 'خطة مزدحمة';

  @override
  String get tagLateStart => 'بداية متأخرة';

  @override
  String get tagMissedWorkout => 'فاتني التمرين';

  @override
  String get tagTired => 'متعب';

  @override
  String get tagTooManyMeetings => 'اجتماعات كثيرة';

  @override
  String get nightUnfinished => 'مهام غير منجزة';

  @override
  String get nightUnfinishedHint => 'انقلها إلى الغد أو أعد جدولتها دون ضغط.';

  @override
  String get nightMoveTomorrow => 'غدًا';

  @override
  String get nightMoving => 'قيد النقل';

  @override
  String get nightAllDone => 'أنجزت كل ما خططت له اليوم.';

  @override
  String get nightTomorrow => 'الغد بنظرة سريعة';

  @override
  String get nightTomorrowEmpty => 'لا شيء مجدول للغد بعد.';

  @override
  String nightTomorrowReady(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count مهمة جاهزة للغد',
      many: '$count مهمة جاهزة للغد',
      few: '$count مهام جاهزة للغد',
      two: 'مهمتان جاهزتان للغد',
      one: 'مهمة واحدة جاهزة للغد',
    );
    return '$_temp0';
  }

  @override
  String get nightComplete => 'إنهاء اليوم';

  @override
  String get nightSkip => 'تخطي المراجعة الآن';

  @override
  String get nightSaved => 'تم ختام اليوم. نومًا هانئًا.';

  @override
  String get nightAlreadyDone =>
      'راجعت هذا اليوم. الحفظ مرة أخرى سيحدّث المراجعة.';

  @override
  String get quickAddTitle => 'إضافة سريعة';

  @override
  String get quickAddSubtitle => 'أضف ما تريد دون مغادرة ما تعمل عليه.';

  @override
  String get quickTask => 'مهمة';

  @override
  String get quickTaskHint => 'أضف شيئًا لإنجازه';

  @override
  String get quickQuran => 'القرآن';

  @override
  String get quickQuranHint => 'سجّل تقدّم اليوم';

  @override
  String get quickMoney => 'المال';

  @override
  String get quickMoneyHint => 'دخل أو مصروف';

  @override
  String get quickWork => 'العمل';

  @override
  String get quickWorkHint => 'عميل محتمل أو اجتماع أو مكالمة';

  @override
  String get quickHabit => 'عادة';

  @override
  String get quickHabitHint => 'ابنِ الاستمرارية';

  @override
  String get quickNote => 'ملاحظة';

  @override
  String get quickNoteHint => 'دوّن بسرعة';

  @override
  String get quickSuggested => 'إجراءات مقترحة';

  @override
  String quickSuggestQuran(int pages) {
    String _temp0 = intl.Intl.pluralLogic(
      pages,
      locale: localeName,
      other: 'تسجيل $pages صفحة من القرآن',
      many: 'تسجيل $pages صفحة من القرآن',
      few: 'تسجيل $pages صفحات من القرآن',
      two: 'تسجيل صفحتين من القرآن',
      one: 'تسجيل صفحة واحدة من القرآن',
    );
    return '$_temp0';
  }

  @override
  String get quickSuggestExpense => 'إضافة مصروف';

  @override
  String get quickSuggestLeads => 'التواصل مع العملاء المحتملين';

  @override
  String get quickSuggestNightReview => 'مراجعة المساء';

  @override
  String get quickSuggestCheckIn => 'المراجعة الصباحية';

  @override
  String get noteTitle => 'ملاحظة سريعة';

  @override
  String get noteHint => 'ما الذي يدور في ذهنك؟';

  @override
  String get noteArea => 'المجال';

  @override
  String get noteSave => 'حفظ الملاحظة';

  @override
  String get noteSaved => 'تم حفظ الملاحظة';

  @override
  String get loggedToast => 'تم التسجيل';

  @override
  String get quranLogTitle => 'تسجيل القرآن';

  @override
  String get quranReading => 'القراءة';

  @override
  String get quranMemorization => 'الحفظ';

  @override
  String get quranRevision => 'المراجعة';

  @override
  String get quranSurah => 'السورة';

  @override
  String get quranPickSurah => 'اختر سورة';

  @override
  String get quranPagesRead => 'الصفحات المقروءة';

  @override
  String get quranPagesMemorized => 'الصفحات المحفوظة';

  @override
  String get quranPagesRevised => 'الصفحات المراجَعة';

  @override
  String get quranMinutes => 'الدقائق';

  @override
  String get quranPortion => 'المقطع';

  @override
  String get quranPortionHint => 'مثال: الصفحات 18–21';

  @override
  String quranApproxMinutes(int minutes) {
    String _temp0 = intl.Intl.pluralLogic(
      minutes,
      locale: localeName,
      other: 'نحو $minutes دقيقة',
      many: 'نحو $minutes دقيقة',
      few: 'نحو $minutes دقائق',
      two: 'نحو دقيقتين',
      one: 'نحو دقيقة واحدة',
    );
    return '$_temp0';
  }

  @override
  String get quranSaveReading => 'حفظ القراءة';

  @override
  String get quranSaveMemorization => 'حفظ جلسة الحفظ';

  @override
  String get quranSaveRevision => 'حفظ المراجعة';

  @override
  String get moneyTitle => 'إضافة معاملة';

  @override
  String get moneyExpense => 'مصروف';

  @override
  String get moneyIncome => 'دخل';

  @override
  String get moneySaving => 'ادخار';

  @override
  String get moneyAmount => 'المبلغ';

  @override
  String get moneyAmountError => 'أدخل مبلغًا صالحًا أكبر من صفر';

  @override
  String get moneyCategory => 'الفئة';

  @override
  String get moneyOther => 'أخرى…';

  @override
  String get moneyCustomCategory => 'فئة مخصصة';

  @override
  String get moneyCustomHint => 'مثال: تصليح السيارة';

  @override
  String get moneyTag => 'النوع';

  @override
  String get moneyPersonal => 'شخصي';

  @override
  String get moneyBusiness => 'عمل';

  @override
  String get moneyNote => 'ملاحظة';

  @override
  String get moneyDate => 'التاريخ';

  @override
  String get moneySave => 'إضافة المعاملة';

  @override
  String get catFood => 'طعام';

  @override
  String get catTransport => 'نقل';

  @override
  String get catHome => 'المنزل';

  @override
  String get catBills => 'فواتير';

  @override
  String get catFamily => 'العائلة';

  @override
  String get catHealth => 'الصحة';

  @override
  String get catEducation => 'التعليم';

  @override
  String get catBusiness => 'عمل';

  @override
  String get catShopping => 'تسوّق';

  @override
  String get catSalary => 'راتب';

  @override
  String get catClientPayment => 'دفعة من عميل';

  @override
  String get catFreelance => 'عمل حر';

  @override
  String get catGift => 'هدية';

  @override
  String get catEmergency => 'صندوق الطوارئ';

  @override
  String get catSavingsGoal => 'هدف الادخار';

  @override
  String get catInvestment => 'استثمار';

  @override
  String get workLogTitle => 'تسجيل عمل';

  @override
  String get workDeepWork => 'عمل عميق';

  @override
  String get workLead => 'عميل محتمل';

  @override
  String get workFollowUp => 'متابعة';

  @override
  String get workMeeting => 'اجتماع';

  @override
  String get workProposal => 'عرض';

  @override
  String get workClientWon => 'عميل جديد';

  @override
  String get workTitle => 'العنوان';

  @override
  String get workTitleDeepHint => 'مثال: عرض للعميل';

  @override
  String get workTitleLeadHint => 'مثال: تحديث نظام تخطيط الموارد';

  @override
  String get workTitleFollowHint => 'مثال: إرسال عرض سعر معدّل';

  @override
  String get workTitleMeetingHint => 'مثال: عرض الموقع ونظام إدارة العملاء';

  @override
  String get workTitleProposalHint => 'مثال: مزامنة إدارة المخزون';

  @override
  String get workTitleWonHint => 'مثال: عقد دعم سنوي';

  @override
  String get workCounterpart => 'العميل أو الشركة';

  @override
  String get workCounterpartHint => 'مثال: Atlas Construction';

  @override
  String get workDuration => 'المدة';

  @override
  String get workValue => 'قيمة الصفقة';

  @override
  String get workWhen => 'متى';

  @override
  String get workNow => 'الآن';

  @override
  String get workSave => 'حفظ';

  @override
  String get habitQuickTitle => 'عادات اليوم';

  @override
  String get habitNew => 'عادة جديدة';

  @override
  String get habitName => 'العادة';

  @override
  String get habitNameHint => 'مثال: المشي 8,000 خطوة';

  @override
  String get habitArea => 'المجال';

  @override
  String get habitReminder => 'التذكير';

  @override
  String get habitNoReminder => 'بدون تذكير';

  @override
  String get habitAdd => 'إضافة عادة';

  @override
  String get habitEmpty => 'لا توجد عادات بعد. أضف عادة لبناء استمرارية ثابتة.';

  @override
  String habitDoneCount(int done, int total) {
    return '$done من $total منجزة اليوم';
  }

  @override
  String commonDaysAgo(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'قبل $n يوم',
      many: 'قبل $n يومًا',
      few: 'قبل $n أيام',
      two: 'قبل يومين',
      one: 'أمس',
      zero: 'اليوم',
    );
    return '$_temp0';
  }

  @override
  String get commonHistory => 'السجل';

  @override
  String get commonShowMore => 'عرض المزيد';

  @override
  String get commonShowLess => 'عرض أقل';

  @override
  String get commonTargets => 'الأهداف اليومية';

  @override
  String get commonDeleteEntry => 'حذف السجل';

  @override
  String get commonDeleteEntryBody =>
      'سيؤدي هذا إلى حذف السجل وأي تقدّم أضافه إلى الأهداف.';

  @override
  String commonTodayAt(Object time) {
    return 'اليوم · $time';
  }

  @override
  String commonYesterdayAt(Object time) {
    return 'أمس · $time';
  }

  @override
  String commonDateAt(Object date, Object time) {
    return '$date · $time';
  }

  @override
  String goalMiniMilestones(int done, int total) {
    return '$done من $total مراحل مكتملة';
  }

  @override
  String goalMiniRoutineDay(int done, int total) {
    return '$done من $total اليوم';
  }

  @override
  String goalMiniRoutineWeek(int done, int total) {
    return '$done من $total هذا الأسبوع';
  }

  @override
  String goalMiniRoutineMonth(int done, int total) {
    return '$done من $total هذا الشهر';
  }

  @override
  String goalTargetOn(Object date) {
    return 'الموعد: $date';
  }

  @override
  String get goalAddForArea => 'إضافة هدف';

  @override
  String get goalAddForAreaBody =>
      'اربط هدفًا بهذا المجال، وستدفعه سجلاتك إلى الأمام تلقائيًا.';

  @override
  String get quranTitle => 'القرآن';

  @override
  String get quranSubtitle => 'القراءة والحفظ والمراجعة.';

  @override
  String get quranDailyRoutine => 'الورد اليومي';

  @override
  String quranRoutineDone(int done, int total) {
    return '$done من $total مكتملة';
  }

  @override
  String quranPagesOf(Object done, Object target) {
    return '$done / $target صفحة';
  }

  @override
  String quranPageOf(Object done, Object target) {
    return '$done / $target صفحة';
  }

  @override
  String quranMinutesOf(Object done, Object target) {
    return '$done / $target د';
  }

  @override
  String get quranLogProgress => 'تسجيل التقدّم';

  @override
  String get quranCurrentMemo => 'الحفظ الحالي';

  @override
  String quranSurahBadge(int n) {
    return 'السورة $n';
  }

  @override
  String quranPagesOfSurah(String done, int total) {
    String _temp0 = intl.Intl.pluralLogic(
      total,
      locale: localeName,
      other: '$total صفحة',
      many: '$total صفحة',
      few: '$total صفحات',
      two: 'صفحتين',
      one: 'صفحة واحدة',
    );
    return '$done من $_temp0';
  }

  @override
  String quranNextStep(Object amount) {
    return 'التالي · $amount صفحة';
  }

  @override
  String get quranContinue => 'متابعة';

  @override
  String get quranNoMemoTitle => 'لا يوجد حفظ بعد';

  @override
  String get quranNoMemoBody => 'سجّل جلسة حفظ لتتابع سورتك الحالية هنا.';

  @override
  String get quranStartMemo => 'تسجيل الحفظ';

  @override
  String get quranGoal => 'هدف القرآن';

  @override
  String get quranRevisionTitle => 'المراجعة';

  @override
  String get quranActiveSchedule => 'الجدول الحالي';

  @override
  String quranLastReviewed(Object when) {
    return 'آخر مراجعة $when';
  }

  @override
  String get quranReviewToday => 'راجِع اليوم';

  @override
  String get quranStrong => 'متين';

  @override
  String get quranNoRevision =>
      'ستظهر هنا المقاطع التي تحفظها أو تراجعها مع جدول مراجعة ميسّر.';

  @override
  String get quranConsistency => 'الاستمرارية';

  @override
  String quranConsistencyCount(int active, int days) {
    return '$active من آخر $days يومًا';
  }

  @override
  String get quranConsistencyHint => 'التقدّم الثابت أهم من السلاسل الصارمة.';

  @override
  String get quranNoteStart => 'سجّل صفحة واحدة لتبدأ إيقاعك.';

  @override
  String get quranNoteReturned => 'استمراريتك تتشكّل. عدت بعد انقطاع يوم واحد.';

  @override
  String quranNoteStreak(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n يوم على التوالي. استمر بهدوء وثبات.',
      many: '$n يومًا على التوالي. استمر بهدوء وثبات.',
      few: '$n أيام على التوالي. استمر بهدوء وثبات.',
      two: 'يومان على التوالي. استمر بهدوء وثبات.',
      one: 'يوم واحد على التوالي. استمر بهدوء وثبات.',
    );
    return '$_temp0';
  }

  @override
  String get quranNoteSteady => 'كل عودة لها قيمة. ابدأ اليوم بصفحة واحدة.';

  @override
  String get quranThisWeek => 'هذا الأسبوع';

  @override
  String get quranRead => 'قراءة';

  @override
  String get quranMemorized => 'حفظ';

  @override
  String get quranRevised => 'مراجعة';

  @override
  String get quranUnitPages => 'صفحات';

  @override
  String get quranUnitMinutes => 'دقائق';

  @override
  String get quranRecent => 'النشاط الأخير';

  @override
  String quranReadN(num count, String pages) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'قراءة $pages صفحة',
      many: 'قراءة $pages صفحة',
      few: 'قراءة $pages صفحات',
      two: 'قراءة صفحتين',
      one: 'قراءة صفحة واحدة',
      zero: 'قراءة $pages صفحة',
    );
    return '$_temp0';
  }

  @override
  String quranMemorizedN(num count, String pages) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'حفظ $pages صفحة',
      many: 'حفظ $pages صفحة',
      few: 'حفظ $pages صفحات',
      two: 'حفظ صفحتين',
      one: 'حفظ صفحة واحدة',
      zero: 'حفظ $pages صفحة',
    );
    return '$_temp0';
  }

  @override
  String quranRevisedN(int minutes) {
    String _temp0 = intl.Intl.pluralLogic(
      minutes,
      locale: localeName,
      other: 'مراجعة $minutes دقيقة',
      many: 'مراجعة $minutes دقيقة',
      few: 'مراجعة $minutes دقائق',
      two: 'مراجعة دقيقتين',
      one: 'مراجعة دقيقة واحدة',
    );
    return '$_temp0';
  }

  @override
  String get quranEmptyTitle => 'ابدأ بصفحة واحدة';

  @override
  String get quranEmptyBody =>
      'سجّل أول قراءة أو حفظ أو مراجعة لترى إيقاعك هنا.';

  @override
  String get quranTargetReading => 'القراءة (صفحات يوميًا)';

  @override
  String get quranTargetMemo => 'الحفظ (صفحات يوميًا)';

  @override
  String get quranTargetRevision => 'المراجعة (دقائق يوميًا)';

  @override
  String get workScreenTitle => 'العمل';

  @override
  String get workScreenSubtitle => 'التركيز والمبيعات وتقدّم العمل.';

  @override
  String get workTargetAchieved => 'تحقق الهدف';

  @override
  String get workTargetBanner => 'أكملت هدف العمل العميق لهذا اليوم.';

  @override
  String get workMomentum => 'زخم اليوم';

  @override
  String get workDeepFocus => 'تركيز العمل العميق';

  @override
  String get workLeads => 'عملاء محتملون';

  @override
  String get workFollowUps => 'متابعات';

  @override
  String get workMeetings => 'اجتماعات';

  @override
  String get workProposals => 'عروض';

  @override
  String workPlanned(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n مخطط',
      many: '$n مخططًا',
      few: '$n مخططة',
      two: 'اثنان مخططان',
      one: 'واحد مخطط',
      zero: 'لا شيء مخطط',
    );
    return '$_temp0';
  }

  @override
  String get workQuickActions => 'إجراءات سريعة';

  @override
  String get workLogDeep => 'تسجيل عمل عميق';

  @override
  String get workAddLead => 'إضافة عميل محتمل';

  @override
  String get workAddFollowUp => 'إضافة متابعة';

  @override
  String get workAddMeeting => 'إضافة اجتماع';

  @override
  String get workFocus => 'التركيز';

  @override
  String workLogged(Object time) {
    return '$time مسجّلة';
  }

  @override
  String get workAllLogs => 'كل السجلات';

  @override
  String get workNoFocus =>
      'لم يُسجَّل عمل عميق اليوم. فترة تركيز واحدة تصنع الفرق.';

  @override
  String get workSales => 'نشاط المبيعات';

  @override
  String get workOutreach => 'التواصل';

  @override
  String get workCadence => 'الإيقاع';

  @override
  String get workBooked => 'محجوز';

  @override
  String get workSent => 'مُرسل';

  @override
  String workWon(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n عميل جديد',
      many: '$n عميلًا جديدًا',
      few: '$n عملاء جدد',
      two: 'عميلان جديدان',
      one: 'عميل جديد واحد',
      zero: 'لا عملاء جدد',
    );
    return '$_temp0';
  }

  @override
  String workWonWeek(Object won) {
    return '$won هذا الأسبوع';
  }

  @override
  String workWonMonth(Object won) {
    return '$won هذا الشهر';
  }

  @override
  String get workActiveLeads => 'العملاء المحتملون النشطون';

  @override
  String get workStageLead => 'تم التواصل';

  @override
  String get workStageFollowUp => 'قيد المتابعة';

  @override
  String get workStageMeeting => 'اجتماع';

  @override
  String get workStageProposal => 'أُرسل العرض';

  @override
  String workNext(Object what) {
    return 'التالي: $what';
  }

  @override
  String get workNextNone => 'التالي: خطّط لمتابعة';

  @override
  String get workNoLeads =>
      'العملاء المحتملون الذين تسجّلهم باسم عميل أو شركة يبنون قائمتك هنا.';

  @override
  String get workNextMeetings => 'الاجتماعات القادمة';

  @override
  String workUpcoming(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n اجتماع قادم',
      many: '$n اجتماعًا قادمًا',
      few: '$n اجتماعات قادمة',
      two: 'اجتماعان قادمان',
      one: 'اجتماع قادم',
      zero: 'لا اجتماعات قادمة',
    );
    return '$_temp0';
  }

  @override
  String get workNoMeetings =>
      'لا توجد اجتماعات مجدولة. أضف اجتماعًا عندما تكون المحادثة جاهزة.';

  @override
  String get workBusinessGoals => 'أهداف العمل';

  @override
  String get workInsightTitle => 'نمط المبيعات الأسبوعي';

  @override
  String get workInsightFollowUps =>
      'المتابعات تتحول إلى اجتماعات هذا الأسبوع. واصل رعاية المحادثات القائمة.';

  @override
  String get workInsightLeads =>
      'فتحت محادثات جديدة هذا الأسبوع. متابعة قصيرة تبقيها نشطة.';

  @override
  String get workInsightDeep =>
      'العمل العميق يقود أسبوعك. خصّص فترة واحدة للتواصل لتبقى القائمة متحركة.';

  @override
  String get workMarkWon => 'تحديد كعميل جديد';

  @override
  String get workTargetDeep => 'العمل العميق (دقائق يوميًا)';

  @override
  String get workTargetLeads => 'العملاء المحتملون يوميًا';

  @override
  String get workTargetFollowUps => 'المتابعات يوميًا';

  @override
  String get financeTitle => 'المال';

  @override
  String get financeSubtitle => 'وعي مالي شخصي وتقدّم ملموس.';

  @override
  String financeExpensesLower(Object pct) {
    return 'مصروفاتك أقل بنسبة $pct مقارنة بالفترة نفسها من الشهر الماضي.';
  }

  @override
  String financeExpensesHigher(Object pct) {
    return 'مصروفاتك أعلى بنسبة $pct مقارنة بالفترة نفسها من الشهر الماضي.';
  }

  @override
  String get financeNet => 'صافي المدخرات والفائض';

  @override
  String get financeNetCaption =>
      'الدخل بعد المصروفات والمبالغ المخصصة للادخار';

  @override
  String get financeLastMonth => 'الشهر الماضي';

  @override
  String get financeThisYear => 'السنة';

  @override
  String get financeIncome => 'الدخل';

  @override
  String get financeExpenses => 'المصروفات';

  @override
  String get financeSavings => 'المدخرات';

  @override
  String financeSavingsRate(Object pct) {
    return 'نسبة ادخار $pct';
  }

  @override
  String get financeQuickActions => 'إجراءات سريعة';

  @override
  String get financeCashFlow => 'التدفق النقدي';

  @override
  String get financeInflow => 'الوارد';

  @override
  String get financeOutflow => 'الصادر';

  @override
  String get financeSpending => 'الإنفاق';

  @override
  String financeTotal(Object amount) {
    return 'الإجمالي $amount';
  }

  @override
  String financeTxCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n معاملة',
      many: '$n معاملة',
      few: '$n معاملات',
      two: 'معاملتان',
      one: 'معاملة واحدة',
      zero: 'لا معاملات',
    );
    return '$_temp0';
  }

  @override
  String get financeNoSpending => 'لا مصروفات في هذه الفترة.';

  @override
  String get financeSavingsGoal => 'هدف الادخار';

  @override
  String financeRemaining(Object amount) {
    return '$amount متبقية لبلوغ الهدف';
  }

  @override
  String get financeAddSaving => 'إضافة ادخار';

  @override
  String get financeRecent => 'أحدث المعاملات';

  @override
  String get financeAll => 'الكل';

  @override
  String get financeViewAll => 'عرض كل المعاملات';

  @override
  String get financeEmptyTitle => 'ابدأ بتتبع أموالك';

  @override
  String get financeEmptyBody =>
      'أضف دخلًا أو مصروفًا أو ادخارًا لترى رصيدك وإنفاقك وتدفقك النقدي.';

  @override
  String get financeNoMatches => 'لا توجد معاملات من هذا النوع في هذه الفترة.';

  @override
  String get healthTitle => 'الصحة والعادات';

  @override
  String get healthSubtitle => 'الحركة والنوم والاستمرارية اليومية.';

  @override
  String healthSleepInsight(String time, int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'بلغ متوسط نومك $time في آخر $n ليلة.',
      many: 'بلغ متوسط نومك $time في آخر $n ليلة.',
      few: 'بلغ متوسط نومك $time في آخر $n ليالٍ.',
      two: 'بلغ متوسط نومك $time في الليلتين الماضيتين.',
      one: 'بلغ متوسط نومك $time في الليلة الماضية.',
    );
    return '$_temp0';
  }

  @override
  String get healthMovementToday => 'حركة اليوم';

  @override
  String healthPctCompleted(Object pct) {
    return 'مكتمل بنسبة $pct';
  }

  @override
  String healthMinRemaining(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'تتبقى $n دقيقة',
      many: 'تتبقى $n دقيقة',
      few: 'تتبقى $n دقائق',
      two: 'تتبقى دقيقتان',
      one: 'تتبقى دقيقة واحدة',
    );
    return '$_temp0';
  }

  @override
  String get healthTargetMet => 'تحقق الهدف';

  @override
  String get healthWorkout => 'التمرين';

  @override
  String get healthDone => 'منجز';

  @override
  String get healthNotYet => 'ليس بعد';

  @override
  String get healthSleep => 'النوم';

  @override
  String get healthHabits => 'العادات';

  @override
  String healthHabitsOf(int done, int total) {
    return '$done من $total';
  }

  @override
  String get healthLogWorkout => 'تسجيل تمرين';

  @override
  String get healthLogWalk => 'تسجيل مشي';

  @override
  String get healthLogSleep => 'تسجيل نوم';

  @override
  String get healthScheduledLogged => 'المسجّل هذا الأسبوع';

  @override
  String get healthCompleted => 'مكتمل';

  @override
  String get healthNoWorkout =>
      'لم يُسجَّل تمرين هذا الأسبوع. حتى 20 دقيقة لها قيمتها.';

  @override
  String get healthWalking => 'المشي';

  @override
  String healthTargetMin(int n) {
    return 'الهدف $n د';
  }

  @override
  String healthWalksToday(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'مشي $n مرة اليوم',
      many: 'مشي $n مرة اليوم',
      few: 'مشي $n مرات اليوم',
      two: 'مشي مرتين اليوم',
      one: 'مشي مرة واحدة اليوم',
      zero: 'لا مشي بعد اليوم',
    );
    return '$_temp0';
  }

  @override
  String healthWalkRemaining(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'تتبقى $n دقيقة لبلوغ هدف الحركة اليومي.',
      many: 'تتبقى $n دقيقة لبلوغ هدف الحركة اليومي.',
      few: 'تتبقى $n دقائق لبلوغ هدف الحركة اليومي.',
      two: 'تتبقى دقيقتان لبلوغ هدف الحركة اليومي.',
      one: 'تتبقى دقيقة واحدة لبلوغ هدف الحركة اليومي.',
    );
    return '$_temp0';
  }

  @override
  String get healthWalkDone => 'بلغت هدف الحركة اليومي. أحسنت.';

  @override
  String get healthSleepRhythm => 'إيقاع النوم الصحي';

  @override
  String healthSleepTarget(Object time) {
    return '/ هدف $time';
  }

  @override
  String healthBelowTarget(Object time) {
    return '$time أقل من الهدف';
  }

  @override
  String get healthOnTarget => 'ضمن الهدف';

  @override
  String healthBedWake(Object bed, Object wake) {
    return 'النوم $bed · الاستيقاظ $wake';
  }

  @override
  String healthEnergyToday(Object energy) {
    return 'طاقة اليوم: $energy';
  }

  @override
  String get healthNoSleep => 'سجّل نوم الليلة الماضية لتتابع إيقاعك.';

  @override
  String get healthDailyHabits => 'العادات اليومية';

  @override
  String healthHabitsCompleted(int done, int total) {
    return '$done من $total مكتملة';
  }

  @override
  String get healthEditHabits => 'تعديل';

  @override
  String get healthDoneEditing => 'تم';

  @override
  String get healthArchiveHabit => 'إزالة العادة';

  @override
  String get healthArchiveBody =>
      'ستُخفى العادة من قائمتك. يبقى سجلها السابق في السجل.';

  @override
  String get healthRenameHabit => 'إعادة تسمية العادة';

  @override
  String get healthGoals => 'أهداف الصحة';

  @override
  String get healthWeeklyProgress => 'التقدّم الأسبوعي';

  @override
  String healthActiveDays(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n يوم نشط من 7 هذا الأسبوع',
      many: '$n يومًا نشطًا من 7 هذا الأسبوع',
      few: '$n أيام نشطة من 7 هذا الأسبوع',
      two: 'يومان نشطان من 7 هذا الأسبوع',
      one: 'يوم نشط واحد من 7 هذا الأسبوع',
      zero: 'لا أيام نشطة هذا الأسبوع',
    );
    return '$_temp0';
  }

  @override
  String get healthWeekNote =>
      'الحركة والنوم والعادات كلها تُحتسب. العودة بعد يوم فائت تقدّم.';

  @override
  String get workoutTitle => 'تسجيل تمرين';

  @override
  String get workoutName => 'التمرين';

  @override
  String get workoutNameHint => 'مثال: تمارين القوة';

  @override
  String get workoutDetail => 'التفاصيل';

  @override
  String get workoutDetailHint => 'مثال: الجزء العلوي والبطن';

  @override
  String get workoutDuration => 'المدة';

  @override
  String get walkTitle => 'تسجيل مشي';

  @override
  String get walkMinutes => 'دقائق المشي';

  @override
  String get walkSteps => 'الخطوات';

  @override
  String get sleepTitle => 'تسجيل النوم';

  @override
  String get sleepBed => 'وقت النوم';

  @override
  String get sleepWake => 'وقت الاستيقاظ';

  @override
  String sleepDuration(Object time) {
    return '$time من النوم';
  }

  @override
  String get sleepEnergy => 'كيف مستوى طاقتك؟';

  @override
  String get healthTargetWalk => 'الحركة (دقائق يوميًا)';

  @override
  String get healthTargetSleep => 'النوم (ساعات كل ليلة)';

  @override
  String get healthTargetWorkouts => 'التمارين أسبوعيًا';

  @override
  String get learnTitle => 'التعلّم';

  @override
  String get learnSubtitle => 'المهارات والدراسة والتقدّم الحقيقي.';

  @override
  String get learnTargetBanner => 'أكملت هدف الدراسة اليومي لهذا اليوم.';

  @override
  String get learnStudyToday => 'دراسة اليوم';

  @override
  String get learnSkill => 'المهارة';

  @override
  String get learnSession => 'الجلسة';

  @override
  String learnSessionDone(Object time) {
    return 'منجزة ($time)';
  }

  @override
  String get learnApplied => 'مطبّقة';

  @override
  String learnActions(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n إجراء',
      many: '$n إجراءً',
      few: '$n إجراءات',
      two: 'إجراءان',
      one: 'إجراء واحد',
      zero: 'لا إجراءات',
    );
    return '$_temp0';
  }

  @override
  String get learnLogStudy => 'تسجيل دراسة';

  @override
  String get learnAddTakeaway => 'إضافة فائدة';

  @override
  String get learnNewAction => 'إجراء جديد';

  @override
  String get learnCurrentFocus => 'التركيز الحالي';

  @override
  String get learnActiveSubject => 'الموضوع النشط';

  @override
  String learnWeekOf(int n, int total) {
    return 'الأسبوع $n من $total';
  }

  @override
  String learnCadence(Object pct) {
    return 'انتظام $pct';
  }

  @override
  String learnNext(Object step) {
    return 'التالي · $step';
  }

  @override
  String get learnContinue => 'متابعة الدراسة';

  @override
  String get learnNoFocusTitle => 'اختر مهارة للتركيز عليها';

  @override
  String get learnNoFocusBody =>
      'تركيز واحد لبضعة أسابيع يحوّل الدراسة إلى تقدّم حقيقي.';

  @override
  String get learnSetFocus => 'تحديد التركيز';

  @override
  String get learnEditFocus => 'تعديل التركيز';

  @override
  String get learnApplyTitle => 'طبّق ما تتعلّمه';

  @override
  String learnApplyCount(int done, int total) {
    return '$done من $total مكتملة';
  }

  @override
  String get learnApplyHint =>
      'التقدّم الحقيقي يحدث عندما تتحول المعرفة إلى عمل.';

  @override
  String get learnApplyEmpty =>
      'حوّل فكرة واحدة من دراستك إلى إجراء تجربه هذا الأسبوع.';

  @override
  String get learnCompletedToday => 'مكتملة اليوم';

  @override
  String get learnUpcoming => 'القادمة';

  @override
  String get learnSessions => 'جلسات الدراسة';

  @override
  String get learnRecent => 'النشاط الأخير';

  @override
  String get learnNoSessions => 'سجّل جلسة دراسة لتبني إيقاع تعلّمك.';

  @override
  String get learnGoals => 'أهداف التعلّم';

  @override
  String get learnResources => 'مصادر قيد التقدّم';

  @override
  String learnActiveCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n نشط',
      many: '$n نشطًا',
      few: '$n نشطة',
      two: 'اثنان نشطان',
      one: 'واحد نشط',
      zero: 'لا شيء نشط',
    );
    return '$_temp0';
  }

  @override
  String get learnAddResource => 'إضافة مصدر';

  @override
  String get learnNoResources => 'تابع دورة أو كتابًا لترى تقدّمك فيه.';

  @override
  String learnUnitsOf(Object done, Object total, Object unit) {
    return '$done / $total $unit';
  }

  @override
  String get learnUpdateProgress => 'تحديث التقدّم';

  @override
  String get learnArchiveResource => 'إزالة المصدر';

  @override
  String get learnArchiveBody =>
      'سيُخفى المصدر من قائمتك. تبقى جلسات الدراسة السابقة في السجل.';

  @override
  String get learnThisWeek => 'التعلّم هذا الأسبوع';

  @override
  String get learnStudyTime => 'وقت الدراسة';

  @override
  String get learnSessionsCount => 'الجلسات';

  @override
  String get learnAppliedCount => 'المطبّق';

  @override
  String learnDaysStudied(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'درست $n يوم من 7 هذا الأسبوع.',
      many: 'درست $n يومًا من 7 هذا الأسبوع.',
      few: 'درست $n أيام من 7 هذا الأسبوع.',
      two: 'درست يومين من 7 هذا الأسبوع.',
      one: 'درست يومًا واحدًا من 7 هذا الأسبوع.',
      zero: 'لم تدرس أي يوم من 7 هذا الأسبوع.',
    );
    return '$_temp0';
  }

  @override
  String get learnDaysNote => 'تطبيق ثابت وتدريجي للمعرفة.';

  @override
  String get kindCourse => 'دورة';

  @override
  String get kindBook => 'كتاب';

  @override
  String get kindVideo => 'فيديو';

  @override
  String get kindArticle => 'مقال';

  @override
  String get unitLessons => 'دروس';

  @override
  String get unitPages => 'صفحات';

  @override
  String get unitVideos => 'فيديوهات';

  @override
  String get unitArticles => 'مقالات';

  @override
  String get studyTitle => 'تسجيل دراسة';

  @override
  String get studyTopic => 'ماذا درست؟';

  @override
  String get studyTopicHint => 'مثال: أطر أسئلة الاستكشاف';

  @override
  String get studySkill => 'المهارة';

  @override
  String get studySkillHint => 'مثال: المبيعات والتفاوض';

  @override
  String get studyMinutes => 'المدة';

  @override
  String get studyResource => 'المصدر';

  @override
  String get studyNoResource => 'بدون مصدر';

  @override
  String get studyUnits => 'التقدّم في المصدر';

  @override
  String get studyTakeaway => 'الفائدة الأساسية';

  @override
  String get studyTakeawayHint => 'فكرة تستحق التذكّر';

  @override
  String get studyAction => 'إجراء للتطبيق';

  @override
  String get studyActionHint => 'سيُضاف إلى خطة الغد';

  @override
  String get takeawayTitle => 'إضافة فائدة';

  @override
  String get takeawayHint => 'ما الفكرة التي تريد الاحتفاظ بها؟';

  @override
  String get focusTitle => 'تركيز التعلّم';

  @override
  String get focusSkill => 'المهارة';

  @override
  String get focusDescription => 'كيف يبدو التقدّم؟';

  @override
  String get focusDescriptionHint =>
      'مثال: تحسين استكشاف احتياجات العملاء وإتمام العروض';

  @override
  String get focusWeeks => 'المدة (بالأسابيع)';

  @override
  String get focusNextStep => 'الخطوة التالية';

  @override
  String get focusNextStepHint =>
      'مثال: التدرّب على أسئلة الاستكشاف في المكالمة القادمة';

  @override
  String get resourceTitle => 'إضافة مصدر';

  @override
  String get resourceName => 'العنوان';

  @override
  String get resourceNameHint => 'مثال: Never Split the Difference';

  @override
  String get resourceKind => 'النوع';

  @override
  String resourceTotal(Object unit) {
    return 'إجمالي $unit';
  }

  @override
  String get resourceDone => 'المكتمل حتى الآن';

  @override
  String get learnTargetStudy => 'الدراسة (دقائق يوميًا)';

  @override
  String get goalsTitle => 'الأهداف';

  @override
  String get goalsSubtitle => 'ما تبنيه مع الوقت.';

  @override
  String get goalsNew => 'هدف جديد';

  @override
  String goalsActiveCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n هدف نشط',
      many: '$n هدفًا نشطًا',
      few: '$n أهداف نشطة',
      two: 'هدفان نشطان',
      one: 'هدف نشط واحد',
      zero: 'لا أهداف نشطة',
    );
    return '$_temp0';
  }

  @override
  String goalsOnTrackCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n على المسار',
      two: 'اثنان على المسار',
      one: 'واحد على المسار',
      zero: 'لا شيء على المسار',
    );
    return '$_temp0';
  }

  @override
  String goalsAttentionCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n تحتاج انتباهًا',
      two: 'اثنان يحتاجان انتباهًا',
      one: 'واحد يحتاج انتباهًا',
      zero: 'لا شيء يحتاج انتباهًا',
    );
    return '$_temp0';
  }

  @override
  String get goalsFilterAll => 'الكل';

  @override
  String goalsFilterActive(int n) {
    return 'النشطة ($n)';
  }

  @override
  String goalsFilterCompleted(int n) {
    return 'المكتملة ($n)';
  }

  @override
  String get goalsPrimaryFocus => 'التركيز الرئيسي';

  @override
  String get goalsKeystone => 'محوري';

  @override
  String goalsTargetOn(Object date) {
    return 'الموعد · $date';
  }

  @override
  String get goalsNextActionToday => 'الإجراء التالي · اليوم';

  @override
  String get goalsLogProgress => 'تسجيل التقدّم';

  @override
  String get goalsMonthRecap => 'هذا الشهر';

  @override
  String goalsMovedForward(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'تقدّم $n هدف',
      many: 'تقدّم $n هدفًا',
      few: 'تقدّمت $n أهداف',
      two: 'تقدّم هدفان',
      one: 'تقدّم هدف واحد',
      zero: 'لم يتقدّم أي هدف',
    );
    return '$_temp0';
  }

  @override
  String goalsRecapBody(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'سُجّل $n تحديث للتقدّم.',
      many: 'سُجّل $n تحديثًا للتقدّم.',
      few: 'سُجّلت $n تحديثات للتقدّم.',
      two: 'سُجّل تحديثان للتقدّم.',
      one: 'سُجّل تحديث واحد للتقدّم.',
      zero: 'لم يُسجَّل أي تحديث للتقدّم.',
    );
    return '$_temp0';
  }

  @override
  String goalsRecapStrongest(Object areas) {
    return 'حافظ مجال $areas على أقوى إيقاع.';
  }

  @override
  String get goalsAll => 'كل الأهداف';

  @override
  String goalsAreas(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n مجال نشط',
      many: '$n مجالًا نشطًا',
      few: '$n مجالات نشطة',
      two: 'مجالان نشطان',
      one: 'مجال حياة نشط واحد',
      zero: 'لا مجالات نشطة',
    );
    return '$_temp0';
  }

  @override
  String goalsPctCompleted(int pct) {
    return 'مكتمل بنسبة $pct%';
  }

  @override
  String goalsNextShort(Object action) {
    return 'التالي: $action';
  }

  @override
  String goalsRemaining(Object value) {
    return 'متبقٍ $value';
  }

  @override
  String get goalsMetPeriod => 'تحقق في هذه الفترة';

  @override
  String get goalsWeeklyRhythm => 'الإيقاع الأسبوعي';

  @override
  String get goalsDailyRhythm => 'الإيقاع اليومي';

  @override
  String get goalsMonthlyRhythm => 'الإيقاع الشهري';

  @override
  String get goalsCompletedGoals => 'الأهداف المكتملة';

  @override
  String goalsCompletedOn(Object date) {
    return 'اكتمل في $date';
  }

  @override
  String get goalsPaused => 'متوقف مؤقتًا';

  @override
  String get goalsEmptyTitle => 'حدّد هدفك الأول';

  @override
  String get goalsEmptyBody => 'تربط الأهداف مهامك اليومية بما تبنيه مع الوقت.';

  @override
  String get goalsNoCompleted => 'ستُحفظ الأهداف المكتملة هنا سجلًا لما بنيته.';

  @override
  String get goalsNoneInFilter => 'لا توجد أهداف تطابق هذا التصفية.';

  @override
  String get goalDetailTitle => 'تفاصيل الهدف';

  @override
  String get goalPrimaryFocus => 'التركيز الرئيسي';

  @override
  String get goalTrajectory => 'المسار';

  @override
  String goalOfTarget(Object target) {
    return 'من $target';
  }

  @override
  String get goalNextAction => 'الإجراء التالي';

  @override
  String get goalAllActionsDone => 'أنجزت كل الإجراءات لهذه الفترة.';

  @override
  String get goalActions => 'الإجراءات';

  @override
  String goalActiveCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n نشط',
      many: '$n نشطًا',
      few: '$n نشطة',
      two: 'اثنان نشطان',
      one: 'واحد نشط',
      zero: 'لا شيء نشط',
    );
    return '$_temp0';
  }

  @override
  String get goalDoneForPeriod => 'مكتمل لهذه الفترة';

  @override
  String get goalNoActions =>
      'أضف إجراءً صغيرًا متكررًا يدفع هذا الهدف إلى الأمام.';

  @override
  String goalMilestonesDone(int done, int total) {
    return '$done من $total مكتملة';
  }

  @override
  String goalMilestoneCompleted(Object date) {
    return 'مكتملة · $date';
  }

  @override
  String get goalMilestoneCurrent => 'الحالية';

  @override
  String get goalMilestoneUpcoming => 'القادمة';

  @override
  String get goalHistory => 'سجل التقدّم';

  @override
  String get goalTrend => 'اتجاه التقدّم';

  @override
  String goalTrendChange(Object pct) {
    return '$pct منذ البداية';
  }

  @override
  String get goalNoHistory =>
      'سيظهر هنا التقدّم الذي تسجّله والسجلات المرتبطة من المجالات الأخرى.';

  @override
  String goalProgressAdded(Object value) {
    return '+$value';
  }

  @override
  String get goalWhyTitle => 'لماذا يهم هذا الهدف';

  @override
  String get goalMenuEdit => 'تعديل الهدف';

  @override
  String get goalMenuPause => 'إيقاف الهدف مؤقتًا';

  @override
  String get goalMenuResume => 'استئناف الهدف';

  @override
  String get goalMenuComplete => 'تحديد كمكتمل';

  @override
  String get goalMenuReopen => 'إعادة فتح الهدف';

  @override
  String get goalMenuPrimary => 'جعله التركيز الرئيسي';

  @override
  String get goalMenuArchive => 'أرشفة الهدف';

  @override
  String get goalMenuDelete => 'حذف الهدف';

  @override
  String get goalDeleteTitle => 'حذف هذا الهدف؟';

  @override
  String get goalDeleteBody =>
      'سيُحذف الهدف وإجراءاته ومراحله وسجل تقدّمه. تبقى السجلات في المجالات الأخرى.';

  @override
  String get goalArchiveTitle => 'أرشفة هذا الهدف؟';

  @override
  String get goalArchiveBody => 'سيُخفى من أهدافك. يبقى سجله في نشاطك.';

  @override
  String get goalNotFound => 'هذا الهدف لم يعد موجودًا.';

  @override
  String get goalLogTitle => 'تسجيل التقدّم';

  @override
  String get goalLogAmount => 'المقدار المضاف';

  @override
  String get goalLogTimes => 'عدد مرات الإنجاز';

  @override
  String get goalLogNote => 'ملاحظة';

  @override
  String get goalLogSave => 'حفظ التقدّم';

  @override
  String get goalLogged => 'تم حفظ التقدّم';

  @override
  String get goalCompletedBanner => 'اكتمل الهدف. أحسنت.';

  @override
  String get goalPausedBanner =>
      'هذا الهدف متوقف مؤقتًا. استأنفه لمتابعة التقدّم مجددًا.';

  @override
  String get healthOnTrack => 'على المسار';

  @override
  String get healthAttention => 'يحتاج انتباهًا';

  @override
  String get healthCompletedLabel => 'مكتمل';

  @override
  String get healthPausedLabel => 'متوقف مؤقتًا';

  @override
  String get progressTitle => 'التقدّم';

  @override
  String get progressSubtitle => 'الاستمرارية والأنماط والاتجاه بعيد المدى.';

  @override
  String get progressCalendar => 'تقويم التقدّم';

  @override
  String get progressThisWeek => 'هذا الأسبوع';

  @override
  String get progressThisMonth => 'هذا الشهر';

  @override
  String get progressThisYear => 'هذه السنة';

  @override
  String progressVsLastWeek(Object delta) {
    return '$delta مقارنة بالأسبوع الماضي';
  }

  @override
  String progressVsLastMonth(Object delta) {
    return '$delta مقارنة بالشهر الماضي';
  }

  @override
  String progressVsLastYear(Object delta) {
    return '$delta مقارنة بالسنة الماضية';
  }

  @override
  String get progressOverall => 'الاستمرارية العامة';

  @override
  String progressDaysBody(int active, int total) {
    return '$active من $total أيام';
  }

  @override
  String get progressDaysTail => 'شهدت تقدّمًا ملموسًا في مجالات تركيزك.';

  @override
  String get progressOverTime => 'التقدّم عبر الزمن';

  @override
  String get progressDailyTrajectory => 'المسار اليومي هذا الأسبوع';

  @override
  String get progressWeeklyTrajectory => 'المسار الأسبوعي هذا الشهر';

  @override
  String get progressMonthlyTrajectory => 'المسار الشهري هذه السنة';

  @override
  String progressCurrent(Object pct) {
    return '$pct · الحالي';
  }

  @override
  String get progressLifeAreas => 'مجالات الحياة';

  @override
  String progressTracked(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n فئة متتبَّعة',
      many: '$n فئة متتبَّعة',
      few: '$n فئات متتبَّعة',
      two: 'فئتان متتبَّعتان',
      one: 'فئة متتبَّعة واحدة',
      zero: 'لا فئات متتبَّعة',
    );
    return '$_temp0';
  }

  @override
  String get progressNeedsFocus => 'يحتاج تركيزًا';

  @override
  String get progressStrongest => 'أقوى إيقاع';

  @override
  String progressStrongestBody(String pct, int days, int total) {
    return 'استمرارية $pct — نشاط في $days من $total أيام.';
  }

  @override
  String get progressAttention => 'يحتاج انتباهًا';

  @override
  String progressAttentionBody(Object pct) {
    return 'استمرارية $pct. خطوة يومية صغيرة هنا ستحسّن توازنك.';
  }

  @override
  String get progressConsistency => 'الاستمرارية';

  @override
  String progressMeaningfulDays(int n, String period) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n يوم من التقدّم الملموس',
      many: '$n يومًا من التقدّم الملموس',
      few: '$n أيام من التقدّم الملموس',
      two: 'يومان من التقدّم الملموس',
      one: 'يوم واحد من التقدّم الملموس',
      zero: 'لا أيام تقدّم ملموس',
    );
    return '$_temp0 في $period';
  }

  @override
  String get progressStrong => 'قوي';

  @override
  String get progressSteady => 'ثابت';

  @override
  String get progressLight => 'خفيف';

  @override
  String get progressRest => 'راحة';

  @override
  String get progressNotLogged => 'غير مسجّل';

  @override
  String progressBestDays(Object first, Object second) {
    return 'أكثر أيامك استمرارية هي $first و$second.';
  }

  @override
  String get progressActiveGoals => 'الأهداف النشطة';

  @override
  String get progressViewGoals => 'عرض كل الأهداف';

  @override
  String get progressMonthlyReady => 'مراجعة الشهر جاهزة';

  @override
  String progressMonthlySummary(Object month) {
    return 'ملخص $month';
  }

  @override
  String get progressMonthlyBody =>
      'اطّلع على أنماطك وأهم إنجازاتك وما تعدّله الشهر القادم.';

  @override
  String get progressReviewMonth => 'مراجعة هذا الشهر';

  @override
  String get progressWeeklyLink => 'مراجعة الأسبوع';

  @override
  String get progressEmptyTitle => 'تقدّمك يُبنى هنا';

  @override
  String get progressEmptyBody =>
      'أنجز مهمة أو سجّل شيئًا في أي مجال. ستظهر الاستمرارية والأنماط والاتجاهات مع الوقت.';

  @override
  String get progressAddAction => 'أضف شيئًا';

  @override
  String get calTitle => 'تقويم التقدّم';

  @override
  String get calToday => 'اليوم';

  @override
  String get calPrevMonth => 'الشهر السابق';

  @override
  String get calNextMonth => 'الشهر التالي';

  @override
  String get calOverall => 'الإجمالي';

  @override
  String calActiveDays(Object active, Object total) {
    return '$active / $total';
  }

  @override
  String get calActiveLabel => 'أيام نشطة';

  @override
  String get calAvg => 'المتوسط';

  @override
  String calStrongest(Object area) {
    return '$area الأقوى';
  }

  @override
  String get calSelected => 'التاريخ المحدد';

  @override
  String get calStrongDay => 'قوي ومركّز';

  @override
  String get calSteadyDay => 'ثابت';

  @override
  String get calLightDay => 'يوم خفيف';

  @override
  String get calNoDay => 'غير مسجّل';

  @override
  String get calFutureDay => 'قادم';

  @override
  String calTotalProgress(Object pct) {
    return 'إجمالي التقدّم $pct';
  }

  @override
  String calActionsDone(int done, int total) {
    return '$done من $total مهام منجزة';
  }

  @override
  String get calContributions => 'مساهمة الفئات';

  @override
  String calEntries(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n سجل',
      many: '$n سجلًا',
      few: '$n سجلات',
      two: 'سجلان',
      one: 'سجل واحد',
      zero: 'لا سجلات',
    );
    return '$_temp0';
  }

  @override
  String calActionsOn(Object date) {
    return 'مهام $date';
  }

  @override
  String get calDone => 'منجزة';

  @override
  String get calPending => 'معلّقة';

  @override
  String get calNothing =>
      'لم يُسجَّل شيء في هذا اليوم. أيام الراحة جزء من الإيقاع المستدام.';

  @override
  String get calFutureNothing => 'خطّط لهذا اليوم من خطتك اليومية.';

  @override
  String get calOpenPlan => 'فتح الخطة';

  @override
  String get calViewFull => 'عرض تفاصيل اليوم كاملة';

  @override
  String get calInsight => 'ملاحظة الإيقاع الشهري';

  @override
  String calInsightBody(Object first, Object second) {
    return 'كان $first و$second أكثر أيامك استمرارية.';
  }

  @override
  String get reviewWinGoalCompleted => 'اكتمل الهدف';

  @override
  String get reviewWinMilestone => 'تم بلوغ مرحلة';

  @override
  String reviewWinMilestoneOf(Object goal) {
    return 'مرحلة · $goal';
  }

  @override
  String reviewWinMoved(Object amount) {
    return '+$amount مسجّلة';
  }

  @override
  String reviewWinConsistency(String area, int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'استمرارية في $area لمدة $days يوم',
      many: 'استمرارية في $area لمدة $days يومًا',
      few: 'استمرارية في $area لمدة $days أيام',
      two: 'استمرارية في $area ليومين',
      one: 'استمرارية في $area ليوم واحد',
    );
    return '$_temp0';
  }

  @override
  String get reviewWinConsistencyBody => 'صمد الإيقاع رغم ضغط العمل.';

  @override
  String get reviewGapNoLog => 'لا سجل';

  @override
  String get reviewGapNoProgress => 'لم يُسجَّل تقدّم';

  @override
  String reviewGapLow(Object area) {
    return 'الاستمرارية في $area';
  }

  @override
  String reviewGapOf(Object done, Object target) {
    return '$done من $target مكتملة';
  }

  @override
  String get reviewPrioritiesAdd => 'إضافة أولوية';

  @override
  String get reviewPriorityTitle => 'الأولوية';

  @override
  String get reviewPriorityHint => 'مثال: التواصل مع 25 عميلًا محتملًا مؤهلًا';

  @override
  String get reviewPriorityArea => 'المجال';

  @override
  String get reviewPriorityGoal => 'تدعم هدفًا';

  @override
  String get reviewPriorityNoGoal => 'بدون هدف';

  @override
  String get reviewPrioritySuggested => 'من أهدافك';

  @override
  String get reviewPriorityRemove => 'إزالة الأولوية';

  @override
  String get reviewPriorityEdit => 'تعديل الأولوية';

  @override
  String reviewPriorityReorder(Object n) {
    return 'إعادة ترتيب الأولوية $n';
  }

  @override
  String reviewSelected(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'المحدد: $n',
      zero: 'لم يُحدَّد شيء',
    );
    return '$_temp0';
  }

  @override
  String get reviewPrioritiesEmpty => 'اختر حتى 3 التزامات محورية.';

  @override
  String get reviewPrioritiesMax =>
      'ثلاث أولويات تحافظ على وضوح التركيز. أزل واحدة لإضافة أخرى.';

  @override
  String get reviewSaveDraft => 'حفظ والإكمال لاحقًا';

  @override
  String get reviewSaved => 'تم حفظ المراجعة';

  @override
  String get reviewCompleted => 'اكتملت المراجعة';

  @override
  String reviewCompletedOn(Object date) {
    return 'اكتملت في $date. لا يزال بإمكانك تحديثها.';
  }

  @override
  String get reviewTagFocused => 'تركيز';

  @override
  String get reviewTagRoutine => 'روتين جيد';

  @override
  String get reviewTagQuran => 'استمرارية مع القرآن';

  @override
  String get reviewTagWork => 'إنتاجية قوية في العمل';

  @override
  String get reviewTagFamily => 'وقت مع العائلة';

  @override
  String get reviewTagHealth => 'عادات صحية';

  @override
  String get reviewTagDistraction => 'تشتت أقل';

  @override
  String get reviewTagSleep => 'النوم مبكرًا';

  @override
  String get reviewTagFewerTasks => 'مهام أقل';

  @override
  String get reviewTagProtectWorkout => 'حماية وقت التمرين';

  @override
  String get reviewTagPlanAhead => 'التخطيط المسبق';

  @override
  String get reviewTagConsistency => 'الاستمرارية';

  @override
  String get reviewTagWorkProgress => 'تقدّم في العمل';

  @override
  String get reviewTagQuranMemo => 'حفظ القرآن';

  @override
  String get reviewTagFinance => 'انضباط مالي';

  @override
  String get reviewTagLateSleep => 'سهر متأخر';

  @override
  String get reviewTagOverplanning => 'الإفراط في التخطيط';

  @override
  String get reviewTagLowEnergy => 'طاقة منخفضة';

  @override
  String get reviewTagBedtime => 'موعد نوم أبكر';

  @override
  String get reviewTagSimplerTargets => 'أهداف أبسط';

  @override
  String get reviewTagDelegate => 'تفويض أكثر';

  @override
  String get reviewTagFewerPriorities => 'أولويات أقل';

  @override
  String get weeklyTitle => 'مراجعة الأسبوع';

  @override
  String get weeklyGlance => 'أسبوعك بنظرة سريعة';

  @override
  String get weeklyGlanceBody => 'نظرة سريعة على ما تقدّم.';

  @override
  String get weeklyOverall => 'التقدّم العام';

  @override
  String get weeklyActiveDays => 'الأيام النشطة';

  @override
  String get weeklyActions => 'المهام';

  @override
  String get weeklyGoalsMoved => 'الأهداف المتقدّمة';

  @override
  String get weeklyGoalsUnit => 'أهداف';

  @override
  String get weeklyStrongest => 'أقوى استمرارية';

  @override
  String weeklyStrongestDays(int active, int total) {
    return '$active من $total أيام نشطة';
  }

  @override
  String get weeklyStrongestBody =>
      'صمد هذا الإيقاع طوال الأسبوع. حافظ على التوقيت نفسه.';

  @override
  String get weeklyAttention => 'يحتاج انتباهًا';

  @override
  String get weeklyAttentionBody =>
      'فكّر في جعل هدف الأسبوع القادم هنا أخف أو أكثر تحديدًا.';

  @override
  String get weeklyBiggestWin => 'أكبر إنجاز';

  @override
  String get weeklyEditWin => 'تعديل الإنجاز';

  @override
  String get weeklyWinHint => 'ما أكبر إنجاز لك هذا الأسبوع؟';

  @override
  String get weeklyAddWin => 'أضف أكبر إنجاز لك';

  @override
  String get weeklyDidntMove => 'ما الذي لم يتقدّم؟';

  @override
  String get weeklyCarriedOver => 'مُرحّل';

  @override
  String get weeklyAllMoved => 'تقدّم كل هدف نشط هذا الأسبوع.';

  @override
  String get weeklyReflection => 'تأمل الأسبوع';

  @override
  String get weeklyReflectionSub => 'ملاحظات سريعة لتثبيت الأفكار';

  @override
  String get weeklyWentWell => 'ما الذي سار جيدًا؟';

  @override
  String get weeklyWentWellHint => 'لحظات أو عادات نجحت...';

  @override
  String get weeklyChange => 'ما الذي يجب تغييره الأسبوع القادم؟';

  @override
  String get weeklyChangeHint => 'تعديلات أو مجالات تركيز...';

  @override
  String get weeklyNextFocus => 'تركيز الأسبوع القادم';

  @override
  String weeklyNextFocusSub(Object range) {
    return 'الالتزامات المحورية للفترة $range';
  }

  @override
  String weeklyInsightCheckIn(Object pct) {
    return 'الأيام التي بدأت بالمراجعة الصباحية كانت أعلى بنسبة $pct في المتوسط.';
  }

  @override
  String weeklyInsightDays(Object first, Object second) {
    return 'كان $first و$second أكثر أيامك استمرارية.';
  }

  @override
  String get weeklyFootnote =>
      'يحفظ تأملك ويضيف تركيزك إلى خطة الأسبوع القادم.';

  @override
  String get weeklyComplete => 'إكمال مراجعة الأسبوع';

  @override
  String get weeklyUpdate => 'تحديث مراجعة الأسبوع';

  @override
  String weeklyFocusAdded(Object date) {
    return 'أُضيف تركيز الأسبوع إلى خطتك ليوم $date';
  }

  @override
  String get weeklyFocusBadge => 'تركيز الأسبوع';

  @override
  String get monthlyTitle => 'مراجعة الشهر';

  @override
  String get monthlyCadence => 'تقدّم · الإيقاع الشهري';

  @override
  String get monthlyHero => 'شهرك من منظور شامل';

  @override
  String get monthlyHeroBody => 'اطّلع على ما تقدّم وما يجب تغييره بعد ذلك.';

  @override
  String get monthlyCompletion => 'إنجاز';

  @override
  String monthlyVs(Object delta, Object month) {
    return '$delta مقارنة بـ$month';
  }

  @override
  String get monthlyReviewsDone => 'المراجعات المنجزة';

  @override
  String monthlyActiveDomains(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n مجال نشط',
      many: '$n مجالًا نشطًا',
      few: '$n مجالات نشطة',
      two: 'مجالان نشطان',
      one: 'مجال نشط واحد',
      zero: 'لا مجالات نشطة',
    );
    return '$_temp0';
  }

  @override
  String get monthlyInsights => 'ملاحظات بنّاءة';

  @override
  String monthlyStrongestTitle(String area, int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: '$area · $days يوم نشط',
      many: '$area · $days يومًا نشطًا',
      few: '$area · $days أيام نشطة',
      two: '$area · يومان نشطان',
      one: '$area · يوم نشط واحد',
      zero: '$area · لا أيام نشطة',
    );
    return '$_temp0';
  }

  @override
  String get monthlyStrongestBody =>
      'أكثر إيقاعاتك ثباتًا هذا الشهر. حافظ على ما جعله سهلًا.';

  @override
  String get monthlyRefocus => 'مجال يحتاج إعادة تركيز';

  @override
  String monthlyRefocusTitle(Object area, Object pct) {
    return '$area · استمرارية $pct';
  }

  @override
  String get monthlyRefocusBody =>
      'قد يكون هدف أسبوعي أبسط أسهل في الحفاظ عليه الشهر القادم.';

  @override
  String get monthlyGoals => 'تقدّم الأهداف النشطة';

  @override
  String monthlyGoalsActive(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n نشط',
      many: '$n نشطًا',
      few: '$n نشطة',
      two: 'اثنان نشطان',
      one: 'واحد نشط',
      zero: 'لا شيء نشط',
    );
    return '$_temp0';
  }

  @override
  String monthlyGoalMoved(Object amount) {
    return '+$amount هذا الشهر';
  }

  @override
  String monthlyGoalMilestones(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'بلغت $n مرحلة هذا الشهر',
      many: 'بلغت $n مرحلة هذا الشهر',
      few: 'بلغت $n مراحل هذا الشهر',
      two: 'بلغت مرحلتين هذا الشهر',
      one: 'بلغت مرحلة واحدة هذا الشهر',
      zero: 'لم تُبلغ أي مرحلة هذا الشهر',
    );
    return '$_temp0';
  }

  @override
  String get monthlyGoalNoMove => 'لم يُسجَّل تقدّم هذا الشهر';

  @override
  String monthlyTarget(Object value) {
    return 'الهدف: $value';
  }

  @override
  String get monthlyQuote =>
      'الزخم يأتي من التأمل المنتظم، لا من الاندفاع المفاجئ.';

  @override
  String get monthlySnapshots => 'لمحات الفئات';

  @override
  String get monthlySnapshotsSub => 'اضغط للاطلاع';

  @override
  String monthlyDeepWork(Object time) {
    return '$time عمل عميق';
  }

  @override
  String monthlyClientsWon(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n عميل جديد',
      many: '$n عميلًا جديدًا',
      few: '$n عملاء جدد',
      two: 'عميلان جديدان',
      one: 'عميل جديد واحد',
      zero: 'لا عملاء جدد',
    );
    return '$_temp0';
  }

  @override
  String get monthlyLeads => 'عملاء محتملون';

  @override
  String get monthlyFollowUps => 'متابعات';

  @override
  String get monthlyProposals => 'عروض';

  @override
  String get monthlyRevenue => 'الإيرادات';

  @override
  String get monthlyIncome => 'الدخل';

  @override
  String get monthlyExpenses => 'المصروفات';

  @override
  String get monthlySaved => 'المدخر';

  @override
  String monthlyNet(Object amount) {
    return 'الصافي $amount';
  }

  @override
  String monthlyPagesRead(Object pages) {
    return '$pages صفحة مقروءة';
  }

  @override
  String monthlyActiveDaysShort(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n يوم نشط',
      many: '$n يومًا نشطًا',
      few: '$n أيام نشطة',
      two: 'يومان نشطان',
      one: 'يوم نشط واحد',
      zero: 'لا أيام نشطة',
    );
    return '$_temp0';
  }

  @override
  String get monthlyMemorized => 'الحفظ';

  @override
  String get monthlyRevision => 'المراجعة';

  @override
  String get monthlyActive => 'نشط';

  @override
  String monthlyDays(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n يوم',
      many: '$n يومًا',
      few: '$n أيام',
      two: 'يومان',
      one: 'يوم واحد',
      zero: '0 يوم',
    );
    return '$_temp0';
  }

  @override
  String monthlyWorkouts(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n تمرين',
      many: '$n تمرينًا',
      few: '$n تمارين',
      two: 'تمرينان',
      one: 'تمرين واحد',
      zero: 'لا تمارين',
    );
    return '$_temp0';
  }

  @override
  String monthlyAvgSleepValue(Object time) {
    return '$time نوم';
  }

  @override
  String get monthlyWalkDays => 'أيام المشي';

  @override
  String get monthlyAvgSleep => 'متوسط النوم';

  @override
  String get monthlyHabits => 'العادات';

  @override
  String monthlyStudy(Object time) {
    return '$time دراسة';
  }

  @override
  String get monthlySessions => 'الجلسات';

  @override
  String get monthlyTakeaways => 'الفوائد';

  @override
  String get monthlyFocus => 'التركيز';

  @override
  String monthlyNotes(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n ملاحظة',
      many: '$n ملاحظة',
      few: '$n ملاحظات',
      two: 'ملاحظتان',
      one: 'ملاحظة واحدة',
      zero: 'لا ملاحظات',
    );
    return '$_temp0';
  }

  @override
  String get monthlyPersonalTasks => 'المهام المنجزة';

  @override
  String get monthlyNoData => 'لم يُسجَّل شيء هنا هذا الشهر.';

  @override
  String get monthlyWins => 'أكبر إنجازات الشهر';

  @override
  String get monthlyNotPlanned => 'ما لم يسر كما خُطط له';

  @override
  String get monthlyReflection => 'تأمل الشهر';

  @override
  String get monthlyReflectionSub => '3 أسئلة سريعة';

  @override
  String get monthlyProud => '1. بماذا أفتخر؟';

  @override
  String get monthlyHeldBack => '2. ما الذي أعاقني؟';

  @override
  String get monthlyDifferent =>
      '3. ما الذي يجب أن أفعله بشكل مختلف الشهر القادم؟';

  @override
  String get monthlyNoteHint => 'أضف ملاحظة...';

  @override
  String get monthlyLesson => 'درس واحد أحمله معي';

  @override
  String get monthlyLessonHint =>
      'مثال: الأولويات الأقل ساعدتني على إنجاز عمل أكثر قيمة.';

  @override
  String monthlyNextFocus(Object month) {
    return 'تركيز $month';
  }

  @override
  String get monthlyNextFocusSub => 'أهم 3 أولويات ملتزم بها';

  @override
  String monthlyBalanced(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'يبدو تركيز الشهر القادم متوازنًا بين $n مجال.',
      many: 'يبدو تركيز الشهر القادم متوازنًا بين $n مجالًا.',
      few: 'يبدو تركيز الشهر القادم متوازنًا بين $n مجالات.',
      two: 'يبدو تركيز الشهر القادم متوازنًا بين مجالين.',
      one: 'يبدو تركيز الشهر القادم في مجال واحد.',
    );
    return '$_temp0';
  }

  @override
  String get monthlyNarrow =>
      'كل الأولويات في مجال واحد. لا بأس إن كان ذلك مقصودًا.';

  @override
  String get monthlyComplete => 'إكمال مراجعة الشهر';

  @override
  String get monthlyUpdate => 'تحديث مراجعة الشهر';

  @override
  String get monthlyNothingYet =>
      'لا شيء لإبرازه بعد. سجّل تقدّمك خلال الشهر وسيظهر هنا.';

  @override
  String get activityTitle => 'سجل النشاط';

  @override
  String get activitySearchHint => 'ابحث في النشاط والملاحظات والمؤشرات...';

  @override
  String get activityClearSearch => 'مسح البحث';

  @override
  String get activityAll => 'الكل';

  @override
  String get activityReviews => 'المراجعات';

  @override
  String get activityReview => 'مراجعة';

  @override
  String activityEntries(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n سجل',
      many: '$n سجلًا',
      few: '$n سجلات',
      two: 'سجلين',
      one: 'سجل واحد',
      zero: 'لا سجلات',
    );
    return '$_temp0';
  }

  @override
  String activityAreas(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n مجال',
      many: '$n مجالًا',
      few: '$n مجالات',
      two: 'مجالين',
      one: 'مجال واحد',
      zero: 'دون مجالات',
    );
    return '$_temp0';
  }

  @override
  String activityShowing(Object areas, Object entries) {
    return 'عرض $entries في $areas';
  }

  @override
  String activityLogs(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n سجل',
      many: '$n سجلًا',
      few: '$n سجلات',
      two: 'سجلان',
      one: 'سجل واحد',
      zero: 'لا سجلات',
    );
    return '$_temp0';
  }

  @override
  String get activityToday => 'اليوم';

  @override
  String get activityYesterday => 'أمس';

  @override
  String get activityRangeTitle => 'النطاق الزمني';

  @override
  String get activityRangeAll => 'كل الأوقات';

  @override
  String get activityRangeWeek => 'هذا الأسبوع';

  @override
  String get activityRangeMonth => 'هذا الشهر';

  @override
  String get activityRangeLastMonth => 'الشهر الماضي';

  @override
  String get activityRangeYear => 'هذه السنة';

  @override
  String get activityFilterDate => 'التصفية حسب التاريخ';

  @override
  String get activityEmptyTitle => 'لا توجد سجلات';

  @override
  String get activityEmptyBody => 'لا توجد أنشطة تطابق الفئة أو البحث الحالي.';

  @override
  String get activityReset => 'إعادة ضبط التصفية';

  @override
  String get activityNothingTitle => 'لا نشاط بعد';

  @override
  String get activityNothingBody =>
      'كل ما تسجّله، من المهام والقرآن إلى العمل والمال والصحة والتعلّم، يظهر هنا.';

  @override
  String get activityDetail => 'تفاصيل النشاط';

  @override
  String get activityLoggedTime => 'وقت التسجيل';

  @override
  String get activityAmount => 'المبلغ';

  @override
  String get activityType => 'النوع';

  @override
  String get activityDismiss => 'إغلاق';

  @override
  String get activityOpenPlan => 'فتح خطة اليوم';

  @override
  String get activityOpenGoal => 'فتح الهدف';

  @override
  String get activityTypeCreated => 'إنشاء';

  @override
  String get activityTypeCompleted => 'إنجاز';

  @override
  String get activityTypeLogged => 'تسجيل';

  @override
  String get activityTypeReviewed => 'مراجعة';

  @override
  String get activityTypeUpdated => 'تحديث';

  @override
  String get activityTypeMilestone => 'مرحلة';

  @override
  String get notifTitle => 'الإشعارات';

  @override
  String get notifHeadline => 'الإشعارات والتذكيرات';

  @override
  String get notifSubtitle => 'اختر التذكيرات التي تساعدك على الاستمرار.';

  @override
  String notifActiveCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n تذكير نشط',
      many: '$n تذكيرًا نشطًا',
      few: '$n تذكيرات نشطة',
      two: 'تذكيران نشطان',
      one: 'تذكير نشط واحد',
      zero: 'لا تذكيرات نشطة',
    );
    return '$_temp0';
  }

  @override
  String notifQuietActive(Object range) {
    return 'ساعات الهدوء مفعّلة ($range)';
  }

  @override
  String get notifPaused => 'كل التذكيرات متوقفة مؤقتًا';

  @override
  String get notifAll => 'كل الإشعارات';

  @override
  String get notifAllBody =>
      'أوقف كل تذكيرات تقدّم مؤقتًا دون فقدان أوقاتها المجدولة.';

  @override
  String get notifDailyRoutine => 'الروتين اليومي';

  @override
  String get notifMorningBody => 'ابدأ يومك بأهم 3 أولويات.';

  @override
  String get notifNightBody => 'اختم يومك بتأمل هادئ من 3 أسئلة.';

  @override
  String get notifQuranSection => 'القرآن والإيمان';

  @override
  String get notifQuranReading => 'تذكير القراءة اليومية';

  @override
  String get notifQuranReadingBody => 'تذكير لطيف بورد القرآن اليوم.';

  @override
  String get notifQuranMemo => 'تمرين الحفظ';

  @override
  String get notifQuranMemoBody => 'واصل حفظك الحالي.';

  @override
  String get notifQuranRevision => 'المراجعة والتثبيت';

  @override
  String get notifQuranRevisionBody =>
      'حافظ على تثبيت الصفحات المحفوظة سابقًا.';

  @override
  String get notifHabitsSection => 'العادات والصحة';

  @override
  String get notifManageHabits => 'إدارة تذكيرات العادات';

  @override
  String get notifNoHabitReminders => 'لا توجد تذكيرات للعادات بعد.';

  @override
  String get notifAddHabit => 'إضافة عادة';

  @override
  String get notifHabitPicker => 'تذكيرات العادات';

  @override
  String get notifHabitPickerBody => 'اختر عادة ثم حدّد وقتًا.';

  @override
  String notifHabitSet(Object time) {
    return 'تذكير عند $time';
  }

  @override
  String get notifHabitNone => 'بدون تذكير';

  @override
  String get notifRemoveReminder => 'إزالة التذكير';

  @override
  String get notifWorkSection => 'العمل والأعمال';

  @override
  String get notifFollowUps => 'تذكيرات المتابعة';

  @override
  String get notifFollowUpsBody =>
      'ذكّرني عند حلول موعد متابعة العروض أو العملاء المحتملين.';

  @override
  String notifMorningSummary(Object time) {
    return 'ملخص الصباح ($time)';
  }

  @override
  String get notifReviewsSection => 'المراجعات الدورية';

  @override
  String get notifWeeklyBody => 'تأمّل أسبوعك وحدّد أهم 3 أولويات قادمة.';

  @override
  String get notifMonthlyBody => 'راجع شهرك وخطّط للشهر القادم.';

  @override
  String notifEvery(Object day, Object time) {
    return 'كل $day · $time';
  }

  @override
  String notifLastDay(Object time) {
    return 'آخر يوم في الشهر · $time';
  }

  @override
  String get notifReviewDay => 'يوم المراجعة';

  @override
  String get notifQuietSection => 'ساعات الهدوء وتجربة هادئة';

  @override
  String get notifQuiet => 'ساعات الهدوء';

  @override
  String get notifQuietBody => 'لا أصوات ولا تذكيرات منبثقة خلال فترة راحتك.';

  @override
  String get notifQuietStart => 'بداية ساعات الهدوء';

  @override
  String get notifQuietEnd => 'نهاية ساعات الهدوء';

  @override
  String get notifSmart => 'إيقاف التذكير الذكي';

  @override
  String get notifSmartBody =>
      'إذا سجّلت النشاط مسبقًا (مثل قراءة القرآن أو إنجاز عادة)، يتخطى تقدّم تذكير ذلك اليوم.';

  @override
  String get notifActive => 'مفعّل';

  @override
  String get notifOff => 'متوقف';

  @override
  String get notifPreview => 'معاينة';

  @override
  String notifPreviewNext(Object when) {
    return 'التالي · $when';
  }

  @override
  String get notifPreviewNone => 'لا توجد تذكيرات قادمة وفق إعداداتك الحالية.';

  @override
  String get notifInQuiet => 'يقع ضمن ساعات الهدوء';

  @override
  String get notifDaily => 'يوميًا';

  @override
  String get notifWeekdays => 'أيام العمل';

  @override
  String get notifRepeat => 'التكرار في';

  @override
  String get notifDays => 'الأيام';

  @override
  String get notifAuthorized => 'إشعارات النظام مسموح بها';

  @override
  String get notifDenied => 'الإشعارات متوقفة لتطبيق تقدّم';

  @override
  String get notifDeniedBody =>
      'لن تظهر التذكيرات حتى تسمح بالإشعارات. إن لم تظهر نافذة الإذن، فعّلها من إعدادات جهازك.';

  @override
  String get notifAllow => 'السماح بالإشعارات';

  @override
  String get notifTime => 'الوقت';

  @override
  String get profileTitle => 'الملف الشخصي';

  @override
  String get profileSettings => 'الإعدادات';

  @override
  String get profileEdit => 'تعديل الملف الشخصي';

  @override
  String get profileMember => 'عضو في تقدّم · مساحة شخصية';

  @override
  String get profileCurrentFocus => 'التركيز الحالي';

  @override
  String get profilePrimaryFocus => 'التركيز الرئيسي';

  @override
  String profileTarget(Object value) {
    return 'الهدف: $value';
  }

  @override
  String profileInitiated(Object date) {
    return 'بدأ في $date';
  }

  @override
  String profileNext(Object action) {
    return 'التالي: $action';
  }

  @override
  String get profileNoFocus => 'لا يوجد تركيز رئيسي بعد';

  @override
  String get profileNoFocusBody =>
      'اجعل أحد أهدافك تركيزًا رئيسيًا ليبقى أمام عينيك.';

  @override
  String get profileChooseFocus => 'اختر تركيزًا';

  @override
  String profileYearProgress(Object year) {
    return 'تقدّم $year';
  }

  @override
  String get profileAnnual => 'الأفق السنوي';

  @override
  String get profileAlignment => 'الاستمرارية العامة في مجالات تركيزك';

  @override
  String get profileOnSchedule => 'وفق الجدول';

  @override
  String get profileSteady => 'ثابت';

  @override
  String get profileBuilding => 'قيد البناء';

  @override
  String get profileActiveConsistency => 'الاستمرارية النشطة';

  @override
  String get profileActiveThisMonth => 'النشاط هذا الشهر';

  @override
  String get profileYearGoals => 'أهداف السنة';

  @override
  String profileGoalsSummary(int active, int done) {
    return '$active نشط · $done مكتمل';
  }

  @override
  String profileGoalsTotal(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n هدف معلن',
      many: '$n هدفًا معلنًا',
      few: '$n أهداف معلنة',
      two: 'هدفان معلنان',
      one: 'هدف واحد معلن',
      zero: 'لا أهداف معلنة',
    );
    return '$_temp0';
  }

  @override
  String get profileLifeAreas => 'مجالات حياتي';

  @override
  String profileLifeAreasSub(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n مجال نشط',
      many: '$n مجالًا نشطًا',
      few: '$n مجالات نشطة',
      two: 'مجالان نشطان',
      one: 'مجال حياة نشط واحد',
      zero: 'لا مجالات نشطة',
    );
    return '$_temp0';
  }

  @override
  String get profileEditAreas => 'تعديل مجالات الحياة';

  @override
  String get profileAreaActive => 'نشط';

  @override
  String get profileAreaOff => 'متوقف';

  @override
  String profileIntention(Object year) {
    return 'نية $year';
  }

  @override
  String get profileIntentionHint =>
      'مثال: بناء سنة متوازنة بين الإيمان والعمل الهادف والعائلة.';

  @override
  String get profileAddIntention => 'أضف نيتك لهذه السنة';

  @override
  String get profileEditIntention => 'تعديل النية';

  @override
  String get profileYourTaqaddum => 'تقدّمك';

  @override
  String get profileActivity => 'سجل النشاط';

  @override
  String get profileActivityBody => 'اطّلع على نشاطك وسجلاتك السابقة';

  @override
  String get profileWeekly => 'مراجعة الأسبوع';

  @override
  String get profileWeeklyBody => 'تأمّل أسبوعك';

  @override
  String get profileMonthly => 'مراجعة الشهر';

  @override
  String get profileMonthlyBody => 'راجع تقدّمك الشهري';

  @override
  String get profileNotifications => 'الإشعارات والتذكيرات';

  @override
  String get profileNotificationsBody => 'إدارة التذكيرات وساعات الهدوء';

  @override
  String get profileSettingsBody => 'اللغة والتفضيلات والحساب وخيارات التطبيق';

  @override
  String get profileExport => 'تصدير بياناتي';

  @override
  String get profileBackup => 'محفوظة على هذا الجهاز';

  @override
  String profileFooter(Object date, Object version) {
    return 'تقدّم v$version · منذ $date';
  }

  @override
  String get profilePrivate => 'خاص وعلى الجهاز';

  @override
  String get profileName => 'الاسم الكامل';

  @override
  String get profileRole => 'الدور';

  @override
  String get profileRoleHint => 'مثال: رائد أعمال';

  @override
  String get profileSaved => 'تم تحديث الملف الشخصي';

  @override
  String get settingsTitle => 'الإعدادات';

  @override
  String get settingsUpdated => 'تم تحديث التفضيل';

  @override
  String get settingsPreferences => 'التفضيلات';

  @override
  String get settingsLanguage => 'اللغة';

  @override
  String get settingsReduceMotion => 'تقليل الحركة';

  @override
  String get settingsReduceMotionBody => 'انتقالات أقصر وأبسط';

  @override
  String get settingsPlanning => 'التخطيط';

  @override
  String get settingsWeekStart => 'بداية الأسبوع';

  @override
  String get settingsCurrency => 'العملة';

  @override
  String get settingsTimeFormat => 'تنسيق الوقت';

  @override
  String get settings24h => '24 ساعة';

  @override
  String get settings12h => '12 ساعة';

  @override
  String get settingsNotifications => 'الإشعارات';

  @override
  String get settingsNotificationsBody => 'إدارة جدول التذكيرات وساعات الهدوء';

  @override
  String get settingsOn => 'مفعّل';

  @override
  String get settingsOff => 'متوقف';

  @override
  String get settingsPersonalization => 'التخصيص';

  @override
  String get settingsLifeAreas => 'مجالات الحياة';

  @override
  String get settingsLifeAreasBody => 'اختر المجالات التي تتابعها';

  @override
  String settingsLifeAreasCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n نشط',
      many: '$n نشطًا',
      few: '$n نشطة',
      two: 'اثنان نشطان',
      one: 'واحد نشط',
      zero: 'لا شيء نشط',
    );
    return '$_temp0';
  }

  @override
  String get settingsLifeAreasMin => 'أبقِ مجالًا واحدًا نشطًا على الأقل.';

  @override
  String get settingsPrimaryFocus => 'التركيز الرئيسي';

  @override
  String get settingsPrimaryFocusBody => 'التزامك المحوري الحالي';

  @override
  String get settingsNoGoals => 'أنشئ هدفًا أولًا';

  @override
  String get settingsDataPrivacy => 'البيانات والخصوصية';

  @override
  String get settingsActivity => 'سجل النشاط';

  @override
  String get settingsActivityBody => 'راجع سجلاتك وإدخالاتك السابقة';

  @override
  String get settingsExport => 'تصدير بياناتي';

  @override
  String get settingsExportBody => 'أنشئ نسخة من بيانات تقدّمك';

  @override
  String get settingsExportJson => 'JSON (نسخة احتياطية كاملة)';

  @override
  String get settingsExportJsonBody => 'كل الجداول في ملف واحد';

  @override
  String get settingsExportCsv => 'CSV (جداول بيانات)';

  @override
  String get settingsExportCsvBody => 'المعاملات وسجل النشاط';

  @override
  String get settingsExportFailed => 'تعذّر التصدير. حاول مرة أخرى.';

  @override
  String get settingsPrivacy => 'الخصوصية والأمان';

  @override
  String get settingsPrivacyBody => 'تخزين محلي دون تتبع من أطراف خارجية';

  @override
  String get settingsPrivacyP4 =>
      'كل ما تسجّله محفوظ في التخزين الخاص بالتطبيق على هذا الجهاز. حذف التطبيق يزيله، لذا صدّر نسخة إن أردت الاحتفاظ بنسخة احتياطية.';

  @override
  String get settingsAccount => 'الحساب';

  @override
  String get settingsAccountProfile => 'ملف الحساب';

  @override
  String get settingsEmail => 'البريد الإلكتروني';

  @override
  String get settingsEmailNone => 'غير محدد';

  @override
  String get settingsEmailSaved => 'تم تحديث البريد الإلكتروني';

  @override
  String get settingsSecurity => 'أمان تسجيل الدخول';

  @override
  String get settingsPasswordSet => 'كلمة المرور محددة';

  @override
  String get settingsPasswordNone => 'لا توجد كلمة مرور';

  @override
  String get settingsPasswordTitle => 'تغيير كلمة المرور';

  @override
  String get settingsPasswordAddTitle => 'إضافة كلمة مرور';

  @override
  String get settingsPasswordCurrent => 'كلمة المرور الحالية';

  @override
  String get settingsPasswordNew => 'كلمة المرور الجديدة';

  @override
  String get settingsPasswordSaved => 'تم حفظ كلمة المرور';

  @override
  String get settingsPasswordNeedsEmail =>
      'أضف بريدًا إلكترونيًا أولًا. ستستخدمه مع كلمة المرور لتسجيل الدخول.';

  @override
  String get settingsLogout => 'تسجيل الخروج';

  @override
  String get settingsLogoutTitle => 'تسجيل الخروج؟';

  @override
  String get settingsLogoutBody =>
      'تبقى بياناتك على هذا الجهاز. سجّل الدخول مجددًا لتتابع من حيث توقفت.';

  @override
  String get settingsLogoutNoPassword =>
      'لا توجد كلمة مرور على هذا الجهاز. يمكنك المتابعة على هذا الجهاز من شاشة تسجيل الدخول في أي وقت.';

  @override
  String get settingsSupport => 'الدعم وحول التطبيق';

  @override
  String get settingsHelp => 'المساعدة والأسئلة الشائعة';

  @override
  String get settingsHelpQ1 => 'أين تُحفظ بياناتي؟';

  @override
  String get settingsHelpA1 =>
      'على هذا الجهاز فقط. يعمل تقدّم دون اتصال بالكامل ولا يرسل سجلاتك إلى أي مكان.';

  @override
  String get settingsHelpQ2 => 'كيف يُحسب التقدّم؟';

  @override
  String get settingsHelpA2 =>
      'نتيجة اليوم هي نسبة المهام المخطط لها التي أنجزتها. دون خطة، تُحتسب ثلاثة أنشطة مسجّلة يومًا كاملًا.';

  @override
  String get settingsHelpQ3 => 'كيف أنشئ نسخة احتياطية؟';

  @override
  String get settingsHelpA3 =>
      'استخدم «تصدير بياناتي» لحفظ نسخة JSON في المكان الذي تختاره.';

  @override
  String get settingsHelpQ4 => 'لماذا لم يظهر التذكير؟';

  @override
  String get settingsHelpA4 =>
      'تُتخطى التذكيرات خلال ساعات الهدوء، ويتخطى الإيقاف الذكي التذكير إذا سجّلت ذلك النشاط اليوم.';

  @override
  String get settingsAbout => 'حول تقدّم';

  @override
  String get settingsLicenses => 'تراخيص البرمجيات المفتوحة';

  @override
  String get settingsTerms => 'الشروط';

  @override
  String get settingsPrivacyPolicy => 'سياسة الخصوصية';

  @override
  String get settingsDanger => 'إجراءات الحساب';

  @override
  String get settingsDelete => 'حذف الحساب';

  @override
  String get settingsDeleteBody =>
      'احذف حسابك في تقدّم وكل السجلات المحلية على هذا الجهاز نهائيًا.';

  @override
  String get settingsDeleteTitle => 'حذف كل شيء؟';

  @override
  String get settingsDeleteConfirm =>
      'سيؤدي هذا إلى حذف حسابك وأهدافك وسجلاتك ومراجعاتك وتذكيراتك وتفضيلاتك من هذا الجهاز. لا يمكن التراجع عن ذلك.';

  @override
  String get settingsDeleteButton => 'حذف نهائي';

  @override
  String get settingsFooter => 'صُمّم لاستمرارية هادئة';

  @override
  String get settingsDeveloper => 'المطوّر';

  @override
  String get settingsDemo => 'تحميل بيانات تجريبية';

  @override
  String get settingsDemoBody => 'املأ التطبيق بأهداف وسجلات نموذجية للاختبار';

  @override
  String get settingsDemoConfirm =>
      'سيضيف هذا أهدافًا ومهام وسجلات نموذجية إلى بياناتك الحالية. استخدمه للاختبار فقط.';

  @override
  String get settingsDemoDone => 'تمت إضافة البيانات التجريبية';

  @override
  String get activityCheckInTitle => 'المراجعة الصباحية';

  @override
  String get activityNightReviewTitle => 'اكتملت مراجعة المساء';

  @override
  String get activityWeeklyReviewTitle => 'اكتملت مراجعة الأسبوع';

  @override
  String get activityMonthlyReviewTitle => 'اكتملت مراجعة الشهر';

  @override
  String activityPrioritiesSet(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'حُدّدت $count أولوية',
      many: 'حُدّدت $count أولوية',
      few: 'حُدّدت $count أولويات',
      two: 'حُدّدت أولويتان',
      one: 'حُدّدت أولوية واحدة',
      zero: 'لم تُحدَّد أولويات',
    );
    return '$_temp0';
  }

  @override
  String activityDayRated(int rating) {
    return 'تقييم اليوم $rating من 5';
  }

  @override
  String activityDateRange(String start, String end) {
    return '$start – $end';
  }

  @override
  String get activityHabitAdded => 'تمت إضافة عادة';

  @override
  String get activityHabit => 'عادة';

  @override
  String get activityGoalCreated => 'تم إنشاء هدف';

  @override
  String get activityGoalUpdated => 'تم تحديث الهدف';

  @override
  String get activityGoalCompleted => 'اكتمل الهدف';

  @override
  String get activityProgressLogged => 'تم تسجيل التقدّم';

  @override
  String get activityNote => 'ملاحظة';

  @override
  String activityStudySession(String topic) {
    return 'جلسة دراسة · $topic';
  }

  @override
  String activityWalkTitle(String duration) {
    return 'مشي · $duration';
  }

  @override
  String activitySleepTitle(String duration) {
    return 'نوم · $duration';
  }

  @override
  String activitySteps(int count, String steps) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$steps خطوة',
      many: '$steps خطوة',
      few: '$steps خطوات',
      two: 'خطوتان',
      one: 'خطوة واحدة',
      zero: '0 خطوة',
    );
    return '$_temp0';
  }

  @override
  String activitySleepWindow(String bed, String wake) {
    return 'النوم $bed · الاستيقاظ $wake';
  }

  @override
  String activityOpenArea(String area) {
    return 'فتح $area';
  }

  @override
  String get unitNamePages => 'صفحات';

  @override
  String get unitNameJuz => 'أجزاء';

  @override
  String get unitNameHours => 'ساعات';

  @override
  String get unitNameMinutes => 'دقائق';

  @override
  String get unitNameSessions => 'جلسات';

  @override
  String get unitNameBooks => 'كتب';

  @override
  String get unitNameKm => 'كم';

  @override
  String get unitNameTimes => 'مرات';

  @override
  String qtyPages(num count, String value) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$value صفحة',
      many: '$value صفحة',
      few: '$value صفحات',
      two: 'صفحتان',
      one: 'صفحة واحدة',
      zero: '$value صفحة',
    );
    return '$_temp0';
  }

  @override
  String qtyJuz(num count, String value) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$value جزء',
      many: '$value جزءًا',
      few: '$value أجزاء',
      two: 'جزآن',
      one: 'جزء واحد',
      zero: '$value جزء',
    );
    return '$_temp0';
  }

  @override
  String qtyHours(num count, String value) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$value ساعة',
      many: '$value ساعة',
      few: '$value ساعات',
      two: 'ساعتان',
      one: 'ساعة واحدة',
      zero: '$value ساعة',
    );
    return '$_temp0';
  }

  @override
  String qtyMinutes(num count, String value) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$value دقيقة',
      many: '$value دقيقة',
      few: '$value دقائق',
      two: 'دقيقتان',
      one: 'دقيقة واحدة',
      zero: '$value دقيقة',
    );
    return '$_temp0';
  }

  @override
  String qtySessions(num count, String value) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$value جلسة',
      many: '$value جلسة',
      few: '$value جلسات',
      two: 'جلستان',
      one: 'جلسة واحدة',
      zero: '$value جلسة',
    );
    return '$_temp0';
  }

  @override
  String qtyBooks(num count, String value) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$value كتاب',
      many: '$value كتابًا',
      few: '$value كتب',
      two: 'كتابان',
      one: 'كتاب واحد',
      zero: '$value كتاب',
    );
    return '$_temp0';
  }

  @override
  String qtyKm(num count, String value) {
    return '$value كم';
  }

  @override
  String qtyTimes(num count, String value) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$value مرة',
      many: '$value مرة',
      few: '$value مرات',
      two: 'مرتان',
      one: 'مرة واحدة',
      zero: '$value مرة',
    );
    return '$_temp0';
  }

  @override
  String get currencyDzd => 'دينار جزائري';

  @override
  String get currencyMad => 'درهم مغربي';

  @override
  String get currencyTnd => 'دينار تونسي';

  @override
  String get currencySar => 'ريال سعودي';

  @override
  String get currencyAed => 'درهم إماراتي';

  @override
  String get currencyEgp => 'جنيه مصري';

  @override
  String get currencyEur => 'يورو';

  @override
  String get currencyUsd => 'دولار أمريكي';

  @override
  String get currencyGbp => 'جنيه إسترليني';

  @override
  String settingsCurrencyOption(String code, String name) {
    return '$name ($code)';
  }

  @override
  String get notifChannelName => 'التذكيرات';

  @override
  String get notifChannelDescription => 'تذكيرات محلية لطيفة تضبطها في تقدّم';

  @override
  String progressWeekAxis(int week) {
    return '$week';
  }

  @override
  String progressChartLabel(String period) {
    return 'التقدّم عبر الزمن، $period';
  }

  @override
  String commonOfTargetMinutes(int target) {
    return '/ $target د';
  }

  @override
  String commonMinutesOfTarget(int minutes, int target) {
    return '$minutes / $target د';
  }

  @override
  String get appName => 'تقدّم';
}
