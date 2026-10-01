// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get commonBack => 'Retour';

  @override
  String get commonClose => 'Fermer';

  @override
  String get commonCancel => 'Annuler';

  @override
  String get commonSave => 'Enregistrer';

  @override
  String get commonDone => 'Terminé';

  @override
  String get commonEdit => 'Edit';

  @override
  String get commonDelete => 'Delete';

  @override
  String get commonContinue => 'Continuer';

  @override
  String get commonSkip => 'Passer';

  @override
  String get commonToday => 'Aujourd\'hui';

  @override
  String get commonTomorrow => 'Demain';

  @override
  String get commonYesterday => 'Hier';

  @override
  String get commonOptional => 'Optional';

  @override
  String get commonNone => 'None';

  @override
  String get commonRetry => 'Try again';

  @override
  String get commonViewAll => 'View all';

  @override
  String get commonSomethingWrong => 'Something went wrong';

  @override
  String get commonSomethingWrongBody =>
      'We couldn\'t load this section. Your data is safe on this device.';

  @override
  String get commonRequired => 'Required';

  @override
  String get commonInvalidNumber => 'Enter a valid number';

  @override
  String get commonSaved => 'Saved';

  @override
  String get commonConfirm => 'Confirm';

  @override
  String get commonDate => 'Date';

  @override
  String get commonTime => 'Time';

  @override
  String get commonNote => 'Note';

  @override
  String get commonNotePlaceholder => 'Add a short note';

  @override
  String get commonMinutes => 'Minutes';

  @override
  String commonMinutesShort(int count) {
    return '$count min';
  }

  @override
  String get commonLinkedGoal => 'Counts toward goal';

  @override
  String get commonNoLinkedGoal => 'Not linked to a goal';

  @override
  String commonPercentComplete(int percent) {
    return '$percent% completed';
  }

  @override
  String commonOfTotal(int done, int total) {
    return '$done of $total';
  }

  @override
  String get commonOnTrack => 'On track';

  @override
  String get commonNeedsAttention => 'Needs attention';

  @override
  String get commonCompleted => 'Completed';

  @override
  String get commonPaused => 'Paused';

  @override
  String get commonActive => 'Active';

  @override
  String get commonWeek => 'Week';

  @override
  String get commonMonth => 'Month';

  @override
  String get commonYear => 'Year';

  @override
  String get commonThisWeek => 'This week';

  @override
  String get commonThisMonth => 'This month';

  @override
  String get commonLastMonth => 'Last month';

  @override
  String get commonDecrease => 'Decrease';

  @override
  String get commonIncrease => 'Increase';

  @override
  String get commonAdd => 'Add';

  @override
  String get commonUndo => 'Undo';

  @override
  String get commonMore => 'More options';

  @override
  String get commonDiscard => 'Discard';

  @override
  String get commonKeepEditing => 'Keep editing';

  @override
  String get commonUnsavedTitle => 'Discard changes?';

  @override
  String get commonUnsavedBody => 'Your changes haven\'t been saved yet.';

  @override
  String get areaQuran => 'Coran';

  @override
  String get areaWork => 'Travail';

  @override
  String get areaFinance => 'Finances';

  @override
  String get areaHealth => 'Santé';

  @override
  String get areaLearning => 'Apprentissage';

  @override
  String get areaPersonal => 'Vie personnelle';

  @override
  String get areaReview => 'Review';

  @override
  String get areaQuranLong => 'Quran & Faith';

  @override
  String get areaWorkLong => 'Work & Growth';

  @override
  String get areaFinanceLong => 'Personal Finance';

  @override
  String get areaHealthLong => 'Health & Habits';

  @override
  String get areaLearningLong => 'Learning';

  @override
  String get areaPersonalLong => 'Personal Life';

  @override
  String get navToday => 'Aujourd\'hui';

  @override
  String get navProgress => 'Progrès';

  @override
  String get navGoals => 'Objectifs';

  @override
  String get navProfile => 'Profil';

  @override
  String get navQuickAdd => 'Ajouter';

  @override
  String get reminderMorningTitle => 'Morning check-in';

  @override
  String get reminderMorningBody =>
      'Take a minute to choose today\'s 3 priorities.';

  @override
  String get reminderNightTitle => 'Night review';

  @override
  String get reminderNightBody =>
      'Close the day with a quiet 3-question reflection.';

  @override
  String get reminderQuranReadingTitle => 'Quran reading';

  @override
  String get reminderQuranReadingBody =>
      'Your Quran reading is still open for today. Ready whenever you are.';

  @override
  String get reminderQuranMemoTitle => 'Memorization practice';

  @override
  String get reminderQuranMemoBody =>
      'Continue your active memorization when you have a calm moment.';

  @override
  String get reminderQuranRevisionTitle => 'Revision';

  @override
  String get reminderQuranRevisionBody =>
      'Keep previously memorized pages fresh with a short revision.';

  @override
  String reminderHabitTitle(String habit) {
    return '$habit';
  }

  @override
  String get reminderHabitBody => 'A gentle reminder for your habit today.';

  @override
  String get reminderWorkTitle => 'Follow-ups';

  @override
  String get reminderWorkBody =>
      'Review the proposals and leads that need a follow-up today.';

  @override
  String get reminderWeeklyTitle => 'Weekly review';

  @override
  String get reminderWeeklyBody =>
      'Reflect on the week and set your next 3 priorities.';

  @override
  String get reminderMonthlyTitle => 'Monthly review';

  @override
  String get reminderMonthlyBody => 'Review your month and plan the next one.';

  @override
  String get splashTagline => 'Progress, one day at a time.';

  @override
  String get splashFooter => 'Build your better days.';

  @override
  String get authWelcomeBack => 'Welcome back';

  @override
  String get authWelcomeCreate => 'Create your account';

  @override
  String get authSubtitle => 'Continue building your intentional momentum.';

  @override
  String get authCreateSubtitle =>
      'Your account and data stay on this device. No internet needed.';

  @override
  String get authTabSignIn => 'Sign In';

  @override
  String get authTabCreate => 'Create Account';

  @override
  String get authEmail => 'Email';

  @override
  String get authEmailHint => 'name@example.com';

  @override
  String get authPassword => 'Password';

  @override
  String get authFullName => 'Full Name';

  @override
  String get authNameHint => 'Omar Al-Farouq';

  @override
  String get authCreatePassword => 'Create Password';

  @override
  String get authPasswordHint => 'At least 8 characters';

  @override
  String get authShowPassword => 'Show password';

  @override
  String get authHidePassword => 'Hide password';

  @override
  String get authRememberMe => 'Remember me';

  @override
  String get authForgot => 'Forgot password?';

  @override
  String get authRuleLength => '8+ chars';

  @override
  String get authRuleMix => 'Letters & numbers';

  @override
  String get authTermsPrefix => 'By joining Taqaddum, you agree to our ';

  @override
  String get authTerms => 'Terms';

  @override
  String get authAnd => ' & ';

  @override
  String get authPrivacy => 'Privacy Policy';

  @override
  String get authOrContinue => 'or continue with';

  @override
  String get authContinueDevice => 'Continue on this device';

  @override
  String get authNoAccount => 'Don\'t have an account?';

  @override
  String get authHaveAccount => 'Already have an account?';

  @override
  String get authCreateLink => 'Create account';

  @override
  String get authSignInLink => 'Sign in';

  @override
  String get authErrEmail => 'Enter a valid email address';

  @override
  String get authErrPassword =>
      'Use at least 8 characters with letters and numbers';

  @override
  String get authErrPasswordEmpty => 'Enter your password';

  @override
  String get authErrName => 'Enter your name';

  @override
  String get authErrWrong =>
      'Email or password doesn\'t match the account on this device.';

  @override
  String get authErrNoAccount =>
      'There\'s no account on this device yet. Create one to begin.';

  @override
  String get authErrExists =>
      'This device already has an account. Sign in instead.';

  @override
  String get authErrPasswordRequired =>
      'The account on this device is protected by a password. Sign in with your email and password.';

  @override
  String get authResetTitle => 'Reset password';

  @override
  String get authResetBody =>
      'Taqaddum keeps your account only on this device, so there is no email recovery link. If you can\'t remember your password, you can erase this device\'s account and start fresh.';

  @override
  String get authResetWarning =>
      'Erasing permanently deletes every goal, log and review stored on this device.';

  @override
  String get authResetConfirmLabel => 'Type ERASE to confirm';

  @override
  String get authResetKeyword => 'ERASE';

  @override
  String get authResetButton => 'Erase and start fresh';

  @override
  String get authResetDone =>
      'The device account was erased. Create a new account to begin.';

  @override
  String get authDeviceTitle => 'Continue on this device';

  @override
  String get authDeviceBody =>
      'Use Taqaddum without an email or password. Everything stays private on this phone, and you can add a password later in Settings.';

  @override
  String get authDeviceNameLabel => 'What should we call you?';

  @override
  String get authDeviceButton => 'Start';

  @override
  String get authTermsTitle => 'Terms';

  @override
  String get authTermsP1 =>
      'Taqaddum is a personal planning tool. It helps you plan your days, log progress and reflect. It does not give medical, financial or religious rulings.';

  @override
  String get authTermsP2 =>
      'Your records are stored only on this device. You are responsible for exporting a copy if you want a backup, because uninstalling the app removes local data.';

  @override
  String get authTermsP3 =>
      'The app is provided as-is. Use it in a way that supports your wellbeing.';

  @override
  String get authPrivacyTitle => 'Privacy Policy';

  @override
  String get authPrivacyP1 =>
      'Taqaddum works completely offline. No account data, goals, logs, reviews or finances are sent to any server.';

  @override
  String get authPrivacyP2 =>
      'Your password is never stored. Only a salted cryptographic hash is kept in the device\'s secure storage.';

  @override
  String get authPrivacyP3 =>
      'There is no analytics or tracking. Exports are created only when you ask for them and shared only where you choose.';

  @override
  String onbStep(int step, int total) {
    return 'Step $step of $total';
  }

  @override
  String get onbAreasTitle => 'What would you like\nto improve?';

  @override
  String get onbAreasSubtitle => 'Choose what matters most right now.';

  @override
  String get onbAreaQuran => 'Quran & Faith';

  @override
  String get onbAreaWork => 'Work';

  @override
  String get onbAreaFinance => 'Money';

  @override
  String get onbAreaHealth => 'Health';

  @override
  String get onbAreaLearning => 'Learning';

  @override
  String get onbAreaPersonal => 'Personal Life';

  @override
  String get onbAreaQuranHint => 'Consistency';

  @override
  String get onbAreaWorkHint => 'Stay focused';

  @override
  String get onbAreaFinanceHint => 'Track & save';

  @override
  String get onbAreaHealthHint => 'Feel stronger';

  @override
  String get onbAreaLearningHint => 'Keep growing';

  @override
  String get onbAreaPersonalHint => 'Find balance';

  @override
  String get onbAreasError => 'Choose at least one area to continue.';

  @override
  String get onbTargetsTitle => 'What are your main goals?';

  @override
  String get onbTargetsSubtitle =>
      'Select starting targets to set up your momentum. They become daily habits you can check off.';

  @override
  String get onbAddCustom => 'Add custom target';

  @override
  String get onbCustomTitle => 'Custom target';

  @override
  String get onbCustomHint => 'e.g. Drink 8 glasses of water';

  @override
  String get onbCustomArea => 'Area';

  @override
  String get onbCustomAdd => 'Add target';

  @override
  String get onbTargetQuran1 => 'Read 1 Hizb daily';

  @override
  String get onbTargetQuran2 => 'Memorization practice';

  @override
  String get onbTargetQuran3 => 'Daily morning Adhkar';

  @override
  String get onbTargetWork1 => '4 hours deep work';

  @override
  String get onbTargetWork2 => 'Daily follow-ups';

  @override
  String get onbTargetFinance1 => 'Log expenses every evening';

  @override
  String get onbTargetFinance2 => 'Set aside savings';

  @override
  String get onbTargetHealth1 => 'Walk 8,000 steps';

  @override
  String get onbTargetHealth2 => 'Sleep before 11 PM';

  @override
  String get onbTargetLearning1 => 'Study 30 minutes';

  @override
  String get onbTargetLearning2 => 'Read 10 pages';

  @override
  String get onbTargetPersonal1 => 'Quality family time';

  @override
  String get onbTargetPersonal2 => 'Call a relative';

  @override
  String get onbPaceTitle => 'How should your day feel?';

  @override
  String get onbPaceSubtitle =>
      'Pick your daily pace. Taqaddum adapts to your lifestyle.';

  @override
  String get paceMorning => 'Morning Focus';

  @override
  String get paceMorningHint =>
      'High impact goals done early before distractions';

  @override
  String get paceBalanced => 'Balanced Day';

  @override
  String get paceBalancedHint =>
      'Evenly spaced commitments with restful pauses';

  @override
  String get paceAdaptive => 'Adaptive & Flexible';

  @override
  String get paceAdaptiveHint =>
      'Fluid schedule that shifts cleanly with demands';

  @override
  String get onbCheckpoints => 'Daily checkpoints';

  @override
  String get onbMorningCheckpoint => 'Morning intention';

  @override
  String get onbEveningCheckpoint => 'Evening reflection';

  @override
  String get onbCheckpointHint =>
      'Tap the time to change it. You can edit reminders later.';

  @override
  String get onbReadyTitle => 'You\'re ready to begin';

  @override
  String get onbReadySubtitle =>
      'Your daily system is set to connect habits to purpose.';

  @override
  String get onbFocusAreas => 'Focus areas';

  @override
  String get onbFirstTargets => 'First day targets';

  @override
  String get onbNoTargets =>
      'No starting targets selected. You can add habits anytime.';

  @override
  String get onbDailyPace => 'Daily pace:';

  @override
  String get onbReadyNote =>
      'Small steady steps compound into a remarkable life.';

  @override
  String get onbFinish => 'Set up my first goal';

  @override
  String get goalSetupHeader => 'Set up your goals';

  @override
  String get goalNewTitle => 'New goal';

  @override
  String get goalEditTitle => 'Edit goal';

  @override
  String goalSetupCounter(int n, int total) {
    return 'Goal $n of $total';
  }

  @override
  String goalSetupPercent(int pct) {
    return '$pct% setup';
  }

  @override
  String get goalSetupHeadline => 'Make your goal measurable';

  @override
  String get goalSetupSub =>
      'Clear goals are easier to follow and steadily improve.';

  @override
  String get goalTitleLabel => 'Goal title';

  @override
  String get goalTitleHint => 'e.g. Save 600,000 DZD';

  @override
  String get goalCategory => 'Category';

  @override
  String get goalType => 'Goal type';

  @override
  String get goalTypeTarget => 'Target';

  @override
  String get goalTypeRoutine => 'Routine';

  @override
  String get goalTypeMilestone => 'Milestone';

  @override
  String get goalTypeTargetHint =>
      'Reach a number, like pages, hours or savings.';

  @override
  String get goalTypeRoutineHint =>
      'Repeat something a number of times every day, week or month.';

  @override
  String get goalTypeMilestoneHint => 'Complete a series of checkpoints.';

  @override
  String get goalTargetUnit => 'Target & unit';

  @override
  String get goalUnit => 'Unit';

  @override
  String get goalUnitCustom => 'Custom unit';

  @override
  String get goalUnitCustomHint => 'e.g. books';

  @override
  String get goalStartingPoint => 'Starting point';

  @override
  String get goalStartingPointHint => 'How much you already have';

  @override
  String goalAccumulated(Object pct) {
    return '$pct accumulated';
  }

  @override
  String goalRemaining(Object value) {
    return '$value remaining';
  }

  @override
  String get goalRoutineTimes => 'Times per period';

  @override
  String get goalRoutineEvery => 'Repeats';

  @override
  String get goalTargetDate => 'Target date';

  @override
  String get goalNoDate => 'Choose a date';

  @override
  String get goalClearDate => 'Remove date';

  @override
  String goalYearsLeft(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n yrs left',
      one: '1 yr left',
    );
    return '$_temp0';
  }

  @override
  String goalMonthsLeft(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n months left',
      one: '1 month left',
    );
    return '$_temp0';
  }

  @override
  String goalDaysLeft(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n days left',
      one: '1 day left',
    );
    return '$_temp0';
  }

  @override
  String get goalPastDate => 'Date passed';

  @override
  String get goalWhy => 'Why does this matter?';

  @override
  String get goalWhyHint => 'The reason you\'ll remember on hard days.';

  @override
  String get goalActionsTitle => 'Actions that move this goal forward';

  @override
  String get goalActionsSubtitle =>
      'Daily or recurring steps connected to this goal.';

  @override
  String get goalAddAction => 'Add action';

  @override
  String get goalEditAction => 'Edit action';

  @override
  String get goalActionTitle => 'Action';

  @override
  String get goalActionTitleHint => 'e.g. Save monthly from income';

  @override
  String get goalActionDetail => 'Detail';

  @override
  String get goalActionDetailHint => 'e.g. 20,000 DZD every month';

  @override
  String get goalFrequency => 'Frequency';

  @override
  String get freqDaily => 'Daily';

  @override
  String get freqWeekly => 'Weekly';

  @override
  String get freqMonthly => 'Monthly';

  @override
  String get freqOnce => 'Once';

  @override
  String get goalMilestonesTitle => 'Milestones';

  @override
  String get goalMilestonesSubtitle =>
      'Progress is the share of milestones completed.';

  @override
  String get goalAddMilestone => 'Add milestone';

  @override
  String get goalMilestoneHint => 'Milestone title';

  @override
  String get goalTrajectoryTitle => 'Pace needed';

  @override
  String goalTrajectoryBody(Object amount, Object date) {
    return 'To reach your target by $date, aim for about $amount per month.';
  }

  @override
  String get goalTrajectoryDone =>
      'Your starting point already meets this target.';

  @override
  String get goalTrajectoryNoDate =>
      'Add a target date to see the pace you need.';

  @override
  String goalRoutineSummary(Object count, Object period) {
    return '$count × $period';
  }

  @override
  String get goalErrTitle => 'Give your goal a title';

  @override
  String get goalErrTarget => 'Enter a target above the starting point';

  @override
  String get goalErrMilestones => 'Add at least one milestone';

  @override
  String get goalSaveContinue => 'Save & Continue';

  @override
  String get goalSave => 'Save goal';

  @override
  String get goalFinishSetup => 'Finish setup';

  @override
  String get goalSavedNext => 'Goal saved. Add another or finish setup.';

  @override
  String get goalMakePrimary => 'Make this my primary focus';

  @override
  String get langTitle => 'Language';

  @override
  String get langEnglish => 'English';

  @override
  String get langArabic => 'العربية (Arabic)';

  @override
  String get langFrench => 'Français (French)';

  @override
  String get langComingSoon => 'Coming in a future update';

  @override
  String get langFootnote =>
      'Taqaddum is fully available in English today. Arabic (right-to-left) and French translations are being prepared.';

  @override
  String todayGreetingMorning(Object name) {
    return 'Good morning, $name';
  }

  @override
  String todayGreetingAfternoon(Object name) {
    return 'Good afternoon, $name';
  }

  @override
  String todayGreetingEvening(Object name) {
    return 'Good evening, $name';
  }

  @override
  String get todayNotifications => 'Notifications';

  @override
  String get todayProfile => 'Profile';

  @override
  String get todayMomentum => 'Today\'s Momentum';

  @override
  String todayVsYesterday(Object delta) {
    return '$delta vs yesterday';
  }

  @override
  String get todayComplete => 'complete';

  @override
  String todayActionsCompleted(int done, int total) {
    return '$done of $total actions completed';
  }

  @override
  String todayActionsLeft(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count actions left',
      one: '1 action left',
      zero: 'All done',
    );
    return '$_temp0';
  }

  @override
  String get todayEmptyTitle => 'Plan your day';

  @override
  String get todayEmptyBody =>
      'Add a few actions for today, or start with a one-minute morning check-in.';

  @override
  String get todayCheckInTitle => 'Morning check-in';

  @override
  String get todayCheckInBody =>
      'Set your energy and choose today\'s 3 priorities.';

  @override
  String get todayCheckInCta => 'Start';

  @override
  String get todayNightTitle => 'Night review';

  @override
  String get todayNightBody => 'Close the day with three quiet questions.';

  @override
  String get todayNightCta => 'Review';

  @override
  String get todayFocus => 'Today\'s Focus';

  @override
  String todayPriorities(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Priorities',
      one: '1 Priority',
    );
    return '$_temp0';
  }

  @override
  String get todayNoPriorities =>
      'No priorities chosen yet. Pick up to three that matter most.';

  @override
  String get todayChoosePriorities => 'Choose priorities';

  @override
  String get todayActions => 'Today\'s Actions';

  @override
  String todayCompletedOf(int done, int total) {
    return '$done of $total completed';
  }

  @override
  String get todayAddAction => 'Add action for today';

  @override
  String get todayViewPlan => 'View full plan';

  @override
  String todayMoreActions(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '+$count more actions',
      one: '+1 more action',
    );
    return '$_temp0';
  }

  @override
  String get todayYourProgress => 'Your Progress';

  @override
  String get todayKeyAreas => 'Key life areas';

  @override
  String get todayNoGoals =>
      'Create a goal to see progress across your key life areas.';

  @override
  String get todayCreateGoal => 'Create a goal';

  @override
  String get todayInsightTitle => 'Momentum pattern';

  @override
  String todayInsightArea(String area, int days, int total) {
    return 'Your $area consistency is strongest this week, active $days of $total days.';
  }

  @override
  String todayInsightStrongDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count strong days so far this week. Keep the rhythm going.',
      one: '1 strong day so far this week. Keep the rhythm going.',
    );
    return '$_temp0';
  }

  @override
  String get taskNew => 'New action';

  @override
  String get taskEdit => 'Edit action';

  @override
  String get taskTitle => 'What needs to be done?';

  @override
  String get taskTitleHint => 'e.g. Prepare client proposal';

  @override
  String get taskArea => 'Category';

  @override
  String get taskSchedule => 'Schedule';

  @override
  String get taskPickDate => 'Date…';

  @override
  String get taskTime => 'Time';

  @override
  String get taskAnytime => 'Anytime';

  @override
  String get taskDuration => 'Duration';

  @override
  String get taskNoDuration => 'None';

  @override
  String get taskGoal => 'Related goal';

  @override
  String get taskNoGoal => 'No goal';

  @override
  String get taskDetail => 'Detail';

  @override
  String get taskDetailHint => 'e.g. Surah An-Nur or 5 leads';

  @override
  String get taskAdd => 'Add action';

  @override
  String get taskSave => 'Save changes';

  @override
  String get taskMarkDone => 'Mark as done';

  @override
  String get taskMarkUndone => 'Mark as not done';

  @override
  String get taskReschedule => 'Reschedule';

  @override
  String get taskMakePriority => 'Make a priority';

  @override
  String get taskRemovePriority => 'Remove from priorities';

  @override
  String get taskDelete => 'Delete action';

  @override
  String get taskDeleteTitle => 'Delete this action?';

  @override
  String get taskDeleteBody =>
      'The action and its activity entry will be removed from this device.';

  @override
  String get taskDeleted => 'Action deleted';

  @override
  String get taskPriorityFull =>
      'You already have 3 priorities. Remove one first.';

  @override
  String get taskAdded => 'Action added';

  @override
  String get rescheduleTitle => 'Reschedule';

  @override
  String get rescheduleSubtitle => 'Move this action without pressure.';

  @override
  String get rescheduleLaterToday => 'Later today';

  @override
  String get rescheduleTomorrow => 'Tomorrow';

  @override
  String get rescheduleNextWeek => 'Next week';

  @override
  String get reschedulePick => 'Pick a date';

  @override
  String get rescheduleKeepTime => 'Keep time';

  @override
  String get rescheduleConfirm => 'Move action';

  @override
  String rescheduledTo(Object date) {
    return 'Moved to $date';
  }

  @override
  String get planTitleToday => 'Today';

  @override
  String get planCalendar => 'Pick a day';

  @override
  String get planMore => 'More options';

  @override
  String planCompleted(int done, int total) {
    return '$done of $total completed';
  }

  @override
  String planPlanned(Object time) {
    return '$time planned';
  }

  @override
  String get planLoadLight => 'Today\'s load looks light.';

  @override
  String get planLoadBalanced => 'Today\'s load looks balanced.';

  @override
  String get planLoadHeavy =>
      'Today\'s load looks heavy. Consider moving something.';

  @override
  String get capacityLight => 'Light day';

  @override
  String get capacityBalanced => 'Balanced day';

  @override
  String get capacityFocused => 'Focused day';

  @override
  String get capacityLightHint => 'Keep things simple';

  @override
  String get capacityBalancedHint => 'Normal pace';

  @override
  String get capacityFocusedHint => 'More deep work';

  @override
  String get planTopPriorities => 'Top priorities';

  @override
  String get planReorder => 'Reorder';

  @override
  String get planDoneReorder => 'Done';

  @override
  String get planMorning => 'Morning';

  @override
  String get planAfternoon => 'Afternoon';

  @override
  String get planEvening => 'Evening';

  @override
  String get planAnytime => 'Anytime';

  @override
  String planSectionCount(String label, int count) {
    return '$label · $count';
  }

  @override
  String planDoneCount(int count) {
    return '$count done';
  }

  @override
  String get planAddAction => 'Add action for this day';

  @override
  String get planAllSet => 'All set. Reschedule or shift actions anytime.';

  @override
  String get planAllDone => 'Everything planned for this day is done.';

  @override
  String get planEmptyTitle => 'Nothing planned yet';

  @override
  String get planEmptyBody =>
      'Add an action or start a morning check-in to shape the day.';

  @override
  String get planMoveUnfinished => 'Move unfinished to tomorrow';

  @override
  String planMovedCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count actions moved to tomorrow',
      one: '1 action moved to tomorrow',
    );
    return '$_temp0';
  }

  @override
  String get planClearCompleted => 'Hide completed';

  @override
  String get planShowCompleted => 'Show completed';

  @override
  String get planPastDay =>
      'This day has passed. You can still complete or move actions.';

  @override
  String get checkInHint => 'Takes less than a minute';

  @override
  String get checkInTitle => 'Morning check-in';

  @override
  String checkInHeadline(Object name) {
    return 'Good morning, $name';
  }

  @override
  String get checkInSub => 'Let\'s set the tone for today.';

  @override
  String get checkInEnergy => 'How\'s your energy?';

  @override
  String get checkInEnergyHint => 'Honest baseline';

  @override
  String get energyLow => 'Low';

  @override
  String get energySteady => 'Steady';

  @override
  String get energyHigh => 'High';

  @override
  String get checkInPriorities => 'What matters most today?';

  @override
  String get checkInPrioritiesHint => 'Choose up to 3 priorities.';

  @override
  String checkInSelected(int count) {
    return '$count of 3';
  }

  @override
  String get checkInAddCustom => 'Add custom priority';

  @override
  String get checkInCustomTitle => 'Custom priority';

  @override
  String get checkInCustomHint => 'e.g. Finish client proposal';

  @override
  String get checkInNoTasks =>
      'No actions planned for today yet. Add a custom priority to begin.';

  @override
  String get checkInCapacity => 'How much can you realistically take on?';

  @override
  String get checkInCapacityHint => 'Calibrate your daily expectation.';

  @override
  String get checkInIntention => 'Daily intention';

  @override
  String get checkInIntentionHint =>
      'Stay focused and avoid unnecessary meetings.';

  @override
  String get checkInStart => 'Start My Day';

  @override
  String get checkInSkip => 'Skip for today';

  @override
  String get checkInMax => 'You can choose up to 3 priorities.';

  @override
  String get nightTitle => 'Night review';

  @override
  String get nightBadge => '2 min wrap-up';

  @override
  String get nightHeadline => 'How did today feel?';

  @override
  String get nightSub =>
      'Take a brief pause to close your day with clear intention.';

  @override
  String get nightRating => 'How was your day?';

  @override
  String get nightHard => '1 Hard';

  @override
  String get nightOkay => '3 Okay';

  @override
  String get nightGreat => '5 Great';

  @override
  String get nightSummary => 'Today\'s summary';

  @override
  String nightPercent(int pct) {
    return '$pct% Complete';
  }

  @override
  String nightActions(int done, int total) {
    return '$done of $total actions';
  }

  @override
  String nightRemaining(int count) {
    return '$count remaining';
  }

  @override
  String get nightNoPlan =>
      'No actions were planned today. Your logs still count.';

  @override
  String get nightToneStrong => 'A strong day. Well done showing up.';

  @override
  String get nightToneSteady =>
      'A solid day. Steady forward momentum for tomorrow.';

  @override
  String get nightToneLight => 'A lighter day. Tomorrow is a fresh start.';

  @override
  String get nightWentWell => 'What went well?';

  @override
  String get nightWentWellHint => 'Optional reflection notes…';

  @override
  String get nightBetter => 'What could be better tomorrow?';

  @override
  String get nightBetterHint => 'What small tweak helps tomorrow?';

  @override
  String get tagFocused => 'Focused';

  @override
  String get tagGoodEnergy => 'Good energy';

  @override
  String get tagQuranDone => 'Quran done';

  @override
  String get tagProgressWork => 'Progress at work';

  @override
  String get tagMoved => 'Moved my body';

  @override
  String get tagFamily => 'Family time';

  @override
  String get tagDistracted => 'Distracted';

  @override
  String get tagOverplanned => 'Overplanned';

  @override
  String get tagLateStart => 'Late start';

  @override
  String get tagMissedWorkout => 'Missed workout';

  @override
  String get tagTired => 'Tired';

  @override
  String get tagTooManyMeetings => 'Too many meetings';

  @override
  String get nightUnfinished => 'Unfinished actions';

  @override
  String get nightUnfinishedHint =>
      'Shift to tomorrow or reschedule without pressure.';

  @override
  String get nightMoveTomorrow => 'Tomorrow';

  @override
  String get nightMoving => 'Moving';

  @override
  String get nightAllDone => 'Everything planned today is done.';

  @override
  String get nightTomorrow => 'Tomorrow at a glance';

  @override
  String get nightTomorrowEmpty => 'Nothing scheduled for tomorrow yet.';

  @override
  String nightTomorrowReady(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count actions ready for tomorrow',
      one: '1 action ready for tomorrow',
    );
    return '$_temp0';
  }

  @override
  String get nightComplete => 'Complete Day';

  @override
  String get nightSkip => 'Skip review for now';

  @override
  String get nightSaved => 'Day closed. Rest well.';

  @override
  String get nightAlreadyDone =>
      'You reviewed this day. Saving again will update it.';

  @override
  String get quickAddTitle => 'Quick Add';

  @override
  String get quickAddSubtitle => 'Add something without leaving your flow.';

  @override
  String get quickTask => 'Task';

  @override
  String get quickTaskHint => 'Add something to do';

  @override
  String get quickQuran => 'Quran';

  @override
  String get quickQuranHint => 'Log today\'s progress';

  @override
  String get quickMoney => 'Money';

  @override
  String get quickMoneyHint => 'Income or expense';

  @override
  String get quickWork => 'Work';

  @override
  String get quickWorkHint => 'Lead, meeting or call';

  @override
  String get quickHabit => 'Habit';

  @override
  String get quickHabitHint => 'Build consistency';

  @override
  String get quickNote => 'Note';

  @override
  String get quickNoteHint => 'Capture quickly';

  @override
  String get quickSuggested => 'Suggested actions';

  @override
  String quickSuggestQuran(int pages) {
    return 'Log $pages Quran pages';
  }

  @override
  String get quickSuggestExpense => 'Add expense';

  @override
  String get quickSuggestLeads => 'Contact leads';

  @override
  String get quickSuggestNightReview => 'Night review';

  @override
  String get quickSuggestCheckIn => 'Morning check-in';

  @override
  String get noteTitle => 'Quick note';

  @override
  String get noteHint => 'What\'s on your mind?';

  @override
  String get noteArea => 'Area';

  @override
  String get noteSave => 'Save note';

  @override
  String get noteSaved => 'Note saved';

  @override
  String get loggedToast => 'Logged';

  @override
  String get quranLogTitle => 'Log Quran';

  @override
  String get quranReading => 'Reading';

  @override
  String get quranMemorization => 'Memorization';

  @override
  String get quranRevision => 'Revision';

  @override
  String get quranSurah => 'Surah';

  @override
  String get quranPickSurah => 'Choose a surah';

  @override
  String get quranPagesRead => 'Pages read';

  @override
  String get quranPagesMemorized => 'Pages memorized';

  @override
  String get quranPagesRevised => 'Pages revised';

  @override
  String get quranMinutes => 'Minutes';

  @override
  String get quranPortion => 'Portion';

  @override
  String get quranPortionHint => 'e.g. Pages 18–21';

  @override
  String quranApproxMinutes(int minutes) {
    return 'About $minutes minutes';
  }

  @override
  String get quranSaveReading => 'Save reading';

  @override
  String get quranSaveMemorization => 'Save memorization';

  @override
  String get quranSaveRevision => 'Save revision';

  @override
  String get moneyTitle => 'Add transaction';

  @override
  String get moneyExpense => 'Expense';

  @override
  String get moneyIncome => 'Income';

  @override
  String get moneySaving => 'Saving';

  @override
  String get moneyAmount => 'Amount';

  @override
  String get moneyAmountError => 'Enter an amount above zero';

  @override
  String get moneyCategory => 'Category';

  @override
  String get moneyOther => 'Other…';

  @override
  String get moneyCustomCategory => 'Custom category';

  @override
  String get moneyCustomHint => 'e.g. Car repair';

  @override
  String get moneyTag => 'Type';

  @override
  String get moneyPersonal => 'Personal';

  @override
  String get moneyBusiness => 'Business';

  @override
  String get moneyNote => 'Note';

  @override
  String get moneyDate => 'Date';

  @override
  String get moneySave => 'Add transaction';

  @override
  String get catFood => 'Food';

  @override
  String get catTransport => 'Transport';

  @override
  String get catHome => 'Home';

  @override
  String get catBills => 'Bills';

  @override
  String get catFamily => 'Family';

  @override
  String get catHealth => 'Health';

  @override
  String get catEducation => 'Education';

  @override
  String get catBusiness => 'Business';

  @override
  String get catShopping => 'Shopping';

  @override
  String get catSalary => 'Salary';

  @override
  String get catClientPayment => 'Client payment';

  @override
  String get catFreelance => 'Freelance';

  @override
  String get catGift => 'Gift';

  @override
  String get catEmergency => 'Emergency fund';

  @override
  String get catSavingsGoal => 'Savings goal';

  @override
  String get catInvestment => 'Investment';

  @override
  String get workLogTitle => 'Log work';

  @override
  String get workDeepWork => 'Deep work';

  @override
  String get workLead => 'Lead';

  @override
  String get workFollowUp => 'Follow-up';

  @override
  String get workMeeting => 'Meeting';

  @override
  String get workProposal => 'Proposal';

  @override
  String get workClientWon => 'Client won';

  @override
  String get workTitle => 'Title';

  @override
  String get workTitleDeepHint => 'e.g. Client proposal';

  @override
  String get workTitleLeadHint => 'e.g. ERP system overhaul';

  @override
  String get workTitleFollowHint => 'e.g. Send revised quote';

  @override
  String get workTitleMeetingHint => 'e.g. Website + CRM presentation';

  @override
  String get workTitleProposalHint => 'e.g. Stock management sync';

  @override
  String get workTitleWonHint => 'e.g. Annual support contract';

  @override
  String get workCounterpart => 'Client or company';

  @override
  String get workCounterpartHint => 'e.g. Atlas Construction';

  @override
  String get workDuration => 'Duration';

  @override
  String get workValue => 'Deal value';

  @override
  String get workWhen => 'When';

  @override
  String get workNow => 'Now';

  @override
  String get workSave => 'Save';

  @override
  String get habitQuickTitle => 'Habits today';

  @override
  String get habitNew => 'New habit';

  @override
  String get habitName => 'Habit';

  @override
  String get habitNameHint => 'e.g. Walk 8,000 steps';

  @override
  String get habitArea => 'Area';

  @override
  String get habitReminder => 'Reminder';

  @override
  String get habitNoReminder => 'No reminder';

  @override
  String get habitAdd => 'Add habit';

  @override
  String get habitEmpty =>
      'No habits yet. Add one to build steady consistency.';

  @override
  String habitDoneCount(int done, int total) {
    return '$done of $total done today';
  }

  @override
  String commonDaysAgo(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n days ago',
      one: 'yesterday',
      zero: 'today',
    );
    return '$_temp0';
  }

  @override
  String get commonHistory => 'History';

  @override
  String get commonShowMore => 'Show more';

  @override
  String get commonShowLess => 'Show less';

  @override
  String get commonTargets => 'Daily targets';

  @override
  String get commonDeleteEntry => 'Delete entry';

  @override
  String get commonDeleteEntryBody =>
      'This removes the entry and any goal progress it added.';

  @override
  String commonTodayAt(Object time) {
    return 'Today · $time';
  }

  @override
  String commonYesterdayAt(Object time) {
    return 'Yesterday · $time';
  }

  @override
  String commonDateAt(Object date, Object time) {
    return '$date · $time';
  }

  @override
  String goalMiniMilestones(int done, int total) {
    return '$done of $total milestones completed';
  }

  @override
  String goalMiniRoutineDay(int done, int total) {
    return '$done of $total today';
  }

  @override
  String goalMiniRoutineWeek(int done, int total) {
    return '$done of $total this week';
  }

  @override
  String goalMiniRoutineMonth(int done, int total) {
    return '$done of $total this month';
  }

  @override
  String goalTargetOn(Object date) {
    return 'Target: $date';
  }

  @override
  String get goalAddForArea => 'Add a goal';

  @override
  String get goalAddForAreaBody =>
      'Link a goal to this area and your logs will move it forward automatically.';

  @override
  String get quranTitle => 'Quran';

  @override
  String get quranSubtitle => 'Reading, memorization, and revision.';

  @override
  String get quranDailyRoutine => 'Daily routine';

  @override
  String quranRoutineDone(int done, int total) {
    return '$done of $total completed';
  }

  @override
  String quranPagesOf(Object done, Object target) {
    return '$done / $target pages';
  }

  @override
  String quranPageOf(Object done, Object target) {
    return '$done / $target page';
  }

  @override
  String quranMinutesOf(Object done, Object target) {
    return '$done / $target min';
  }

  @override
  String get quranLogProgress => 'Log progress';

  @override
  String get quranCurrentMemo => 'Current memorization';

  @override
  String quranSurahBadge(int n) {
    return 'Surah $n';
  }

  @override
  String quranPagesOfSurah(Object done, Object total) {
    return '$done of $total pages';
  }

  @override
  String quranNextStep(Object amount) {
    return 'Next · $amount page';
  }

  @override
  String get quranContinue => 'Continue';

  @override
  String get quranNoMemoTitle => 'No memorization yet';

  @override
  String get quranNoMemoBody =>
      'Log a memorization session to follow your current surah here.';

  @override
  String get quranStartMemo => 'Log memorization';

  @override
  String get quranGoal => 'Quran goal';

  @override
  String get quranRevisionTitle => 'Revision';

  @override
  String get quranActiveSchedule => 'Active schedule';

  @override
  String quranLastReviewed(Object when) {
    return 'Last reviewed $when';
  }

  @override
  String get quranReviewToday => 'Review today';

  @override
  String get quranStrong => 'Strong';

  @override
  String get quranNoRevision =>
      'Portions you memorize or revise will appear here with a gentle review schedule.';

  @override
  String get quranConsistency => 'Consistency';

  @override
  String quranConsistencyCount(int active, int days) {
    return '$active of last $days days';
  }

  @override
  String get quranConsistencyHint =>
      'Steady forward movement over rigid streaks.';

  @override
  String get quranNoteStart => 'Log a single page to start your rhythm.';

  @override
  String get quranNoteReturned =>
      'Consistency is building. You returned after missing one day.';

  @override
  String quranNoteStreak(int n) {
    return '$n days in a row. Keep it gentle and steady.';
  }

  @override
  String get quranNoteSteady =>
      'Every return counts. Pick up with a single page today.';

  @override
  String get quranThisWeek => 'This week';

  @override
  String get quranRead => 'Read';

  @override
  String get quranMemorized => 'Memorized';

  @override
  String get quranRevised => 'Revised';

  @override
  String get quranUnitPages => 'pages';

  @override
  String get quranUnitMinutes => 'minutes';

  @override
  String get quranRecent => 'Recent activity';

  @override
  String quranReadN(Object pages) {
    return 'Read $pages pages';
  }

  @override
  String quranMemorizedN(Object pages) {
    return 'Memorized $pages page';
  }

  @override
  String quranRevisedN(int minutes) {
    return 'Revised $minutes min';
  }

  @override
  String get quranEmptyTitle => 'Start with a single page';

  @override
  String get quranEmptyBody =>
      'Log your first reading, memorization, or revision to see your rhythm here.';

  @override
  String get quranTargetReading => 'Reading (pages per day)';

  @override
  String get quranTargetMemo => 'Memorization (pages per day)';

  @override
  String get quranTargetRevision => 'Revision (minutes per day)';

  @override
  String get workScreenTitle => 'Work';

  @override
  String get workScreenSubtitle => 'Focus, sales, and business progress.';

  @override
  String get workTargetAchieved => 'Target achieved';

  @override
  String get workTargetBanner =>
      'You\'ve completed your deep work target for today.';

  @override
  String get workMomentum => 'Today\'s momentum';

  @override
  String get workDeepFocus => 'Deep work focus';

  @override
  String get workLeads => 'Leads';

  @override
  String get workFollowUps => 'Follow-ups';

  @override
  String get workMeetings => 'Meetings';

  @override
  String get workProposals => 'Proposals';

  @override
  String workPlanned(int n) {
    return '$n planned';
  }

  @override
  String get workQuickActions => 'Quick actions';

  @override
  String get workLogDeep => 'Log deep work';

  @override
  String get workAddLead => 'Add lead';

  @override
  String get workAddFollowUp => 'Add follow-up';

  @override
  String get workAddMeeting => 'Add meeting';

  @override
  String get workFocus => 'Focus';

  @override
  String workLogged(Object time) {
    return '$time logged';
  }

  @override
  String get workAllLogs => 'All logs';

  @override
  String get workNoFocus =>
      'No deep work logged today. One focused block moves the needle.';

  @override
  String get workSales => 'Sales activity';

  @override
  String get workOutreach => 'Outreach';

  @override
  String get workCadence => 'Cadence';

  @override
  String get workBooked => 'Booked';

  @override
  String get workSent => 'Sent';

  @override
  String workWon(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n clients won',
      one: '1 client won',
    );
    return '$_temp0';
  }

  @override
  String workWonWeek(Object won) {
    return '$won this week';
  }

  @override
  String workWonMonth(Object won) {
    return '$won this month';
  }

  @override
  String get workActiveLeads => 'Active leads';

  @override
  String get workStageLead => 'Contacted';

  @override
  String get workStageFollowUp => 'Following up';

  @override
  String get workStageMeeting => 'Meeting';

  @override
  String get workStageProposal => 'Proposal sent';

  @override
  String workNext(Object what) {
    return 'Next: $what';
  }

  @override
  String get workNextNone => 'Next: plan a follow-up';

  @override
  String get workNoLeads =>
      'Leads you log with a client or company name build your pipeline here.';

  @override
  String get workNextMeetings => 'Next meetings';

  @override
  String workUpcoming(int n) {
    return '$n upcoming';
  }

  @override
  String get workNoMeetings =>
      'No meetings scheduled. Add one when a conversation is ready.';

  @override
  String get workBusinessGoals => 'Business goals';

  @override
  String get workInsightTitle => 'Weekly sales pattern';

  @override
  String get workInsightFollowUps =>
      'Follow-ups are turning into meetings this week. Keep nurturing existing conversations.';

  @override
  String get workInsightLeads =>
      'You\'ve opened new conversations this week. A short follow-up keeps them warm.';

  @override
  String get workInsightDeep =>
      'Deep work is carrying your week. Protect one outreach block to keep the pipeline moving.';

  @override
  String get workMarkWon => 'Mark client won';

  @override
  String get workTargetDeep => 'Deep work (minutes per day)';

  @override
  String get workTargetLeads => 'Leads per day';

  @override
  String get workTargetFollowUps => 'Follow-ups per day';

  @override
  String get financeTitle => 'Finance';

  @override
  String get financeSubtitle => 'Personal financial awareness and progress.';

  @override
  String financeExpensesLower(Object pct) {
    return 'Your expenses are $pct lower than this time last month.';
  }

  @override
  String financeExpensesHigher(Object pct) {
    return 'Your expenses are $pct higher than this time last month.';
  }

  @override
  String get financeNet => 'Net savings & surplus';

  @override
  String get financeNetCaption => 'Income after expenses and savings allocated';

  @override
  String get financeLastMonth => 'Last month';

  @override
  String get financeThisYear => 'Year';

  @override
  String get financeIncome => 'Income';

  @override
  String get financeExpenses => 'Expenses';

  @override
  String get financeSavings => 'Savings';

  @override
  String financeSavingsRate(Object pct) {
    return '$pct savings rate';
  }

  @override
  String get financeQuickActions => 'Quick actions';

  @override
  String get financeCashFlow => 'Cash flow';

  @override
  String get financeInflow => 'Inflow';

  @override
  String get financeOutflow => 'Outflow';

  @override
  String get financeSpending => 'Spending';

  @override
  String financeTotal(Object amount) {
    return '$amount total';
  }

  @override
  String financeTxCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n transactions',
      one: '1 transaction',
    );
    return '$_temp0';
  }

  @override
  String get financeNoSpending => 'No expenses in this period.';

  @override
  String get financeSavingsGoal => 'Savings goal';

  @override
  String financeRemaining(Object amount) {
    return '$amount remaining to target';
  }

  @override
  String get financeAddSaving => 'Add saving';

  @override
  String get financeRecent => 'Recent transactions';

  @override
  String get financeAll => 'All';

  @override
  String get financeViewAll => 'View all transactions';

  @override
  String get financeEmptyTitle => 'Your money picture starts here';

  @override
  String get financeEmptyBody =>
      'Add an income, expense, or saving to see your balance, spending, and cash flow.';

  @override
  String get financeNoMatches => 'No transactions of this type in this period.';

  @override
  String get healthTitle => 'Health & Habits';

  @override
  String get healthSubtitle => 'Movement, sleep, and daily consistency.';

  @override
  String healthSleepInsight(String time, int n) {
    return 'Your sleep averaged $time over the last $n nights.';
  }

  @override
  String get healthMovementToday => 'Movement today';

  @override
  String healthPctCompleted(Object pct) {
    return '$pct completed';
  }

  @override
  String healthMinRemaining(int n) {
    return '$n min remaining';
  }

  @override
  String get healthTargetMet => 'Target reached';

  @override
  String get healthWorkout => 'Workout';

  @override
  String get healthDone => 'Done';

  @override
  String get healthNotYet => 'Not yet';

  @override
  String get healthSleep => 'Sleep';

  @override
  String get healthHabits => 'Habits';

  @override
  String healthHabitsOf(int done, int total) {
    return '$done of $total';
  }

  @override
  String get healthLogWorkout => 'Log workout';

  @override
  String get healthLogWalk => 'Log walk';

  @override
  String get healthLogSleep => 'Log sleep';

  @override
  String get healthScheduledLogged => 'Logged this week';

  @override
  String get healthCompleted => 'Completed';

  @override
  String get healthNoWorkout =>
      'No workout logged this week. Even 20 minutes counts.';

  @override
  String get healthWalking => 'Walking';

  @override
  String healthTargetMin(int n) {
    return 'Target $n min';
  }

  @override
  String healthWalksToday(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n walks today',
      one: '1 walk today',
      zero: 'No walks yet today',
    );
    return '$_temp0';
  }

  @override
  String healthWalkRemaining(int n) {
    return '$n min remaining to reach daily movement.';
  }

  @override
  String get healthWalkDone => 'Daily movement reached. Nicely done.';

  @override
  String get healthSleepRhythm => 'Sleep health rhythm';

  @override
  String healthSleepTarget(Object time) {
    return '/ $time target';
  }

  @override
  String healthBelowTarget(Object time) {
    return '$time below target';
  }

  @override
  String get healthOnTarget => 'On target';

  @override
  String healthBedWake(Object bed, Object wake) {
    return 'Bed $bed · Wake $wake';
  }

  @override
  String healthEnergyToday(Object energy) {
    return 'Energy today: $energy';
  }

  @override
  String get healthNoSleep => 'Log last night\'s sleep to follow your rhythm.';

  @override
  String get healthDailyHabits => 'Daily habits';

  @override
  String healthHabitsCompleted(int done, int total) {
    return '$done of $total completed';
  }

  @override
  String get healthEditHabits => 'Edit';

  @override
  String get healthDoneEditing => 'Done';

  @override
  String get healthArchiveHabit => 'Remove habit';

  @override
  String get healthArchiveBody =>
      'The habit is hidden from your list. Past check-ins stay in your history.';

  @override
  String get healthRenameHabit => 'Rename habit';

  @override
  String get healthGoals => 'Health goals';

  @override
  String get healthWeeklyProgress => 'Weekly progress';

  @override
  String healthActiveDays(int n) {
    return '$n of 7 days active this week';
  }

  @override
  String get healthWeekNote =>
      'Movement, sleep, and habits all count. Returning after a missed day is progress.';

  @override
  String get workoutTitle => 'Log workout';

  @override
  String get workoutName => 'Workout';

  @override
  String get workoutNameHint => 'e.g. Strength training';

  @override
  String get workoutDetail => 'Detail';

  @override
  String get workoutDetailHint => 'e.g. Upper body & core';

  @override
  String get workoutDuration => 'Duration';

  @override
  String get walkTitle => 'Log walk';

  @override
  String get walkMinutes => 'Minutes walked';

  @override
  String get walkSteps => 'Steps';

  @override
  String get sleepTitle => 'Log sleep';

  @override
  String get sleepBed => 'Bedtime';

  @override
  String get sleepWake => 'Wake time';

  @override
  String sleepDuration(Object time) {
    return '$time of sleep';
  }

  @override
  String get sleepEnergy => 'How\'s your energy?';

  @override
  String get healthTargetWalk => 'Movement (minutes per day)';

  @override
  String get healthTargetSleep => 'Sleep (hours per night)';

  @override
  String get healthTargetWorkouts => 'Workouts per week';

  @override
  String get learnTitle => 'Learning';

  @override
  String get learnSubtitle => 'Skills, study, and real progress.';

  @override
  String get learnTargetBanner =>
      'You\'ve completed your daily study target for today.';

  @override
  String get learnStudyToday => 'Study today';

  @override
  String get learnSkill => 'Skill';

  @override
  String get learnSession => 'Session';

  @override
  String learnSessionDone(Object time) {
    return 'Done ($time)';
  }

  @override
  String get learnApplied => 'Applied';

  @override
  String learnActions(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n actions',
      one: '1 action',
    );
    return '$_temp0';
  }

  @override
  String get learnLogStudy => 'Log study';

  @override
  String get learnAddTakeaway => 'Add takeaway';

  @override
  String get learnNewAction => 'New action';

  @override
  String get learnCurrentFocus => 'Current focus';

  @override
  String get learnActiveSubject => 'Active subject';

  @override
  String learnWeekOf(int n, int total) {
    return 'Week $n of $total';
  }

  @override
  String learnCadence(Object pct) {
    return '$pct cadence';
  }

  @override
  String learnNext(Object step) {
    return 'Next · $step';
  }

  @override
  String get learnContinue => 'Continue study';

  @override
  String get learnNoFocusTitle => 'Choose a skill to focus on';

  @override
  String get learnNoFocusBody =>
      'A single focus for a few weeks turns study into real progress.';

  @override
  String get learnSetFocus => 'Set focus';

  @override
  String get learnEditFocus => 'Edit focus';

  @override
  String get learnApplyTitle => 'Apply what you learn';

  @override
  String learnApplyCount(int done, int total) {
    return '$done of $total completed';
  }

  @override
  String get learnApplyHint =>
      'Real progress happens when knowledge turns into action.';

  @override
  String get learnApplyEmpty =>
      'Turn one idea from your study into an action you can try this week.';

  @override
  String get learnCompletedToday => 'Completed today';

  @override
  String get learnUpcoming => 'Upcoming';

  @override
  String get learnSessions => 'Study sessions';

  @override
  String get learnRecent => 'Recent activity';

  @override
  String get learnNoSessions =>
      'Log a study session to build your learning rhythm.';

  @override
  String get learnGoals => 'Learning goals';

  @override
  String get learnResources => 'In progress resources';

  @override
  String learnActiveCount(int n) {
    return '$n active';
  }

  @override
  String get learnAddResource => 'Add resource';

  @override
  String get learnNoResources =>
      'Track a course or book to see your progress through it.';

  @override
  String learnUnitsOf(Object done, Object total, Object unit) {
    return '$done / $total $unit';
  }

  @override
  String get learnUpdateProgress => 'Update progress';

  @override
  String get learnArchiveResource => 'Remove resource';

  @override
  String get learnArchiveBody =>
      'The resource is hidden from your list. Past study sessions stay in your history.';

  @override
  String get learnThisWeek => 'This week in learning';

  @override
  String get learnStudyTime => 'Study time';

  @override
  String get learnSessionsCount => 'Sessions';

  @override
  String get learnAppliedCount => 'Applied';

  @override
  String learnDaysStudied(int n) {
    return '$n of 7 days studied this week.';
  }

  @override
  String get learnDaysNote => 'Steady, incremental knowledge application.';

  @override
  String get kindCourse => 'Course';

  @override
  String get kindBook => 'Book';

  @override
  String get kindVideo => 'Video';

  @override
  String get kindArticle => 'Article';

  @override
  String get unitLessons => 'lessons';

  @override
  String get unitPages => 'pages';

  @override
  String get unitVideos => 'videos';

  @override
  String get unitArticles => 'articles';

  @override
  String get studyTitle => 'Log study';

  @override
  String get studyTopic => 'What did you study?';

  @override
  String get studyTopicHint => 'e.g. Discovery question frameworks';

  @override
  String get studySkill => 'Skill';

  @override
  String get studySkillHint => 'e.g. Sales & Negotiation';

  @override
  String get studyMinutes => 'Duration';

  @override
  String get studyResource => 'Resource';

  @override
  String get studyNoResource => 'No resource';

  @override
  String get studyUnits => 'Progress in resource';

  @override
  String get studyTakeaway => 'Key takeaway';

  @override
  String get studyTakeawayHint => 'One idea worth remembering';

  @override
  String get studyAction => 'Action to apply';

  @override
  String get studyActionHint => 'Added to tomorrow\'s plan';

  @override
  String get takeawayTitle => 'Add takeaway';

  @override
  String get takeawayHint => 'What\'s one idea you want to keep?';

  @override
  String get focusTitle => 'Learning focus';

  @override
  String get focusSkill => 'Skill';

  @override
  String get focusDescription => 'What does progress look like?';

  @override
  String get focusDescriptionHint =>
      'e.g. Improve client discovery and proposal closing';

  @override
  String get focusWeeks => 'Length (weeks)';

  @override
  String get focusNextStep => 'Next step';

  @override
  String get focusNextStepHint =>
      'e.g. Practice discovery questions on next call';

  @override
  String get resourceTitle => 'Add resource';

  @override
  String get resourceName => 'Title';

  @override
  String get resourceNameHint => 'e.g. Never Split the Difference';

  @override
  String get resourceKind => 'Type';

  @override
  String resourceTotal(Object unit) {
    return 'Total $unit';
  }

  @override
  String get resourceDone => 'Completed so far';

  @override
  String get learnTargetStudy => 'Study (minutes per day)';

  @override
  String get goalsTitle => 'Goals';

  @override
  String get goalsSubtitle => 'What you\'re building over time.';

  @override
  String get goalsNew => 'New goal';

  @override
  String goalsActiveCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n active goals',
      one: '1 active goal',
    );
    return '$_temp0';
  }

  @override
  String goalsOnTrackCount(int n) {
    return '$n on track';
  }

  @override
  String goalsAttentionCount(int n) {
    return '$n need attention';
  }

  @override
  String get goalsFilterAll => 'All';

  @override
  String goalsFilterActive(int n) {
    return 'Active ($n)';
  }

  @override
  String goalsFilterCompleted(int n) {
    return 'Completed ($n)';
  }

  @override
  String get goalsPrimaryFocus => 'Primary focus';

  @override
  String get goalsKeystone => 'Keystone';

  @override
  String goalsTargetOn(Object date) {
    return 'Target · $date';
  }

  @override
  String get goalsNextActionToday => 'Next action · Today';

  @override
  String get goalsLogProgress => 'Log progress';

  @override
  String get goalsMonthRecap => 'This month';

  @override
  String goalsMovedForward(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n goals moved forward',
      one: '1 goal moved forward',
    );
    return '$_temp0';
  }

  @override
  String goalsRecapBody(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n progress updates logged.',
      one: '1 progress update logged.',
    );
    return '$_temp0';
  }

  @override
  String goalsRecapStrongest(Object areas) {
    return '$areas kept your strongest rhythm.';
  }

  @override
  String get goalsAll => 'All goals';

  @override
  String goalsAreas(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n active life areas',
      one: '1 active life area',
    );
    return '$_temp0';
  }

  @override
  String goalsPctCompleted(int pct) {
    return '$pct% completed';
  }

  @override
  String goalsNextShort(Object action) {
    return 'Next: $action';
  }

  @override
  String goalsRemaining(Object value) {
    return '$value remaining';
  }

  @override
  String get goalsMetPeriod => 'Met this period';

  @override
  String get goalsWeeklyRhythm => 'Weekly rhythm';

  @override
  String get goalsDailyRhythm => 'Daily rhythm';

  @override
  String get goalsMonthlyRhythm => 'Monthly rhythm';

  @override
  String get goalsCompletedGoals => 'Completed goals';

  @override
  String goalsCompletedOn(Object date) {
    return 'Completed $date';
  }

  @override
  String get goalsPaused => 'Paused';

  @override
  String get goalsEmptyTitle => 'Set your first goal';

  @override
  String get goalsEmptyBody =>
      'Goals connect your daily actions to what you\'re building over time.';

  @override
  String get goalsNoCompleted =>
      'Completed goals will be kept here as a record of what you\'ve built.';

  @override
  String get goalsNoneInFilter => 'No goals match this filter.';

  @override
  String get goalDetailTitle => 'Goal detail';

  @override
  String get goalPrimaryFocus => 'Primary focus';

  @override
  String get goalTrajectory => 'Trajectory';

  @override
  String goalOfTarget(Object target) {
    return 'of $target';
  }

  @override
  String get goalNextAction => 'Next action';

  @override
  String get goalAllActionsDone => 'All actions are done for this period.';

  @override
  String get goalActions => 'Actions';

  @override
  String goalActiveCount(int n) {
    return '$n active';
  }

  @override
  String get goalDoneForPeriod => 'Completed for this period';

  @override
  String get goalNoActions =>
      'Add a small recurring action that moves this goal forward.';

  @override
  String goalMilestonesDone(int done, int total) {
    return '$done of $total completed';
  }

  @override
  String goalMilestoneCompleted(Object date) {
    return 'Completed · $date';
  }

  @override
  String get goalMilestoneCurrent => 'Current';

  @override
  String get goalMilestoneUpcoming => 'Upcoming';

  @override
  String get goalHistory => 'Progress history';

  @override
  String get goalTrend => 'Progress trend';

  @override
  String goalTrendChange(Object pct) {
    return '$pct since start';
  }

  @override
  String get goalNoHistory =>
      'Progress you log, and linked module entries, will show up here.';

  @override
  String goalProgressAdded(Object value) {
    return '+$value';
  }

  @override
  String get goalWhyTitle => 'Why this matters';

  @override
  String get goalMenuEdit => 'Edit goal';

  @override
  String get goalMenuPause => 'Pause goal';

  @override
  String get goalMenuResume => 'Resume goal';

  @override
  String get goalMenuComplete => 'Mark as completed';

  @override
  String get goalMenuReopen => 'Reopen goal';

  @override
  String get goalMenuPrimary => 'Make primary focus';

  @override
  String get goalMenuArchive => 'Archive goal';

  @override
  String get goalMenuDelete => 'Delete goal';

  @override
  String get goalDeleteTitle => 'Delete this goal?';

  @override
  String get goalDeleteBody =>
      'The goal, its actions, milestones, and progress history will be removed. Logs in other areas stay.';

  @override
  String get goalArchiveTitle => 'Archive this goal?';

  @override
  String get goalArchiveBody =>
      'It will be hidden from your goals. Its history stays in your activity.';

  @override
  String get goalNotFound => 'This goal no longer exists.';

  @override
  String get goalLogTitle => 'Log progress';

  @override
  String get goalLogAmount => 'Amount to add';

  @override
  String get goalLogTimes => 'Times completed';

  @override
  String get goalLogNote => 'Note';

  @override
  String get goalLogSave => 'Save progress';

  @override
  String get goalLogged => 'Progress saved';

  @override
  String get goalCompletedBanner => 'Goal completed. Well done.';

  @override
  String get goalPausedBanner =>
      'This goal is paused. Resume it to track progress again.';

  @override
  String get healthOnTrack => 'On track';

  @override
  String get healthAttention => 'Needs attention';

  @override
  String get healthCompletedLabel => 'Completed';

  @override
  String get healthPausedLabel => 'Paused';

  @override
  String get progressTitle => 'Progress';

  @override
  String get progressSubtitle =>
      'Consistency, patterns, and long-term direction.';

  @override
  String get progressCalendar => 'Progress calendar';

  @override
  String get progressThisWeek => 'This week';

  @override
  String get progressThisMonth => 'This month';

  @override
  String get progressThisYear => 'This year';

  @override
  String progressVsLastWeek(Object delta) {
    return '$delta vs last week';
  }

  @override
  String progressVsLastMonth(Object delta) {
    return '$delta vs last month';
  }

  @override
  String progressVsLastYear(Object delta) {
    return '$delta vs last year';
  }

  @override
  String get progressOverall => 'Overall consistency';

  @override
  String progressDaysBody(int active, int total) {
    return '$active of $total days';
  }

  @override
  String get progressDaysTail =>
      'had meaningful progress across your focus areas.';

  @override
  String get progressOverTime => 'Progress over time';

  @override
  String get progressDailyTrajectory => 'Daily trajectory this week';

  @override
  String get progressWeeklyTrajectory => 'Weekly trajectory this month';

  @override
  String get progressMonthlyTrajectory => 'Monthly trajectory this year';

  @override
  String progressCurrent(Object pct) {
    return '$pct · Current';
  }

  @override
  String get progressLifeAreas => 'Life areas';

  @override
  String progressTracked(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n tracked categories',
      one: '1 tracked category',
    );
    return '$_temp0';
  }

  @override
  String get progressNeedsFocus => 'Needs focus';

  @override
  String get progressStrongest => 'Strongest rhythm';

  @override
  String progressStrongestBody(String pct, int days, int total) {
    return '$pct consistency — active on $days of $total days.';
  }

  @override
  String get progressAttention => 'Needs attention';

  @override
  String progressAttentionBody(Object pct) {
    return '$pct consistency. A small daily step here would lift your balance.';
  }

  @override
  String get progressConsistency => 'Consistency';

  @override
  String progressMeaningfulDays(int n, String period) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n meaningful progress days',
      one: '1 meaningful progress day',
    );
    return '$_temp0 in $period';
  }

  @override
  String get progressStrong => 'Strong';

  @override
  String get progressSteady => 'Steady';

  @override
  String get progressLight => 'Light';

  @override
  String get progressRest => 'Rest';

  @override
  String get progressNotLogged => 'Not logged';

  @override
  String progressBestDays(Object first, Object second) {
    return 'Your most consistent days are $first and $second.';
  }

  @override
  String get progressActiveGoals => 'Active goals';

  @override
  String get progressViewGoals => 'View all goals';

  @override
  String get progressMonthlyReady => 'Monthly review ready';

  @override
  String progressMonthlySummary(Object month) {
    return '$month summary';
  }

  @override
  String get progressMonthlyBody =>
      'See your patterns, key accomplishments, and what to adjust next month.';

  @override
  String get progressReviewMonth => 'Review this month';

  @override
  String get progressWeeklyLink => 'Weekly review';

  @override
  String get progressEmptyTitle => 'Your progress builds here';

  @override
  String get progressEmptyBody =>
      'Complete an action or log something in any area. Consistency, patterns, and trends appear as you go.';

  @override
  String get progressAddAction => 'Add something';

  @override
  String get calTitle => 'Progress Calendar';

  @override
  String get calToday => 'Today';

  @override
  String get calPrevMonth => 'Previous month';

  @override
  String get calNextMonth => 'Next month';

  @override
  String get calOverall => 'Overall';

  @override
  String calActiveDays(Object active, Object total) {
    return '$active / $total';
  }

  @override
  String get calActiveLabel => 'active days';

  @override
  String get calAvg => 'avg';

  @override
  String calStrongest(Object area) {
    return '$area strongest';
  }

  @override
  String get calSelected => 'Selected date';

  @override
  String get calStrongDay => 'Strong & focused';

  @override
  String get calSteadyDay => 'Steady';

  @override
  String get calLightDay => 'Light day';

  @override
  String get calNoDay => 'Not logged';

  @override
  String get calFutureDay => 'Upcoming';

  @override
  String calTotalProgress(Object pct) {
    return '$pct total progress';
  }

  @override
  String calActionsDone(int done, int total) {
    return '$done of $total actions done';
  }

  @override
  String get calContributions => 'Category contributions';

  @override
  String calEntries(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n entries',
      one: '1 entry',
    );
    return '$_temp0';
  }

  @override
  String calActionsOn(Object date) {
    return 'Actions on $date';
  }

  @override
  String get calDone => 'Done';

  @override
  String get calPending => 'Pending';

  @override
  String get calNothing =>
      'Nothing was logged on this day. Rest days are part of a sustainable rhythm.';

  @override
  String get calFutureNothing => 'Plan this day from your daily plan.';

  @override
  String get calOpenPlan => 'Open plan';

  @override
  String get calViewFull => 'View full day breakdown';

  @override
  String get calInsight => 'Monthly rhythm insight';

  @override
  String calInsightBody(Object first, Object second) {
    return '$first and $second were your most consistent days.';
  }

  @override
  String get reviewWinGoalCompleted => 'Goal completed';

  @override
  String get reviewWinMilestone => 'Milestone reached';

  @override
  String reviewWinMilestoneOf(Object goal) {
    return 'Milestone · $goal';
  }

  @override
  String reviewWinMoved(Object amount) {
    return '+$amount logged';
  }

  @override
  String reviewWinConsistency(String area, int days) {
    return 'Consistent $area on $days days';
  }

  @override
  String get reviewWinConsistencyBody =>
      'The rhythm held regardless of workload.';

  @override
  String get reviewGapNoLog => 'No log';

  @override
  String get reviewGapNoProgress => 'No progress logged';

  @override
  String reviewGapLow(Object area) {
    return '$area consistency';
  }

  @override
  String reviewGapOf(Object done, Object target) {
    return '$done of $target completed';
  }

  @override
  String get reviewPrioritiesAdd => 'Add priority';

  @override
  String get reviewPriorityTitle => 'Priority';

  @override
  String get reviewPriorityHint => 'e.g. Contact 25 qualified leads';

  @override
  String get reviewPriorityArea => 'Area';

  @override
  String get reviewPriorityGoal => 'Supports a goal';

  @override
  String get reviewPriorityNoGoal => 'No goal';

  @override
  String get reviewPrioritySuggested => 'From your goals';

  @override
  String get reviewPriorityRemove => 'Remove priority';

  @override
  String get reviewPriorityEdit => 'Edit priority';

  @override
  String reviewPriorityReorder(Object n) {
    return 'Reorder priority $n';
  }

  @override
  String reviewSelected(int n) {
    return '$n selected';
  }

  @override
  String get reviewPrioritiesEmpty => 'Choose up to 3 keystone commitments.';

  @override
  String get reviewPrioritiesMax =>
      'Three priorities keeps focus sharp. Remove one to add another.';

  @override
  String get reviewSaveDraft => 'Save and finish later';

  @override
  String get reviewSaved => 'Review saved';

  @override
  String get reviewCompleted => 'Review completed';

  @override
  String reviewCompletedOn(Object date) {
    return 'Completed $date. You can still update it.';
  }

  @override
  String get reviewTagFocused => 'Focused';

  @override
  String get reviewTagRoutine => 'Good routine';

  @override
  String get reviewTagQuran => 'Quran consistency';

  @override
  String get reviewTagWork => 'Strong work output';

  @override
  String get reviewTagFamily => 'Family time';

  @override
  String get reviewTagHealth => 'Healthy habits';

  @override
  String get reviewTagDistraction => 'Less distraction';

  @override
  String get reviewTagSleep => 'Sleep earlier';

  @override
  String get reviewTagFewerTasks => 'Fewer tasks';

  @override
  String get reviewTagProtectWorkout => 'Protect workout time';

  @override
  String get reviewTagPlanAhead => 'Plan ahead';

  @override
  String get reviewTagConsistency => 'Consistency';

  @override
  String get reviewTagWorkProgress => 'Work progress';

  @override
  String get reviewTagQuranMemo => 'Quran memorization';

  @override
  String get reviewTagFinance => 'Financial discipline';

  @override
  String get reviewTagLateSleep => 'Late sleep';

  @override
  String get reviewTagOverplanning => 'Overplanning';

  @override
  String get reviewTagLowEnergy => 'Low energy';

  @override
  String get reviewTagBedtime => 'Earlier bedtime';

  @override
  String get reviewTagSimplerTargets => 'Simpler targets';

  @override
  String get reviewTagDelegate => 'Delegate more';

  @override
  String get reviewTagFewerPriorities => 'Fewer priorities';

  @override
  String get weeklyTitle => 'Weekly Review';

  @override
  String get weeklyGlance => 'Your week at a glance';

  @override
  String get weeklyGlanceBody => 'A quick look at what moved forward.';

  @override
  String get weeklyOverall => 'Overall progress';

  @override
  String get weeklyActiveDays => 'Active days';

  @override
  String get weeklyActions => 'Actions';

  @override
  String get weeklyGoalsMoved => 'Goals moved';

  @override
  String get weeklyGoalsUnit => 'goals';

  @override
  String get weeklyStrongest => 'Strongest consistency';

  @override
  String weeklyStrongestDays(int active, int total) {
    return '$active of $total active days';
  }

  @override
  String get weeklyStrongestBody =>
      'This rhythm held steady through the week. Keep the same time slot.';

  @override
  String get weeklyAttention => 'Needs attention';

  @override
  String get weeklyAttentionBody =>
      'Consider making next week\'s target here lighter or more specific.';

  @override
  String get weeklyBiggestWin => 'Biggest win';

  @override
  String get weeklyEditWin => 'Edit win';

  @override
  String get weeklyWinHint => 'What was your biggest win this week?';

  @override
  String get weeklyAddWin => 'Add your biggest win';

  @override
  String get weeklyDidntMove => 'What didn\'t move?';

  @override
  String get weeklyCarriedOver => 'Carried over';

  @override
  String get weeklyAllMoved => 'Every active goal moved this week.';

  @override
  String get weeklyReflection => 'Weekly reflection';

  @override
  String get weeklyReflectionSub => 'Quick notes to anchor insights';

  @override
  String get weeklyWentWell => 'What went well?';

  @override
  String get weeklyWentWellHint => 'Key moments or habits that worked...';

  @override
  String get weeklyChange => 'What should change next week?';

  @override
  String get weeklyChangeHint => 'Adjustments or focus areas...';

  @override
  String get weeklyNextFocus => 'Next week\'s focus';

  @override
  String weeklyNextFocusSub(Object range) {
    return 'Keystone commitments for $range';
  }

  @override
  String weeklyInsightCheckIn(Object pct) {
    return 'Days that started with a morning check-in scored $pct higher on average.';
  }

  @override
  String weeklyInsightDays(Object first, Object second) {
    return 'Your most consistent days were $first and $second.';
  }

  @override
  String get weeklyFootnote =>
      'Saves your reflection and adds your focus to next week\'s plan.';

  @override
  String get weeklyComplete => 'Complete Weekly Review';

  @override
  String get weeklyUpdate => 'Update Weekly Review';

  @override
  String weeklyFocusAdded(Object date) {
    return 'Weekly focus added to your plan for $date';
  }

  @override
  String get weeklyFocusBadge => 'Weekly focus';

  @override
  String get monthlyTitle => 'Monthly Review';

  @override
  String get monthlyCadence => 'Taqaddum · Monthly cadence';

  @override
  String get monthlyHero => 'Your month in perspective';

  @override
  String get monthlyHeroBody =>
      'See what moved forward and what should change next.';

  @override
  String get monthlyCompletion => 'completion';

  @override
  String monthlyVs(Object delta, Object month) {
    return '$delta vs $month';
  }

  @override
  String get monthlyReviewsDone => 'Reviews done';

  @override
  String monthlyActiveDomains(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n active domains',
      one: '1 active domain',
    );
    return '$_temp0';
  }

  @override
  String get monthlyInsights => 'Constructive insights';

  @override
  String monthlyStrongestTitle(String area, int days) {
    return '$area · $days active days';
  }

  @override
  String get monthlyStrongestBody =>
      'Your most dependable rhythm this month. Protect what made it easy.';

  @override
  String get monthlyRefocus => 'Area to refocus';

  @override
  String monthlyRefocusTitle(Object area, Object pct) {
    return '$area · $pct consistency';
  }

  @override
  String get monthlyRefocusBody =>
      'A simpler weekly target may be easier to sustain next month.';

  @override
  String get monthlyGoals => 'Active goals progress';

  @override
  String monthlyGoalsActive(int n) {
    return '$n active';
  }

  @override
  String monthlyGoalMoved(Object amount) {
    return '+$amount this month';
  }

  @override
  String monthlyGoalMilestones(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n milestones reached this month',
      one: '1 milestone reached this month',
    );
    return '$_temp0';
  }

  @override
  String get monthlyGoalNoMove => 'No progress logged this month';

  @override
  String monthlyTarget(Object value) {
    return 'Target: $value';
  }

  @override
  String get monthlyQuote =>
      'Momentum comes from regular reflection, not sudden intensity.';

  @override
  String get monthlySnapshots => 'Category snapshots';

  @override
  String get monthlySnapshotsSub => 'Tap to inspect';

  @override
  String monthlyDeepWork(Object time) {
    return '$time deep work';
  }

  @override
  String monthlyClientsWon(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n clients won',
      one: '1 client won',
    );
    return '$_temp0';
  }

  @override
  String get monthlyLeads => 'Leads';

  @override
  String get monthlyFollowUps => 'Follow-ups';

  @override
  String get monthlyProposals => 'Proposals';

  @override
  String get monthlyRevenue => 'Revenue';

  @override
  String get monthlyIncome => 'Income';

  @override
  String get monthlyExpenses => 'Expenses';

  @override
  String get monthlySaved => 'Saved';

  @override
  String monthlyNet(Object amount) {
    return 'Net $amount';
  }

  @override
  String monthlyPagesRead(Object pages) {
    return '$pages pages read';
  }

  @override
  String monthlyActiveDaysShort(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n active days',
      one: '1 active day',
    );
    return '$_temp0';
  }

  @override
  String get monthlyMemorized => 'Memorized';

  @override
  String get monthlyRevision => 'Revision';

  @override
  String get monthlyActive => 'Active';

  @override
  String monthlyDays(int n) {
    return '$n days';
  }

  @override
  String monthlyWorkouts(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n workouts',
      one: '1 workout',
    );
    return '$_temp0';
  }

  @override
  String monthlyAvgSleepValue(Object time) {
    return '$time sleep';
  }

  @override
  String get monthlyWalkDays => 'Walk days';

  @override
  String get monthlyAvgSleep => 'Avg sleep';

  @override
  String get monthlyHabits => 'Habits';

  @override
  String monthlyStudy(Object time) {
    return '$time study';
  }

  @override
  String get monthlySessions => 'Sessions';

  @override
  String get monthlyTakeaways => 'Takeaways';

  @override
  String get monthlyFocus => 'Focus';

  @override
  String monthlyNotes(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n notes',
      one: '1 note',
    );
    return '$_temp0';
  }

  @override
  String get monthlyPersonalTasks => 'Actions done';

  @override
  String get monthlyNoData => 'Nothing logged here this month.';

  @override
  String get monthlyWins => 'Biggest wins this month';

  @override
  String get monthlyNotPlanned => 'What didn\'t go as planned';

  @override
  String get monthlyReflection => 'Monthly reflection';

  @override
  String get monthlyReflectionSub => '3 quick questions';

  @override
  String get monthlyProud => '1. What am I proud of?';

  @override
  String get monthlyHeldBack => '2. What held me back?';

  @override
  String get monthlyDifferent => '3. What should I do differently next month?';

  @override
  String get monthlyNoteHint => 'Add a note...';

  @override
  String get monthlyLesson => 'One lesson to carry forward';

  @override
  String get monthlyLessonHint =>
      'e.g. Fewer priorities helped me finish more meaningful work.';

  @override
  String monthlyNextFocus(Object month) {
    return '$month focus';
  }

  @override
  String get monthlyNextFocusSub => 'Top 3 committed priorities';

  @override
  String monthlyBalanced(int n) {
    return 'Your next-month focus looks balanced across $n areas.';
  }

  @override
  String get monthlyNarrow =>
      'All priorities sit in one area. That\'s fine if it\'s intentional.';

  @override
  String get monthlyComplete => 'Complete Monthly Review';

  @override
  String get monthlyUpdate => 'Update Monthly Review';

  @override
  String get monthlyNothingYet =>
      'Nothing to highlight yet. Log progress through the month and it will appear here.';

  @override
  String get activityTitle => 'Activity History';

  @override
  String get activitySearchHint => 'Search activity, notes, metrics...';

  @override
  String get activityClearSearch => 'Clear search';

  @override
  String get activityAll => 'All';

  @override
  String get activityReviews => 'Reviews';

  @override
  String get activityReview => 'Review';

  @override
  String activityEntries(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n entries',
      one: '1 entry',
    );
    return '$_temp0';
  }

  @override
  String activityAreas(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n focus areas',
      one: '1 focus area',
      zero: 'no focus areas',
    );
    return '$_temp0';
  }

  @override
  String activityShowing(Object areas, Object entries) {
    return 'Showing $entries across $areas';
  }

  @override
  String activityLogs(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n logs',
      one: '1 log',
    );
    return '$_temp0';
  }

  @override
  String get activityToday => 'Today';

  @override
  String get activityYesterday => 'Yesterday';

  @override
  String get activityRangeTitle => 'Date range';

  @override
  String get activityRangeAll => 'All time';

  @override
  String get activityRangeWeek => 'This week';

  @override
  String get activityRangeMonth => 'This month';

  @override
  String get activityRangeLastMonth => 'Last month';

  @override
  String get activityRangeYear => 'This year';

  @override
  String get activityFilterDate => 'Filter by date range';

  @override
  String get activityEmptyTitle => 'No logs found';

  @override
  String get activityEmptyBody =>
      'No activities matched your current category or search query.';

  @override
  String get activityReset => 'Reset filters';

  @override
  String get activityNothingTitle => 'No activity yet';

  @override
  String get activityNothingBody =>
      'Everything you log, from actions and Quran to work, money, health, and learning, appears here.';

  @override
  String get activityDetail => 'Activity detail';

  @override
  String get activityLoggedTime => 'Logged time';

  @override
  String get activityAmount => 'Amount';

  @override
  String get activityType => 'Type';

  @override
  String get activityDismiss => 'Dismiss';

  @override
  String get activityOpen => 'Open';

  @override
  String get activityOpenPlan => 'Open day plan';

  @override
  String get activityOpenGoal => 'Open goal';

  @override
  String get activityTypeCreated => 'Created';

  @override
  String get activityTypeCompleted => 'Completed';

  @override
  String get activityTypeLogged => 'Logged';

  @override
  String get activityTypeReviewed => 'Reviewed';

  @override
  String get activityTypeUpdated => 'Updated';

  @override
  String get activityTypeMilestone => 'Milestone';

  @override
  String get notifTitle => 'Notifications';

  @override
  String get notifHeadline => 'Notifications & Reminders';

  @override
  String get notifSubtitle =>
      'Choose the reminders that help you stay consistent.';

  @override
  String notifActiveCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n active reminders',
      one: '1 active reminder',
      zero: 'No active reminders',
    );
    return '$_temp0';
  }

  @override
  String notifQuietActive(Object range) {
    return 'Quiet hours active ($range)';
  }

  @override
  String get notifPaused => 'All reminders paused';

  @override
  String get notifAll => 'All notifications';

  @override
  String get notifAllBody =>
      'Pause all Taqaddum reminders without losing your scheduled times.';

  @override
  String get notifDailyRoutine => 'Daily routine';

  @override
  String get notifMorningBody =>
      'Start the day with your 3 keystone priorities.';

  @override
  String get notifNightBody =>
      'Close the day with a quiet 3-question reflection.';

  @override
  String get notifQuranSection => 'Quran & Spiritual';

  @override
  String get notifQuranReading => 'Daily reading reminder';

  @override
  String get notifQuranReadingBody =>
      'A gentle reminder for today\'s Quran reading.';

  @override
  String get notifQuranMemo => 'Memorization practice';

  @override
  String get notifQuranMemoBody => 'Continue your active memorization.';

  @override
  String get notifQuranRevision => 'Revision & review';

  @override
  String get notifQuranRevisionBody => 'Keep previously memorized pages fresh.';

  @override
  String get notifHabitsSection => 'Habits & Health';

  @override
  String get notifManageHabits => 'Manage habit reminders';

  @override
  String get notifNoHabitReminders => 'No habit reminders yet.';

  @override
  String get notifAddHabit => 'Add a habit';

  @override
  String get notifHabitPicker => 'Habit reminders';

  @override
  String get notifHabitPickerBody => 'Choose a habit, then pick a time.';

  @override
  String notifHabitSet(Object time) {
    return 'Reminder at $time';
  }

  @override
  String get notifHabitNone => 'No reminder';

  @override
  String get notifRemoveReminder => 'Remove reminder';

  @override
  String get notifWorkSection => 'Work & Business';

  @override
  String get notifFollowUps => 'Follow-up reminders';

  @override
  String get notifFollowUpsBody =>
      'Remind me when proposals or lead follow-ups are due.';

  @override
  String notifMorningSummary(Object time) {
    return 'Morning summary ($time)';
  }

  @override
  String get notifReviewsSection => 'Cadence reviews';

  @override
  String get notifWeeklyBody =>
      'Reflect on the week and set your next 3 priorities.';

  @override
  String get notifMonthlyBody => 'Review your month and plan the next one.';

  @override
  String notifEvery(Object day, Object time) {
    return 'Every $day · $time';
  }

  @override
  String notifLastDay(Object time) {
    return 'Last day of month · $time';
  }

  @override
  String get notifReviewDay => 'Review day';

  @override
  String get notifQuietSection => 'Quiet hours & Calm UX';

  @override
  String get notifQuiet => 'Quiet hours';

  @override
  String get notifQuietBody =>
      'No sound or pop-up reminders during your rest window.';

  @override
  String get notifQuietStart => 'Quiet hours start';

  @override
  String get notifQuietEnd => 'Quiet hours end';

  @override
  String get notifSmart => 'Smart reminder suppression';

  @override
  String get notifSmartBody =>
      'If you already logged the activity (for example read Quran or completed a habit), Taqaddum skips that day\'s reminder.';

  @override
  String get notifActive => 'Active';

  @override
  String get notifOff => 'Off';

  @override
  String get notifPreview => 'Preview';

  @override
  String notifPreviewNext(Object when) {
    return 'Next · $when';
  }

  @override
  String get notifPreviewNone =>
      'No upcoming reminders with your current settings.';

  @override
  String get notifInQuiet => 'Falls in quiet hours';

  @override
  String get notifDaily => 'Daily';

  @override
  String get notifWeekdays => 'Weekdays';

  @override
  String get notifRepeat => 'Repeat on';

  @override
  String get notifDays => 'Days';

  @override
  String get notifAuthorized => 'System notifications are authorized';

  @override
  String get notifDenied => 'Notifications are off for Taqaddum';

  @override
  String get notifDeniedBody =>
      'Reminders can\'t appear until you allow notifications. If the prompt doesn\'t show, enable them in your device Settings.';

  @override
  String get notifAllow => 'Allow notifications';

  @override
  String get notifTime => 'Time';

  @override
  String get profileTitle => 'Profile';

  @override
  String get profileSettings => 'Settings';

  @override
  String get profileEdit => 'Edit profile';

  @override
  String get profileMember => 'Taqaddum member · Personal workspace';

  @override
  String get profileCurrentFocus => 'Current focus';

  @override
  String get profilePrimaryFocus => 'Primary focus';

  @override
  String profileTarget(Object value) {
    return 'Target: $value';
  }

  @override
  String profileInitiated(Object date) {
    return 'Started $date';
  }

  @override
  String profileNext(Object action) {
    return 'Next: $action';
  }

  @override
  String get profileNoFocus => 'No primary focus yet';

  @override
  String get profileNoFocusBody =>
      'Mark one goal as your primary focus to keep it front and center.';

  @override
  String get profileChooseFocus => 'Choose a focus';

  @override
  String profileYearProgress(Object year) {
    return '$year progress';
  }

  @override
  String get profileAnnual => 'Annual horizon';

  @override
  String get profileAlignment => 'Overall consistency across your focus areas';

  @override
  String get profileOnSchedule => 'On schedule';

  @override
  String get profileSteady => 'Steady';

  @override
  String get profileBuilding => 'Building';

  @override
  String get profileActiveConsistency => 'Active consistency';

  @override
  String get profileActiveThisMonth => 'Active this month';

  @override
  String get profileYearGoals => 'Year goals';

  @override
  String profileGoalsSummary(int active, int done) {
    return '$active active · $done done';
  }

  @override
  String profileGoalsTotal(int n) {
    return '$n total declared';
  }

  @override
  String get profileLifeAreas => 'My life areas';

  @override
  String profileLifeAreasSub(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n active life areas',
      one: '1 active life area',
    );
    return '$_temp0';
  }

  @override
  String get profileEditAreas => 'Edit life areas';

  @override
  String get profileAreaActive => 'Active';

  @override
  String get profileAreaOff => 'Off';

  @override
  String profileIntention(Object year) {
    return '$year intention';
  }

  @override
  String get profileIntentionHint =>
      'e.g. Build a balanced year with faith, meaningful work, and family.';

  @override
  String get profileAddIntention => 'Add your intention for the year';

  @override
  String get profileEditIntention => 'Edit intention';

  @override
  String get profileYourTaqaddum => 'Your Taqaddum';

  @override
  String get profileActivity => 'Activity history';

  @override
  String get profileActivityBody => 'See your past activity and logs';

  @override
  String get profileWeekly => 'Weekly review';

  @override
  String get profileWeeklyBody => 'Reflect on your week';

  @override
  String get profileMonthly => 'Monthly review';

  @override
  String get profileMonthlyBody => 'Review your monthly progress';

  @override
  String get profileNotifications => 'Notifications & reminders';

  @override
  String get profileNotificationsBody => 'Manage reminders and quiet hours';

  @override
  String get profileSettingsBody =>
      'Language, preferences, account and app options';

  @override
  String get profileExport => 'Export my data';

  @override
  String get profileBackup => 'Stored on this device';

  @override
  String profileFooter(Object date, Object version) {
    return 'Taqaddum v$version · Using since $date';
  }

  @override
  String get profilePrivate => 'Private and on-device';

  @override
  String get profileName => 'Full name';

  @override
  String get profileRole => 'Role';

  @override
  String get profileRoleHint => 'e.g. Entrepreneur';

  @override
  String get profileSaved => 'Profile updated';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get settingsUpdated => 'Preference updated';

  @override
  String get settingsPreferences => 'Preferences';

  @override
  String get settingsLanguage => 'Language';

  @override
  String get settingsLanguagePreview =>
      'Preview: some screens are still in English';

  @override
  String get settingsReduceMotion => 'Reduce motion';

  @override
  String get settingsReduceMotionBody => 'Shorter, simpler transitions';

  @override
  String get settingsPlanning => 'Planning';

  @override
  String get settingsWeekStart => 'Week starts on';

  @override
  String get settingsCurrency => 'Currency';

  @override
  String get settingsTimeFormat => 'Time format';

  @override
  String get settings24h => '24-hour';

  @override
  String get settings12h => '12-hour';

  @override
  String get settingsNotifications => 'Notifications';

  @override
  String get settingsNotificationsBody =>
      'Manage reminder schedule and quiet hours';

  @override
  String get settingsOn => 'On';

  @override
  String get settingsOff => 'Off';

  @override
  String get settingsPersonalization => 'Personalization';

  @override
  String get settingsLifeAreas => 'Life areas';

  @override
  String get settingsLifeAreasBody => 'Choose the areas you track';

  @override
  String settingsLifeAreasCount(int n) {
    return '$n active';
  }

  @override
  String get settingsLifeAreasMin => 'Keep at least one area active.';

  @override
  String get settingsPrimaryFocus => 'Primary focus';

  @override
  String get settingsPrimaryFocusBody => 'Your current keystone commitment';

  @override
  String get settingsNoGoals => 'Create a goal first';

  @override
  String get settingsDataPrivacy => 'Data & Privacy';

  @override
  String get settingsActivity => 'Activity history';

  @override
  String get settingsActivityBody => 'Review your past logs and entries';

  @override
  String get settingsExport => 'Export my data';

  @override
  String get settingsExportBody => 'Create a copy of your progress data';

  @override
  String get settingsExportJson => 'JSON (complete backup)';

  @override
  String get settingsExportJsonBody => 'Every table in one file';

  @override
  String get settingsExportCsv => 'CSV (spreadsheets)';

  @override
  String get settingsExportCsvBody => 'Transactions and activity log';

  @override
  String get settingsExportFailed => 'Export failed. Please try again.';

  @override
  String get settingsPrivacy => 'Privacy & security';

  @override
  String get settingsPrivacyBody => 'Local storage, no third-party tracking';

  @override
  String get settingsPrivacyP4 =>
      'Everything you log is stored in the app\'s private storage on this device. Uninstalling the app removes it, so export a copy if you want a backup.';

  @override
  String get settingsAccount => 'Account';

  @override
  String get settingsAccountProfile => 'Account profile';

  @override
  String get settingsEmail => 'Email address';

  @override
  String get settingsEmailNone => 'Not set';

  @override
  String get settingsEmailSaved => 'Email updated';

  @override
  String get settingsSecurity => 'Sign-in security';

  @override
  String get settingsPasswordSet => 'Password set';

  @override
  String get settingsPasswordNone => 'No password';

  @override
  String get settingsPasswordTitle => 'Change password';

  @override
  String get settingsPasswordAddTitle => 'Add a password';

  @override
  String get settingsPasswordCurrent => 'Current password';

  @override
  String get settingsPasswordNew => 'New password';

  @override
  String get settingsPasswordSaved => 'Password saved';

  @override
  String get settingsPasswordNeedsEmail =>
      'Add an email first. You\'ll use it with your password to sign in.';

  @override
  String get settingsLogout => 'Log out';

  @override
  String get settingsLogoutTitle => 'Log out?';

  @override
  String get settingsLogoutBody =>
      'Your data stays on this device. Sign in again to continue where you left off.';

  @override
  String get settingsLogoutNoPassword =>
      'This device has no password. You can continue on this device from the sign-in screen at any time.';

  @override
  String get settingsSupport => 'Support & About';

  @override
  String get settingsHelp => 'Help & FAQ';

  @override
  String get settingsHelpQ1 => 'Where is my data stored?';

  @override
  String get settingsHelpA1 =>
      'Only on this device. Taqaddum works fully offline and never sends your records anywhere.';

  @override
  String get settingsHelpQ2 => 'How is progress calculated?';

  @override
  String get settingsHelpA2 =>
      'A day\'s score is the share of planned actions you completed. Without a plan, three logged activities count as a full day.';

  @override
  String get settingsHelpQ3 => 'How do I back up?';

  @override
  String get settingsHelpA3 =>
      'Use Export my data to save a JSON copy wherever you choose.';

  @override
  String get settingsHelpQ4 => 'Why didn\'t a reminder appear?';

  @override
  String get settingsHelpA4 =>
      'Reminders are skipped during quiet hours, and smart suppression skips a reminder when you\'ve already logged that activity today.';

  @override
  String get settingsAbout => 'About Taqaddum';

  @override
  String get settingsLicenses => 'Open-source licenses';

  @override
  String get settingsTerms => 'Terms';

  @override
  String get settingsPrivacyPolicy => 'Privacy Policy';

  @override
  String get settingsDanger => 'Account actions';

  @override
  String get settingsDelete => 'Delete account';

  @override
  String get settingsDeleteBody =>
      'Permanently erase your Taqaddum account and every local record on this device.';

  @override
  String get settingsDeleteTitle => 'Delete everything?';

  @override
  String get settingsDeleteConfirm =>
      'This erases your account, goals, logs, reviews, reminders and preferences from this device. It cannot be undone.';

  @override
  String get settingsDeleteButton => 'Delete permanently';

  @override
  String get settingsFooter => 'Crafted for calm consistency';

  @override
  String get settingsDeveloper => 'Developer';

  @override
  String get settingsDemo => 'Load demo data';

  @override
  String get settingsDemoBody =>
      'Fill the app with sample goals and logs for testing';

  @override
  String get settingsDemoConfirm =>
      'This adds sample goals, tasks and logs to your current data. Use it only for testing.';

  @override
  String get settingsDemoDone => 'Demo data added';

  @override
  String get appName => 'Taqaddum';
}
