import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';
import 'app_localizations_fr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
    Locale('fr'),
  ];

  /// No description provided for @commonBack.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get commonBack;

  /// No description provided for @commonClose.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get commonClose;

  /// No description provided for @commonCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get commonCancel;

  /// No description provided for @commonSave.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get commonSave;

  /// No description provided for @commonDone.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get commonDone;

  /// No description provided for @commonEdit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get commonEdit;

  /// No description provided for @commonDelete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get commonDelete;

  /// No description provided for @commonContinue.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get commonContinue;

  /// No description provided for @commonSkip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get commonSkip;

  /// No description provided for @commonToday.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get commonToday;

  /// No description provided for @commonTomorrow.
  ///
  /// In en, this message translates to:
  /// **'Tomorrow'**
  String get commonTomorrow;

  /// No description provided for @commonYesterday.
  ///
  /// In en, this message translates to:
  /// **'Yesterday'**
  String get commonYesterday;

  /// No description provided for @commonOptional.
  ///
  /// In en, this message translates to:
  /// **'Optional'**
  String get commonOptional;

  /// No description provided for @commonNone.
  ///
  /// In en, this message translates to:
  /// **'None'**
  String get commonNone;

  /// No description provided for @commonRetry.
  ///
  /// In en, this message translates to:
  /// **'Try again'**
  String get commonRetry;

  /// No description provided for @commonViewAll.
  ///
  /// In en, this message translates to:
  /// **'View all'**
  String get commonViewAll;

  /// No description provided for @commonSomethingWrong.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong'**
  String get commonSomethingWrong;

  /// No description provided for @commonSomethingWrongBody.
  ///
  /// In en, this message translates to:
  /// **'We couldn\'t load this section. Your data is safe on this device.'**
  String get commonSomethingWrongBody;

  /// No description provided for @commonRequired.
  ///
  /// In en, this message translates to:
  /// **'Required'**
  String get commonRequired;

  /// No description provided for @commonInvalidNumber.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid number'**
  String get commonInvalidNumber;

  /// No description provided for @commonSaved.
  ///
  /// In en, this message translates to:
  /// **'Saved'**
  String get commonSaved;

  /// No description provided for @commonConfirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get commonConfirm;

  /// No description provided for @commonDate.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get commonDate;

  /// No description provided for @commonTime.
  ///
  /// In en, this message translates to:
  /// **'Time'**
  String get commonTime;

  /// No description provided for @commonNote.
  ///
  /// In en, this message translates to:
  /// **'Note'**
  String get commonNote;

  /// No description provided for @commonNotePlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Add a short note'**
  String get commonNotePlaceholder;

  /// No description provided for @commonMinutes.
  ///
  /// In en, this message translates to:
  /// **'Minutes'**
  String get commonMinutes;

  /// No description provided for @commonMinutesShort.
  ///
  /// In en, this message translates to:
  /// **'{count} min'**
  String commonMinutesShort(int count);

  /// No description provided for @commonLinkedGoal.
  ///
  /// In en, this message translates to:
  /// **'Counts toward goal'**
  String get commonLinkedGoal;

  /// No description provided for @commonNoLinkedGoal.
  ///
  /// In en, this message translates to:
  /// **'Not linked to a goal'**
  String get commonNoLinkedGoal;

  /// No description provided for @commonPercentComplete.
  ///
  /// In en, this message translates to:
  /// **'{percent}% completed'**
  String commonPercentComplete(int percent);

  /// No description provided for @commonOfTotal.
  ///
  /// In en, this message translates to:
  /// **'{done} of {total}'**
  String commonOfTotal(int done, int total);

  /// No description provided for @commonOnTrack.
  ///
  /// In en, this message translates to:
  /// **'On track'**
  String get commonOnTrack;

  /// No description provided for @commonNeedsAttention.
  ///
  /// In en, this message translates to:
  /// **'Needs attention'**
  String get commonNeedsAttention;

  /// No description provided for @commonCompleted.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get commonCompleted;

  /// No description provided for @commonPaused.
  ///
  /// In en, this message translates to:
  /// **'Paused'**
  String get commonPaused;

  /// No description provided for @commonActive.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get commonActive;

  /// No description provided for @commonWeek.
  ///
  /// In en, this message translates to:
  /// **'Week'**
  String get commonWeek;

  /// No description provided for @commonMonth.
  ///
  /// In en, this message translates to:
  /// **'Month'**
  String get commonMonth;

  /// No description provided for @commonYear.
  ///
  /// In en, this message translates to:
  /// **'Year'**
  String get commonYear;

  /// No description provided for @commonThisWeek.
  ///
  /// In en, this message translates to:
  /// **'This week'**
  String get commonThisWeek;

  /// No description provided for @commonThisMonth.
  ///
  /// In en, this message translates to:
  /// **'This month'**
  String get commonThisMonth;

  /// No description provided for @commonLastMonth.
  ///
  /// In en, this message translates to:
  /// **'Last month'**
  String get commonLastMonth;

  /// No description provided for @commonDecrease.
  ///
  /// In en, this message translates to:
  /// **'Decrease'**
  String get commonDecrease;

  /// No description provided for @commonIncrease.
  ///
  /// In en, this message translates to:
  /// **'Increase'**
  String get commonIncrease;

  /// No description provided for @commonAdd.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get commonAdd;

  /// No description provided for @commonUndo.
  ///
  /// In en, this message translates to:
  /// **'Undo'**
  String get commonUndo;

  /// No description provided for @commonMore.
  ///
  /// In en, this message translates to:
  /// **'More options'**
  String get commonMore;

  /// No description provided for @commonDiscard.
  ///
  /// In en, this message translates to:
  /// **'Discard'**
  String get commonDiscard;

  /// No description provided for @commonKeepEditing.
  ///
  /// In en, this message translates to:
  /// **'Keep editing'**
  String get commonKeepEditing;

  /// No description provided for @commonUnsavedTitle.
  ///
  /// In en, this message translates to:
  /// **'Discard changes?'**
  String get commonUnsavedTitle;

  /// No description provided for @commonUnsavedBody.
  ///
  /// In en, this message translates to:
  /// **'Your changes haven\'t been saved yet.'**
  String get commonUnsavedBody;

  /// No description provided for @areaQuran.
  ///
  /// In en, this message translates to:
  /// **'Quran'**
  String get areaQuran;

  /// No description provided for @areaWork.
  ///
  /// In en, this message translates to:
  /// **'Work'**
  String get areaWork;

  /// No description provided for @areaFinance.
  ///
  /// In en, this message translates to:
  /// **'Finance'**
  String get areaFinance;

  /// No description provided for @areaHealth.
  ///
  /// In en, this message translates to:
  /// **'Health'**
  String get areaHealth;

  /// No description provided for @areaLearning.
  ///
  /// In en, this message translates to:
  /// **'Learning'**
  String get areaLearning;

  /// No description provided for @areaPersonal.
  ///
  /// In en, this message translates to:
  /// **'Personal'**
  String get areaPersonal;

  /// No description provided for @areaReview.
  ///
  /// In en, this message translates to:
  /// **'Review'**
  String get areaReview;

  /// No description provided for @areaQuranLong.
  ///
  /// In en, this message translates to:
  /// **'Quran & Faith'**
  String get areaQuranLong;

  /// No description provided for @areaWorkLong.
  ///
  /// In en, this message translates to:
  /// **'Work & Growth'**
  String get areaWorkLong;

  /// No description provided for @areaFinanceLong.
  ///
  /// In en, this message translates to:
  /// **'Personal Finance'**
  String get areaFinanceLong;

  /// No description provided for @areaHealthLong.
  ///
  /// In en, this message translates to:
  /// **'Health & Habits'**
  String get areaHealthLong;

  /// No description provided for @areaLearningLong.
  ///
  /// In en, this message translates to:
  /// **'Learning'**
  String get areaLearningLong;

  /// No description provided for @areaPersonalLong.
  ///
  /// In en, this message translates to:
  /// **'Personal Life'**
  String get areaPersonalLong;

  /// No description provided for @navToday.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get navToday;

  /// No description provided for @navProgress.
  ///
  /// In en, this message translates to:
  /// **'Progress'**
  String get navProgress;

  /// No description provided for @navGoals.
  ///
  /// In en, this message translates to:
  /// **'Goals'**
  String get navGoals;

  /// No description provided for @navProfile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get navProfile;

  /// No description provided for @navQuickAdd.
  ///
  /// In en, this message translates to:
  /// **'Quick Add'**
  String get navQuickAdd;

  /// No description provided for @reminderMorningTitle.
  ///
  /// In en, this message translates to:
  /// **'Morning check-in'**
  String get reminderMorningTitle;

  /// No description provided for @reminderMorningBody.
  ///
  /// In en, this message translates to:
  /// **'Take a minute to choose today\'s 3 priorities.'**
  String get reminderMorningBody;

  /// No description provided for @reminderNightTitle.
  ///
  /// In en, this message translates to:
  /// **'Night review'**
  String get reminderNightTitle;

  /// No description provided for @reminderNightBody.
  ///
  /// In en, this message translates to:
  /// **'Close the day with a quiet 3-question reflection.'**
  String get reminderNightBody;

  /// No description provided for @reminderQuranReadingTitle.
  ///
  /// In en, this message translates to:
  /// **'Quran reading'**
  String get reminderQuranReadingTitle;

  /// No description provided for @reminderQuranReadingBody.
  ///
  /// In en, this message translates to:
  /// **'Your Quran reading is still open for today. Ready whenever you are.'**
  String get reminderQuranReadingBody;

  /// No description provided for @reminderQuranMemoTitle.
  ///
  /// In en, this message translates to:
  /// **'Memorization practice'**
  String get reminderQuranMemoTitle;

  /// No description provided for @reminderQuranMemoBody.
  ///
  /// In en, this message translates to:
  /// **'Continue your active memorization when you have a calm moment.'**
  String get reminderQuranMemoBody;

  /// No description provided for @reminderQuranRevisionTitle.
  ///
  /// In en, this message translates to:
  /// **'Revision'**
  String get reminderQuranRevisionTitle;

  /// No description provided for @reminderQuranRevisionBody.
  ///
  /// In en, this message translates to:
  /// **'Keep previously memorized pages fresh with a short revision.'**
  String get reminderQuranRevisionBody;

  /// No description provided for @reminderHabitTitle.
  ///
  /// In en, this message translates to:
  /// **'{habit}'**
  String reminderHabitTitle(String habit);

  /// No description provided for @reminderHabitBody.
  ///
  /// In en, this message translates to:
  /// **'A gentle reminder for your habit today.'**
  String get reminderHabitBody;

  /// No description provided for @reminderWorkTitle.
  ///
  /// In en, this message translates to:
  /// **'Follow-ups'**
  String get reminderWorkTitle;

  /// No description provided for @reminderWorkBody.
  ///
  /// In en, this message translates to:
  /// **'Review the proposals and leads that need a follow-up today.'**
  String get reminderWorkBody;

  /// No description provided for @reminderWeeklyTitle.
  ///
  /// In en, this message translates to:
  /// **'Weekly review'**
  String get reminderWeeklyTitle;

  /// No description provided for @reminderWeeklyBody.
  ///
  /// In en, this message translates to:
  /// **'Reflect on the week and set your next 3 priorities.'**
  String get reminderWeeklyBody;

  /// No description provided for @reminderMonthlyTitle.
  ///
  /// In en, this message translates to:
  /// **'Monthly review'**
  String get reminderMonthlyTitle;

  /// No description provided for @reminderMonthlyBody.
  ///
  /// In en, this message translates to:
  /// **'Review your month and plan the next one.'**
  String get reminderMonthlyBody;

  /// No description provided for @splashTagline.
  ///
  /// In en, this message translates to:
  /// **'Progress, one day at a time.'**
  String get splashTagline;

  /// No description provided for @splashFooter.
  ///
  /// In en, this message translates to:
  /// **'Build your better days.'**
  String get splashFooter;

  /// No description provided for @authWelcomeBack.
  ///
  /// In en, this message translates to:
  /// **'Welcome back'**
  String get authWelcomeBack;

  /// No description provided for @authWelcomeCreate.
  ///
  /// In en, this message translates to:
  /// **'Create your account'**
  String get authWelcomeCreate;

  /// No description provided for @authSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Continue building your intentional momentum.'**
  String get authSubtitle;

  /// No description provided for @authCreateSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Your account and data stay on this device. No internet needed.'**
  String get authCreateSubtitle;

  /// No description provided for @authTabSignIn.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get authTabSignIn;

  /// No description provided for @authTabCreate.
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get authTabCreate;

  /// No description provided for @authEmail.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get authEmail;

  /// No description provided for @authEmailHint.
  ///
  /// In en, this message translates to:
  /// **'name@example.com'**
  String get authEmailHint;

  /// No description provided for @authPassword.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get authPassword;

  /// No description provided for @authFullName.
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get authFullName;

  /// No description provided for @authNameHint.
  ///
  /// In en, this message translates to:
  /// **'Omar Al-Farouq'**
  String get authNameHint;

  /// No description provided for @authCreatePassword.
  ///
  /// In en, this message translates to:
  /// **'Create Password'**
  String get authCreatePassword;

  /// No description provided for @authPasswordHint.
  ///
  /// In en, this message translates to:
  /// **'At least 8 characters'**
  String get authPasswordHint;

  /// No description provided for @authShowPassword.
  ///
  /// In en, this message translates to:
  /// **'Show password'**
  String get authShowPassword;

  /// No description provided for @authHidePassword.
  ///
  /// In en, this message translates to:
  /// **'Hide password'**
  String get authHidePassword;

  /// No description provided for @authRememberMe.
  ///
  /// In en, this message translates to:
  /// **'Remember me'**
  String get authRememberMe;

  /// No description provided for @authForgot.
  ///
  /// In en, this message translates to:
  /// **'Forgot password?'**
  String get authForgot;

  /// No description provided for @authRuleLength.
  ///
  /// In en, this message translates to:
  /// **'8+ chars'**
  String get authRuleLength;

  /// No description provided for @authRuleMix.
  ///
  /// In en, this message translates to:
  /// **'Letters & numbers'**
  String get authRuleMix;

  /// No description provided for @authTermsPrefix.
  ///
  /// In en, this message translates to:
  /// **'By joining Taqaddum, you agree to our '**
  String get authTermsPrefix;

  /// No description provided for @authTerms.
  ///
  /// In en, this message translates to:
  /// **'Terms'**
  String get authTerms;

  /// No description provided for @authAnd.
  ///
  /// In en, this message translates to:
  /// **' & '**
  String get authAnd;

  /// No description provided for @authPrivacy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get authPrivacy;

  /// No description provided for @authOrContinue.
  ///
  /// In en, this message translates to:
  /// **'or continue with'**
  String get authOrContinue;

  /// No description provided for @authContinueDevice.
  ///
  /// In en, this message translates to:
  /// **'Continue on this device'**
  String get authContinueDevice;

  /// No description provided for @authNoAccount.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account?'**
  String get authNoAccount;

  /// No description provided for @authHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get authHaveAccount;

  /// No description provided for @authCreateLink.
  ///
  /// In en, this message translates to:
  /// **'Create account'**
  String get authCreateLink;

  /// No description provided for @authSignInLink.
  ///
  /// In en, this message translates to:
  /// **'Sign in'**
  String get authSignInLink;

  /// No description provided for @authErrEmail.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid email address'**
  String get authErrEmail;

  /// No description provided for @authErrPassword.
  ///
  /// In en, this message translates to:
  /// **'Use at least 8 characters with letters and numbers'**
  String get authErrPassword;

  /// No description provided for @authErrPasswordEmpty.
  ///
  /// In en, this message translates to:
  /// **'Enter your password'**
  String get authErrPasswordEmpty;

  /// No description provided for @authErrName.
  ///
  /// In en, this message translates to:
  /// **'Enter your name'**
  String get authErrName;

  /// No description provided for @authErrWrong.
  ///
  /// In en, this message translates to:
  /// **'Email or password doesn\'t match the account on this device.'**
  String get authErrWrong;

  /// No description provided for @authErrNoAccount.
  ///
  /// In en, this message translates to:
  /// **'There\'s no account on this device yet. Create one to begin.'**
  String get authErrNoAccount;

  /// No description provided for @authErrExists.
  ///
  /// In en, this message translates to:
  /// **'This device already has an account. Sign in instead.'**
  String get authErrExists;

  /// No description provided for @authErrPasswordRequired.
  ///
  /// In en, this message translates to:
  /// **'The account on this device is protected by a password. Sign in with your email and password.'**
  String get authErrPasswordRequired;

  /// No description provided for @authResetTitle.
  ///
  /// In en, this message translates to:
  /// **'Reset password'**
  String get authResetTitle;

  /// No description provided for @authResetBody.
  ///
  /// In en, this message translates to:
  /// **'Taqaddum keeps your account only on this device, so there is no email recovery link. If you can\'t remember your password, you can erase this device\'s account and start fresh.'**
  String get authResetBody;

  /// No description provided for @authResetWarning.
  ///
  /// In en, this message translates to:
  /// **'Erasing permanently deletes every goal, log and review stored on this device.'**
  String get authResetWarning;

  /// No description provided for @authResetConfirmLabel.
  ///
  /// In en, this message translates to:
  /// **'Type ERASE to confirm'**
  String get authResetConfirmLabel;

  /// No description provided for @authResetKeyword.
  ///
  /// In en, this message translates to:
  /// **'ERASE'**
  String get authResetKeyword;

  /// No description provided for @authResetButton.
  ///
  /// In en, this message translates to:
  /// **'Erase and start fresh'**
  String get authResetButton;

  /// No description provided for @authResetDone.
  ///
  /// In en, this message translates to:
  /// **'The device account was erased. Create a new account to begin.'**
  String get authResetDone;

  /// No description provided for @authDeviceTitle.
  ///
  /// In en, this message translates to:
  /// **'Continue on this device'**
  String get authDeviceTitle;

  /// No description provided for @authDeviceBody.
  ///
  /// In en, this message translates to:
  /// **'Use Taqaddum without an email or password. Everything stays private on this phone, and you can add a password later in Settings.'**
  String get authDeviceBody;

  /// No description provided for @authDeviceNameLabel.
  ///
  /// In en, this message translates to:
  /// **'What should we call you?'**
  String get authDeviceNameLabel;

  /// No description provided for @authDeviceButton.
  ///
  /// In en, this message translates to:
  /// **'Start'**
  String get authDeviceButton;

  /// No description provided for @authTermsTitle.
  ///
  /// In en, this message translates to:
  /// **'Terms'**
  String get authTermsTitle;

  /// No description provided for @authTermsP1.
  ///
  /// In en, this message translates to:
  /// **'Taqaddum is a personal planning tool. It helps you plan your days, log progress and reflect. It does not give medical, financial or religious rulings.'**
  String get authTermsP1;

  /// No description provided for @authTermsP2.
  ///
  /// In en, this message translates to:
  /// **'Your records are stored only on this device. You are responsible for exporting a copy if you want a backup, because uninstalling the app removes local data.'**
  String get authTermsP2;

  /// No description provided for @authTermsP3.
  ///
  /// In en, this message translates to:
  /// **'The app is provided as-is. Use it in a way that supports your wellbeing.'**
  String get authTermsP3;

  /// No description provided for @authPrivacyTitle.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get authPrivacyTitle;

  /// No description provided for @authPrivacyP1.
  ///
  /// In en, this message translates to:
  /// **'Taqaddum works completely offline. No account data, goals, logs, reviews or finances are sent to any server.'**
  String get authPrivacyP1;

  /// No description provided for @authPrivacyP2.
  ///
  /// In en, this message translates to:
  /// **'Your password is never stored. Only a salted cryptographic hash is kept in the device\'s secure storage.'**
  String get authPrivacyP2;

  /// No description provided for @authPrivacyP3.
  ///
  /// In en, this message translates to:
  /// **'There is no analytics or tracking. Exports are created only when you ask for them and shared only where you choose.'**
  String get authPrivacyP3;

  /// No description provided for @onbStep.
  ///
  /// In en, this message translates to:
  /// **'Step {step} of {total}'**
  String onbStep(int step, int total);

  /// No description provided for @onbAreasTitle.
  ///
  /// In en, this message translates to:
  /// **'What would you like\nto improve?'**
  String get onbAreasTitle;

  /// No description provided for @onbAreasSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Choose what matters most right now.'**
  String get onbAreasSubtitle;

  /// No description provided for @onbAreaQuran.
  ///
  /// In en, this message translates to:
  /// **'Quran & Faith'**
  String get onbAreaQuran;

  /// No description provided for @onbAreaWork.
  ///
  /// In en, this message translates to:
  /// **'Work'**
  String get onbAreaWork;

  /// No description provided for @onbAreaFinance.
  ///
  /// In en, this message translates to:
  /// **'Money'**
  String get onbAreaFinance;

  /// No description provided for @onbAreaHealth.
  ///
  /// In en, this message translates to:
  /// **'Health'**
  String get onbAreaHealth;

  /// No description provided for @onbAreaLearning.
  ///
  /// In en, this message translates to:
  /// **'Learning'**
  String get onbAreaLearning;

  /// No description provided for @onbAreaPersonal.
  ///
  /// In en, this message translates to:
  /// **'Personal Life'**
  String get onbAreaPersonal;

  /// No description provided for @onbAreaQuranHint.
  ///
  /// In en, this message translates to:
  /// **'Consistency'**
  String get onbAreaQuranHint;

  /// No description provided for @onbAreaWorkHint.
  ///
  /// In en, this message translates to:
  /// **'Stay focused'**
  String get onbAreaWorkHint;

  /// No description provided for @onbAreaFinanceHint.
  ///
  /// In en, this message translates to:
  /// **'Track & save'**
  String get onbAreaFinanceHint;

  /// No description provided for @onbAreaHealthHint.
  ///
  /// In en, this message translates to:
  /// **'Feel stronger'**
  String get onbAreaHealthHint;

  /// No description provided for @onbAreaLearningHint.
  ///
  /// In en, this message translates to:
  /// **'Keep growing'**
  String get onbAreaLearningHint;

  /// No description provided for @onbAreaPersonalHint.
  ///
  /// In en, this message translates to:
  /// **'Find balance'**
  String get onbAreaPersonalHint;

  /// No description provided for @onbAreasError.
  ///
  /// In en, this message translates to:
  /// **'Choose at least one area to continue.'**
  String get onbAreasError;

  /// No description provided for @onbTargetsTitle.
  ///
  /// In en, this message translates to:
  /// **'What are your main goals?'**
  String get onbTargetsTitle;

  /// No description provided for @onbTargetsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Select starting targets to set up your momentum. They become daily habits you can check off.'**
  String get onbTargetsSubtitle;

  /// No description provided for @onbAddCustom.
  ///
  /// In en, this message translates to:
  /// **'Add custom target'**
  String get onbAddCustom;

  /// No description provided for @onbCustomTitle.
  ///
  /// In en, this message translates to:
  /// **'Custom target'**
  String get onbCustomTitle;

  /// No description provided for @onbCustomHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. Drink 8 glasses of water'**
  String get onbCustomHint;

  /// No description provided for @onbCustomArea.
  ///
  /// In en, this message translates to:
  /// **'Area'**
  String get onbCustomArea;

  /// No description provided for @onbCustomAdd.
  ///
  /// In en, this message translates to:
  /// **'Add target'**
  String get onbCustomAdd;

  /// No description provided for @onbTargetQuran1.
  ///
  /// In en, this message translates to:
  /// **'Read 1 Hizb daily'**
  String get onbTargetQuran1;

  /// No description provided for @onbTargetQuran2.
  ///
  /// In en, this message translates to:
  /// **'Memorization practice'**
  String get onbTargetQuran2;

  /// No description provided for @onbTargetQuran3.
  ///
  /// In en, this message translates to:
  /// **'Daily morning Adhkar'**
  String get onbTargetQuran3;

  /// No description provided for @onbTargetWork1.
  ///
  /// In en, this message translates to:
  /// **'4 hours deep work'**
  String get onbTargetWork1;

  /// No description provided for @onbTargetWork2.
  ///
  /// In en, this message translates to:
  /// **'Daily follow-ups'**
  String get onbTargetWork2;

  /// No description provided for @onbTargetFinance1.
  ///
  /// In en, this message translates to:
  /// **'Log expenses every evening'**
  String get onbTargetFinance1;

  /// No description provided for @onbTargetFinance2.
  ///
  /// In en, this message translates to:
  /// **'Set aside savings'**
  String get onbTargetFinance2;

  /// No description provided for @onbTargetHealth1.
  ///
  /// In en, this message translates to:
  /// **'Walk 8,000 steps'**
  String get onbTargetHealth1;

  /// No description provided for @onbTargetHealth2.
  ///
  /// In en, this message translates to:
  /// **'Sleep before 11 PM'**
  String get onbTargetHealth2;

  /// No description provided for @onbTargetLearning1.
  ///
  /// In en, this message translates to:
  /// **'Study 30 minutes'**
  String get onbTargetLearning1;

  /// No description provided for @onbTargetLearning2.
  ///
  /// In en, this message translates to:
  /// **'Read 10 pages'**
  String get onbTargetLearning2;

  /// No description provided for @onbTargetPersonal1.
  ///
  /// In en, this message translates to:
  /// **'Quality family time'**
  String get onbTargetPersonal1;

  /// No description provided for @onbTargetPersonal2.
  ///
  /// In en, this message translates to:
  /// **'Call a relative'**
  String get onbTargetPersonal2;

  /// No description provided for @onbPaceTitle.
  ///
  /// In en, this message translates to:
  /// **'How should your day feel?'**
  String get onbPaceTitle;

  /// No description provided for @onbPaceSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Pick your daily pace. Taqaddum adapts to your lifestyle.'**
  String get onbPaceSubtitle;

  /// No description provided for @paceMorning.
  ///
  /// In en, this message translates to:
  /// **'Morning Focus'**
  String get paceMorning;

  /// No description provided for @paceMorningHint.
  ///
  /// In en, this message translates to:
  /// **'High impact goals done early before distractions'**
  String get paceMorningHint;

  /// No description provided for @paceBalanced.
  ///
  /// In en, this message translates to:
  /// **'Balanced Day'**
  String get paceBalanced;

  /// No description provided for @paceBalancedHint.
  ///
  /// In en, this message translates to:
  /// **'Evenly spaced commitments with restful pauses'**
  String get paceBalancedHint;

  /// No description provided for @paceAdaptive.
  ///
  /// In en, this message translates to:
  /// **'Adaptive & Flexible'**
  String get paceAdaptive;

  /// No description provided for @paceAdaptiveHint.
  ///
  /// In en, this message translates to:
  /// **'Fluid schedule that shifts cleanly with demands'**
  String get paceAdaptiveHint;

  /// No description provided for @onbCheckpoints.
  ///
  /// In en, this message translates to:
  /// **'Daily checkpoints'**
  String get onbCheckpoints;

  /// No description provided for @onbMorningCheckpoint.
  ///
  /// In en, this message translates to:
  /// **'Morning intention'**
  String get onbMorningCheckpoint;

  /// No description provided for @onbEveningCheckpoint.
  ///
  /// In en, this message translates to:
  /// **'Evening reflection'**
  String get onbEveningCheckpoint;

  /// No description provided for @onbCheckpointHint.
  ///
  /// In en, this message translates to:
  /// **'Tap the time to change it. You can edit reminders later.'**
  String get onbCheckpointHint;

  /// No description provided for @onbReadyTitle.
  ///
  /// In en, this message translates to:
  /// **'You\'re ready to begin'**
  String get onbReadyTitle;

  /// No description provided for @onbReadySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Your daily system is set to connect habits to purpose.'**
  String get onbReadySubtitle;

  /// No description provided for @onbFocusAreas.
  ///
  /// In en, this message translates to:
  /// **'Focus areas'**
  String get onbFocusAreas;

  /// No description provided for @onbFirstTargets.
  ///
  /// In en, this message translates to:
  /// **'First day targets'**
  String get onbFirstTargets;

  /// No description provided for @onbNoTargets.
  ///
  /// In en, this message translates to:
  /// **'No starting targets selected. You can add habits anytime.'**
  String get onbNoTargets;

  /// No description provided for @onbDailyPace.
  ///
  /// In en, this message translates to:
  /// **'Daily pace:'**
  String get onbDailyPace;

  /// No description provided for @onbReadyNote.
  ///
  /// In en, this message translates to:
  /// **'Small steady steps compound into a remarkable life.'**
  String get onbReadyNote;

  /// No description provided for @onbFinish.
  ///
  /// In en, this message translates to:
  /// **'Set up my first goal'**
  String get onbFinish;

  /// No description provided for @goalSetupHeader.
  ///
  /// In en, this message translates to:
  /// **'Set up your goals'**
  String get goalSetupHeader;

  /// No description provided for @goalNewTitle.
  ///
  /// In en, this message translates to:
  /// **'New goal'**
  String get goalNewTitle;

  /// No description provided for @goalEditTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit goal'**
  String get goalEditTitle;

  /// No description provided for @goalSetupCounter.
  ///
  /// In en, this message translates to:
  /// **'Goal {n} of {total}'**
  String goalSetupCounter(int n, int total);

  /// No description provided for @goalSetupPercent.
  ///
  /// In en, this message translates to:
  /// **'{pct}% setup'**
  String goalSetupPercent(int pct);

  /// No description provided for @goalSetupHeadline.
  ///
  /// In en, this message translates to:
  /// **'Make your goal measurable'**
  String get goalSetupHeadline;

  /// No description provided for @goalSetupSub.
  ///
  /// In en, this message translates to:
  /// **'Clear goals are easier to follow and steadily improve.'**
  String get goalSetupSub;

  /// No description provided for @goalTitleLabel.
  ///
  /// In en, this message translates to:
  /// **'Goal title'**
  String get goalTitleLabel;

  /// No description provided for @goalTitleHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. Save 600,000 DZD'**
  String get goalTitleHint;

  /// No description provided for @goalCategory.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get goalCategory;

  /// No description provided for @goalType.
  ///
  /// In en, this message translates to:
  /// **'Goal type'**
  String get goalType;

  /// No description provided for @goalTypeTarget.
  ///
  /// In en, this message translates to:
  /// **'Target'**
  String get goalTypeTarget;

  /// No description provided for @goalTypeRoutine.
  ///
  /// In en, this message translates to:
  /// **'Routine'**
  String get goalTypeRoutine;

  /// No description provided for @goalTypeMilestone.
  ///
  /// In en, this message translates to:
  /// **'Milestone'**
  String get goalTypeMilestone;

  /// No description provided for @goalTypeTargetHint.
  ///
  /// In en, this message translates to:
  /// **'Reach a number, like pages, hours or savings.'**
  String get goalTypeTargetHint;

  /// No description provided for @goalTypeRoutineHint.
  ///
  /// In en, this message translates to:
  /// **'Repeat something a number of times every day, week or month.'**
  String get goalTypeRoutineHint;

  /// No description provided for @goalTypeMilestoneHint.
  ///
  /// In en, this message translates to:
  /// **'Complete a series of checkpoints.'**
  String get goalTypeMilestoneHint;

  /// No description provided for @goalTargetUnit.
  ///
  /// In en, this message translates to:
  /// **'Target & unit'**
  String get goalTargetUnit;

  /// No description provided for @goalUnit.
  ///
  /// In en, this message translates to:
  /// **'Unit'**
  String get goalUnit;

  /// No description provided for @goalUnitCustom.
  ///
  /// In en, this message translates to:
  /// **'Custom unit'**
  String get goalUnitCustom;

  /// No description provided for @goalUnitCustomHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. books'**
  String get goalUnitCustomHint;

  /// No description provided for @goalStartingPoint.
  ///
  /// In en, this message translates to:
  /// **'Starting point'**
  String get goalStartingPoint;

  /// No description provided for @goalStartingPointHint.
  ///
  /// In en, this message translates to:
  /// **'How much you already have'**
  String get goalStartingPointHint;

  /// No description provided for @goalAccumulated.
  ///
  /// In en, this message translates to:
  /// **'{pct} accumulated'**
  String goalAccumulated(Object pct);

  /// No description provided for @goalRemaining.
  ///
  /// In en, this message translates to:
  /// **'{value} remaining'**
  String goalRemaining(Object value);

  /// No description provided for @goalRoutineTimes.
  ///
  /// In en, this message translates to:
  /// **'Times per period'**
  String get goalRoutineTimes;

  /// No description provided for @goalRoutineEvery.
  ///
  /// In en, this message translates to:
  /// **'Repeats'**
  String get goalRoutineEvery;

  /// No description provided for @goalTargetDate.
  ///
  /// In en, this message translates to:
  /// **'Target date'**
  String get goalTargetDate;

  /// No description provided for @goalNoDate.
  ///
  /// In en, this message translates to:
  /// **'Choose a date'**
  String get goalNoDate;

  /// No description provided for @goalClearDate.
  ///
  /// In en, this message translates to:
  /// **'Remove date'**
  String get goalClearDate;

  /// No description provided for @goalYearsLeft.
  ///
  /// In en, this message translates to:
  /// **'{n, plural, =1{1 yr left} other{{n} yrs left}}'**
  String goalYearsLeft(int n);

  /// No description provided for @goalMonthsLeft.
  ///
  /// In en, this message translates to:
  /// **'{n, plural, =1{1 month left} other{{n} months left}}'**
  String goalMonthsLeft(int n);

  /// No description provided for @goalDaysLeft.
  ///
  /// In en, this message translates to:
  /// **'{n, plural, =1{1 day left} other{{n} days left}}'**
  String goalDaysLeft(int n);

  /// No description provided for @goalPastDate.
  ///
  /// In en, this message translates to:
  /// **'Date passed'**
  String get goalPastDate;

  /// No description provided for @goalWhy.
  ///
  /// In en, this message translates to:
  /// **'Why does this matter?'**
  String get goalWhy;

  /// No description provided for @goalWhyHint.
  ///
  /// In en, this message translates to:
  /// **'The reason you\'ll remember on hard days.'**
  String get goalWhyHint;

  /// No description provided for @goalActionsTitle.
  ///
  /// In en, this message translates to:
  /// **'Actions that move this goal forward'**
  String get goalActionsTitle;

  /// No description provided for @goalActionsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Daily or recurring steps connected to this goal.'**
  String get goalActionsSubtitle;

  /// No description provided for @goalAddAction.
  ///
  /// In en, this message translates to:
  /// **'Add action'**
  String get goalAddAction;

  /// No description provided for @goalEditAction.
  ///
  /// In en, this message translates to:
  /// **'Edit action'**
  String get goalEditAction;

  /// No description provided for @goalActionTitle.
  ///
  /// In en, this message translates to:
  /// **'Action'**
  String get goalActionTitle;

  /// No description provided for @goalActionTitleHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. Save monthly from income'**
  String get goalActionTitleHint;

  /// No description provided for @goalActionDetail.
  ///
  /// In en, this message translates to:
  /// **'Detail'**
  String get goalActionDetail;

  /// No description provided for @goalActionDetailHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. 20,000 DZD every month'**
  String get goalActionDetailHint;

  /// No description provided for @goalFrequency.
  ///
  /// In en, this message translates to:
  /// **'Frequency'**
  String get goalFrequency;

  /// No description provided for @freqDaily.
  ///
  /// In en, this message translates to:
  /// **'Daily'**
  String get freqDaily;

  /// No description provided for @freqWeekly.
  ///
  /// In en, this message translates to:
  /// **'Weekly'**
  String get freqWeekly;

  /// No description provided for @freqMonthly.
  ///
  /// In en, this message translates to:
  /// **'Monthly'**
  String get freqMonthly;

  /// No description provided for @freqOnce.
  ///
  /// In en, this message translates to:
  /// **'Once'**
  String get freqOnce;

  /// No description provided for @goalMilestonesTitle.
  ///
  /// In en, this message translates to:
  /// **'Milestones'**
  String get goalMilestonesTitle;

  /// No description provided for @goalMilestonesSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Progress is the share of milestones completed.'**
  String get goalMilestonesSubtitle;

  /// No description provided for @goalAddMilestone.
  ///
  /// In en, this message translates to:
  /// **'Add milestone'**
  String get goalAddMilestone;

  /// No description provided for @goalMilestoneHint.
  ///
  /// In en, this message translates to:
  /// **'Milestone title'**
  String get goalMilestoneHint;

  /// No description provided for @goalTrajectoryTitle.
  ///
  /// In en, this message translates to:
  /// **'Pace needed'**
  String get goalTrajectoryTitle;

  /// No description provided for @goalTrajectoryBody.
  ///
  /// In en, this message translates to:
  /// **'To reach your target by {date}, aim for about {amount} per month.'**
  String goalTrajectoryBody(Object amount, Object date);

  /// No description provided for @goalTrajectoryDone.
  ///
  /// In en, this message translates to:
  /// **'Your starting point already meets this target.'**
  String get goalTrajectoryDone;

  /// No description provided for @goalTrajectoryNoDate.
  ///
  /// In en, this message translates to:
  /// **'Add a target date to see the pace you need.'**
  String get goalTrajectoryNoDate;

  /// No description provided for @goalRoutineSummary.
  ///
  /// In en, this message translates to:
  /// **'{count} × {period}'**
  String goalRoutineSummary(Object count, Object period);

  /// No description provided for @goalErrTitle.
  ///
  /// In en, this message translates to:
  /// **'Give your goal a title'**
  String get goalErrTitle;

  /// No description provided for @goalErrTarget.
  ///
  /// In en, this message translates to:
  /// **'Enter a target above the starting point'**
  String get goalErrTarget;

  /// No description provided for @goalErrMilestones.
  ///
  /// In en, this message translates to:
  /// **'Add at least one milestone'**
  String get goalErrMilestones;

  /// No description provided for @goalSaveContinue.
  ///
  /// In en, this message translates to:
  /// **'Save & Continue'**
  String get goalSaveContinue;

  /// No description provided for @goalSave.
  ///
  /// In en, this message translates to:
  /// **'Save goal'**
  String get goalSave;

  /// No description provided for @goalFinishSetup.
  ///
  /// In en, this message translates to:
  /// **'Finish setup'**
  String get goalFinishSetup;

  /// No description provided for @goalSavedNext.
  ///
  /// In en, this message translates to:
  /// **'Goal saved. Add another or finish setup.'**
  String get goalSavedNext;

  /// No description provided for @goalMakePrimary.
  ///
  /// In en, this message translates to:
  /// **'Make this my primary focus'**
  String get goalMakePrimary;

  /// No description provided for @langTitle.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get langTitle;

  /// No description provided for @langComingSoon.
  ///
  /// In en, this message translates to:
  /// **'Coming in a future update'**
  String get langComingSoon;

  /// No description provided for @langFootnote.
  ///
  /// In en, this message translates to:
  /// **'Changing the language never changes your goals or records. French is coming in a future update.'**
  String get langFootnote;

  /// No description provided for @todayGreetingMorning.
  ///
  /// In en, this message translates to:
  /// **'Good morning, {name}'**
  String todayGreetingMorning(Object name);

  /// No description provided for @todayGreetingAfternoon.
  ///
  /// In en, this message translates to:
  /// **'Good afternoon, {name}'**
  String todayGreetingAfternoon(Object name);

  /// No description provided for @todayGreetingEvening.
  ///
  /// In en, this message translates to:
  /// **'Good evening, {name}'**
  String todayGreetingEvening(Object name);

  /// No description provided for @todayNotifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get todayNotifications;

  /// No description provided for @todayProfile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get todayProfile;

  /// No description provided for @todayMomentum.
  ///
  /// In en, this message translates to:
  /// **'Today\'s Momentum'**
  String get todayMomentum;

  /// No description provided for @todayVsYesterday.
  ///
  /// In en, this message translates to:
  /// **'{delta} vs yesterday'**
  String todayVsYesterday(Object delta);

  /// No description provided for @todayComplete.
  ///
  /// In en, this message translates to:
  /// **'complete'**
  String get todayComplete;

  /// No description provided for @todayActionsCompleted.
  ///
  /// In en, this message translates to:
  /// **'{done} of {total} actions completed'**
  String todayActionsCompleted(int done, int total);

  /// No description provided for @todayActionsLeft.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{All done} =1{1 action left} other{{count} actions left}}'**
  String todayActionsLeft(int count);

  /// No description provided for @todayEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'Plan your day'**
  String get todayEmptyTitle;

  /// No description provided for @todayEmptyBody.
  ///
  /// In en, this message translates to:
  /// **'Add a few actions for today, or start with a one-minute morning check-in.'**
  String get todayEmptyBody;

  /// No description provided for @todayCheckInTitle.
  ///
  /// In en, this message translates to:
  /// **'Morning check-in'**
  String get todayCheckInTitle;

  /// No description provided for @todayCheckInBody.
  ///
  /// In en, this message translates to:
  /// **'Set your energy and choose today\'s 3 priorities.'**
  String get todayCheckInBody;

  /// No description provided for @todayCheckInCta.
  ///
  /// In en, this message translates to:
  /// **'Start'**
  String get todayCheckInCta;

  /// No description provided for @todayNightTitle.
  ///
  /// In en, this message translates to:
  /// **'Night review'**
  String get todayNightTitle;

  /// No description provided for @todayNightBody.
  ///
  /// In en, this message translates to:
  /// **'Close the day with three quiet questions.'**
  String get todayNightBody;

  /// No description provided for @todayNightCta.
  ///
  /// In en, this message translates to:
  /// **'Review'**
  String get todayNightCta;

  /// No description provided for @todayFocus.
  ///
  /// In en, this message translates to:
  /// **'Today\'s Focus'**
  String get todayFocus;

  /// No description provided for @todayPriorities.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 Priority} other{{count} Priorities}}'**
  String todayPriorities(int count);

  /// No description provided for @todayNoPriorities.
  ///
  /// In en, this message translates to:
  /// **'No priorities chosen yet. Pick up to three that matter most.'**
  String get todayNoPriorities;

  /// No description provided for @todayChoosePriorities.
  ///
  /// In en, this message translates to:
  /// **'Choose priorities'**
  String get todayChoosePriorities;

  /// No description provided for @todayActions.
  ///
  /// In en, this message translates to:
  /// **'Today\'s Actions'**
  String get todayActions;

  /// No description provided for @todayCompletedOf.
  ///
  /// In en, this message translates to:
  /// **'{done} of {total} completed'**
  String todayCompletedOf(int done, int total);

  /// No description provided for @todayAddAction.
  ///
  /// In en, this message translates to:
  /// **'Add action for today'**
  String get todayAddAction;

  /// No description provided for @todayViewPlan.
  ///
  /// In en, this message translates to:
  /// **'View full plan'**
  String get todayViewPlan;

  /// No description provided for @todayMoreActions.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{+1 more action} other{+{count} more actions}}'**
  String todayMoreActions(int count);

  /// No description provided for @todayYourProgress.
  ///
  /// In en, this message translates to:
  /// **'Your Progress'**
  String get todayYourProgress;

  /// No description provided for @todayKeyAreas.
  ///
  /// In en, this message translates to:
  /// **'Key life areas'**
  String get todayKeyAreas;

  /// No description provided for @todayNoGoals.
  ///
  /// In en, this message translates to:
  /// **'Create a goal to see progress across your key life areas.'**
  String get todayNoGoals;

  /// No description provided for @todayCreateGoal.
  ///
  /// In en, this message translates to:
  /// **'Create a goal'**
  String get todayCreateGoal;

  /// No description provided for @todayInsightTitle.
  ///
  /// In en, this message translates to:
  /// **'Momentum pattern'**
  String get todayInsightTitle;

  /// No description provided for @todayInsightArea.
  ///
  /// In en, this message translates to:
  /// **'Your {area} consistency is strongest this week, active {days} of {total} days.'**
  String todayInsightArea(String area, int days, int total);

  /// No description provided for @todayInsightStrongDays.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 strong day so far this week. Keep the rhythm going.} other{{count} strong days so far this week. Keep the rhythm going.}}'**
  String todayInsightStrongDays(int count);

  /// No description provided for @taskNew.
  ///
  /// In en, this message translates to:
  /// **'New action'**
  String get taskNew;

  /// No description provided for @taskEdit.
  ///
  /// In en, this message translates to:
  /// **'Edit action'**
  String get taskEdit;

  /// No description provided for @taskTitle.
  ///
  /// In en, this message translates to:
  /// **'What needs to be done?'**
  String get taskTitle;

  /// No description provided for @taskTitleHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. Prepare client proposal'**
  String get taskTitleHint;

  /// No description provided for @taskArea.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get taskArea;

  /// No description provided for @taskSchedule.
  ///
  /// In en, this message translates to:
  /// **'Schedule'**
  String get taskSchedule;

  /// No description provided for @taskPickDate.
  ///
  /// In en, this message translates to:
  /// **'Date…'**
  String get taskPickDate;

  /// No description provided for @taskTime.
  ///
  /// In en, this message translates to:
  /// **'Time'**
  String get taskTime;

  /// No description provided for @taskAnytime.
  ///
  /// In en, this message translates to:
  /// **'Anytime'**
  String get taskAnytime;

  /// No description provided for @taskDuration.
  ///
  /// In en, this message translates to:
  /// **'Duration'**
  String get taskDuration;

  /// No description provided for @taskNoDuration.
  ///
  /// In en, this message translates to:
  /// **'None'**
  String get taskNoDuration;

  /// No description provided for @taskGoal.
  ///
  /// In en, this message translates to:
  /// **'Related goal'**
  String get taskGoal;

  /// No description provided for @taskNoGoal.
  ///
  /// In en, this message translates to:
  /// **'No goal'**
  String get taskNoGoal;

  /// No description provided for @taskDetail.
  ///
  /// In en, this message translates to:
  /// **'Detail'**
  String get taskDetail;

  /// No description provided for @taskDetailHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. Surah An-Nur or 5 leads'**
  String get taskDetailHint;

  /// No description provided for @taskAdd.
  ///
  /// In en, this message translates to:
  /// **'Add action'**
  String get taskAdd;

  /// No description provided for @taskSave.
  ///
  /// In en, this message translates to:
  /// **'Save changes'**
  String get taskSave;

  /// No description provided for @taskMarkDone.
  ///
  /// In en, this message translates to:
  /// **'Mark as done'**
  String get taskMarkDone;

  /// No description provided for @taskMarkUndone.
  ///
  /// In en, this message translates to:
  /// **'Mark as not done'**
  String get taskMarkUndone;

  /// No description provided for @taskReschedule.
  ///
  /// In en, this message translates to:
  /// **'Reschedule'**
  String get taskReschedule;

  /// No description provided for @taskMakePriority.
  ///
  /// In en, this message translates to:
  /// **'Make a priority'**
  String get taskMakePriority;

  /// No description provided for @taskRemovePriority.
  ///
  /// In en, this message translates to:
  /// **'Remove from priorities'**
  String get taskRemovePriority;

  /// No description provided for @taskDelete.
  ///
  /// In en, this message translates to:
  /// **'Delete action'**
  String get taskDelete;

  /// No description provided for @taskDeleteTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete this action?'**
  String get taskDeleteTitle;

  /// No description provided for @taskDeleteBody.
  ///
  /// In en, this message translates to:
  /// **'The action and its activity entry will be removed from this device.'**
  String get taskDeleteBody;

  /// No description provided for @taskDeleted.
  ///
  /// In en, this message translates to:
  /// **'Action deleted'**
  String get taskDeleted;

  /// No description provided for @taskPriorityFull.
  ///
  /// In en, this message translates to:
  /// **'You already have 3 priorities. Remove one first.'**
  String get taskPriorityFull;

  /// No description provided for @taskAdded.
  ///
  /// In en, this message translates to:
  /// **'Action added'**
  String get taskAdded;

  /// No description provided for @rescheduleTitle.
  ///
  /// In en, this message translates to:
  /// **'Reschedule'**
  String get rescheduleTitle;

  /// No description provided for @rescheduleSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Move this action without pressure.'**
  String get rescheduleSubtitle;

  /// No description provided for @rescheduleLaterToday.
  ///
  /// In en, this message translates to:
  /// **'Later today'**
  String get rescheduleLaterToday;

  /// No description provided for @rescheduleTomorrow.
  ///
  /// In en, this message translates to:
  /// **'Tomorrow'**
  String get rescheduleTomorrow;

  /// No description provided for @rescheduleNextWeek.
  ///
  /// In en, this message translates to:
  /// **'Next week'**
  String get rescheduleNextWeek;

  /// No description provided for @reschedulePick.
  ///
  /// In en, this message translates to:
  /// **'Pick a date'**
  String get reschedulePick;

  /// No description provided for @rescheduleKeepTime.
  ///
  /// In en, this message translates to:
  /// **'Keep time'**
  String get rescheduleKeepTime;

  /// No description provided for @rescheduleConfirm.
  ///
  /// In en, this message translates to:
  /// **'Move action'**
  String get rescheduleConfirm;

  /// No description provided for @rescheduledTo.
  ///
  /// In en, this message translates to:
  /// **'Moved to {date}'**
  String rescheduledTo(Object date);

  /// No description provided for @planTitleToday.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get planTitleToday;

  /// No description provided for @planCalendar.
  ///
  /// In en, this message translates to:
  /// **'Pick a day'**
  String get planCalendar;

  /// No description provided for @planMore.
  ///
  /// In en, this message translates to:
  /// **'More options'**
  String get planMore;

  /// No description provided for @planCompleted.
  ///
  /// In en, this message translates to:
  /// **'{done} of {total} completed'**
  String planCompleted(int done, int total);

  /// No description provided for @planPlanned.
  ///
  /// In en, this message translates to:
  /// **'{time} planned'**
  String planPlanned(Object time);

  /// No description provided for @planLoadLight.
  ///
  /// In en, this message translates to:
  /// **'Today\'s load looks light.'**
  String get planLoadLight;

  /// No description provided for @planLoadBalanced.
  ///
  /// In en, this message translates to:
  /// **'Today\'s load looks balanced.'**
  String get planLoadBalanced;

  /// No description provided for @planLoadHeavy.
  ///
  /// In en, this message translates to:
  /// **'Today\'s load looks heavy. Consider moving something.'**
  String get planLoadHeavy;

  /// No description provided for @capacityLight.
  ///
  /// In en, this message translates to:
  /// **'Light day'**
  String get capacityLight;

  /// No description provided for @capacityBalanced.
  ///
  /// In en, this message translates to:
  /// **'Balanced day'**
  String get capacityBalanced;

  /// No description provided for @capacityFocused.
  ///
  /// In en, this message translates to:
  /// **'Focused day'**
  String get capacityFocused;

  /// No description provided for @capacityLightHint.
  ///
  /// In en, this message translates to:
  /// **'Keep things simple'**
  String get capacityLightHint;

  /// No description provided for @capacityBalancedHint.
  ///
  /// In en, this message translates to:
  /// **'Normal pace'**
  String get capacityBalancedHint;

  /// No description provided for @capacityFocusedHint.
  ///
  /// In en, this message translates to:
  /// **'More deep work'**
  String get capacityFocusedHint;

  /// No description provided for @planTopPriorities.
  ///
  /// In en, this message translates to:
  /// **'Top priorities'**
  String get planTopPriorities;

  /// No description provided for @planReorder.
  ///
  /// In en, this message translates to:
  /// **'Reorder'**
  String get planReorder;

  /// No description provided for @planDoneReorder.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get planDoneReorder;

  /// No description provided for @planMorning.
  ///
  /// In en, this message translates to:
  /// **'Morning'**
  String get planMorning;

  /// No description provided for @planAfternoon.
  ///
  /// In en, this message translates to:
  /// **'Afternoon'**
  String get planAfternoon;

  /// No description provided for @planEvening.
  ///
  /// In en, this message translates to:
  /// **'Evening'**
  String get planEvening;

  /// No description provided for @planAnytime.
  ///
  /// In en, this message translates to:
  /// **'Anytime'**
  String get planAnytime;

  /// No description provided for @planSectionCount.
  ///
  /// In en, this message translates to:
  /// **'{label} · {count}'**
  String planSectionCount(String label, int count);

  /// No description provided for @planDoneCount.
  ///
  /// In en, this message translates to:
  /// **'{count} done'**
  String planDoneCount(int count);

  /// No description provided for @planAddAction.
  ///
  /// In en, this message translates to:
  /// **'Add action for this day'**
  String get planAddAction;

  /// No description provided for @planAllSet.
  ///
  /// In en, this message translates to:
  /// **'All set. Reschedule or shift actions anytime.'**
  String get planAllSet;

  /// No description provided for @planAllDone.
  ///
  /// In en, this message translates to:
  /// **'Everything planned for this day is done.'**
  String get planAllDone;

  /// No description provided for @planEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'Nothing planned yet'**
  String get planEmptyTitle;

  /// No description provided for @planEmptyBody.
  ///
  /// In en, this message translates to:
  /// **'Add an action or start a morning check-in to shape the day.'**
  String get planEmptyBody;

  /// No description provided for @planMoveUnfinished.
  ///
  /// In en, this message translates to:
  /// **'Move unfinished to tomorrow'**
  String get planMoveUnfinished;

  /// No description provided for @planMovedCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 action moved to tomorrow} other{{count} actions moved to tomorrow}}'**
  String planMovedCount(int count);

  /// No description provided for @planClearCompleted.
  ///
  /// In en, this message translates to:
  /// **'Hide completed'**
  String get planClearCompleted;

  /// No description provided for @planShowCompleted.
  ///
  /// In en, this message translates to:
  /// **'Show completed'**
  String get planShowCompleted;

  /// No description provided for @planPastDay.
  ///
  /// In en, this message translates to:
  /// **'This day has passed. You can still complete or move actions.'**
  String get planPastDay;

  /// No description provided for @checkInHint.
  ///
  /// In en, this message translates to:
  /// **'Takes less than a minute'**
  String get checkInHint;

  /// No description provided for @checkInTitle.
  ///
  /// In en, this message translates to:
  /// **'Morning check-in'**
  String get checkInTitle;

  /// No description provided for @checkInHeadline.
  ///
  /// In en, this message translates to:
  /// **'Good morning, {name}'**
  String checkInHeadline(Object name);

  /// No description provided for @checkInSub.
  ///
  /// In en, this message translates to:
  /// **'Let\'s set the tone for today.'**
  String get checkInSub;

  /// No description provided for @checkInEnergy.
  ///
  /// In en, this message translates to:
  /// **'How\'s your energy?'**
  String get checkInEnergy;

  /// No description provided for @checkInEnergyHint.
  ///
  /// In en, this message translates to:
  /// **'Honest baseline'**
  String get checkInEnergyHint;

  /// No description provided for @energyLow.
  ///
  /// In en, this message translates to:
  /// **'Low'**
  String get energyLow;

  /// No description provided for @energySteady.
  ///
  /// In en, this message translates to:
  /// **'Steady'**
  String get energySteady;

  /// No description provided for @energyHigh.
  ///
  /// In en, this message translates to:
  /// **'High'**
  String get energyHigh;

  /// No description provided for @checkInPriorities.
  ///
  /// In en, this message translates to:
  /// **'What matters most today?'**
  String get checkInPriorities;

  /// No description provided for @checkInPrioritiesHint.
  ///
  /// In en, this message translates to:
  /// **'Choose up to 3 priorities.'**
  String get checkInPrioritiesHint;

  /// No description provided for @checkInSelected.
  ///
  /// In en, this message translates to:
  /// **'{count} of 3'**
  String checkInSelected(int count);

  /// No description provided for @checkInAddCustom.
  ///
  /// In en, this message translates to:
  /// **'Add custom priority'**
  String get checkInAddCustom;

  /// No description provided for @checkInCustomTitle.
  ///
  /// In en, this message translates to:
  /// **'Custom priority'**
  String get checkInCustomTitle;

  /// No description provided for @checkInCustomHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. Finish client proposal'**
  String get checkInCustomHint;

  /// No description provided for @checkInNoTasks.
  ///
  /// In en, this message translates to:
  /// **'No actions planned for today yet. Add a custom priority to begin.'**
  String get checkInNoTasks;

  /// No description provided for @checkInCapacity.
  ///
  /// In en, this message translates to:
  /// **'How much can you realistically take on?'**
  String get checkInCapacity;

  /// No description provided for @checkInCapacityHint.
  ///
  /// In en, this message translates to:
  /// **'Calibrate your daily expectation.'**
  String get checkInCapacityHint;

  /// No description provided for @checkInIntention.
  ///
  /// In en, this message translates to:
  /// **'Daily intention'**
  String get checkInIntention;

  /// No description provided for @checkInIntentionHint.
  ///
  /// In en, this message translates to:
  /// **'Stay focused and avoid unnecessary meetings.'**
  String get checkInIntentionHint;

  /// No description provided for @checkInStart.
  ///
  /// In en, this message translates to:
  /// **'Start My Day'**
  String get checkInStart;

  /// No description provided for @checkInSkip.
  ///
  /// In en, this message translates to:
  /// **'Skip for today'**
  String get checkInSkip;

  /// No description provided for @checkInMax.
  ///
  /// In en, this message translates to:
  /// **'You can choose up to 3 priorities.'**
  String get checkInMax;

  /// No description provided for @nightTitle.
  ///
  /// In en, this message translates to:
  /// **'Night review'**
  String get nightTitle;

  /// No description provided for @nightBadge.
  ///
  /// In en, this message translates to:
  /// **'2 min wrap-up'**
  String get nightBadge;

  /// No description provided for @nightHeadline.
  ///
  /// In en, this message translates to:
  /// **'How did today feel?'**
  String get nightHeadline;

  /// No description provided for @nightSub.
  ///
  /// In en, this message translates to:
  /// **'Take a brief pause to close your day with clear intention.'**
  String get nightSub;

  /// No description provided for @nightRating.
  ///
  /// In en, this message translates to:
  /// **'How was your day?'**
  String get nightRating;

  /// No description provided for @nightHard.
  ///
  /// In en, this message translates to:
  /// **'1 Hard'**
  String get nightHard;

  /// No description provided for @nightOkay.
  ///
  /// In en, this message translates to:
  /// **'3 Okay'**
  String get nightOkay;

  /// No description provided for @nightGreat.
  ///
  /// In en, this message translates to:
  /// **'5 Great'**
  String get nightGreat;

  /// No description provided for @nightSummary.
  ///
  /// In en, this message translates to:
  /// **'Today\'s summary'**
  String get nightSummary;

  /// No description provided for @nightPercent.
  ///
  /// In en, this message translates to:
  /// **'{pct}% Complete'**
  String nightPercent(int pct);

  /// No description provided for @nightActions.
  ///
  /// In en, this message translates to:
  /// **'{done} of {total} actions'**
  String nightActions(int done, int total);

  /// No description provided for @nightRemaining.
  ///
  /// In en, this message translates to:
  /// **'{count} remaining'**
  String nightRemaining(int count);

  /// No description provided for @nightNoPlan.
  ///
  /// In en, this message translates to:
  /// **'No actions were planned today. Your logs still count.'**
  String get nightNoPlan;

  /// No description provided for @nightToneStrong.
  ///
  /// In en, this message translates to:
  /// **'A strong day. Well done showing up.'**
  String get nightToneStrong;

  /// No description provided for @nightToneSteady.
  ///
  /// In en, this message translates to:
  /// **'A solid day. Steady forward momentum for tomorrow.'**
  String get nightToneSteady;

  /// No description provided for @nightToneLight.
  ///
  /// In en, this message translates to:
  /// **'A lighter day. Tomorrow is a fresh start.'**
  String get nightToneLight;

  /// No description provided for @nightWentWell.
  ///
  /// In en, this message translates to:
  /// **'What went well?'**
  String get nightWentWell;

  /// No description provided for @nightWentWellHint.
  ///
  /// In en, this message translates to:
  /// **'Optional reflection notes…'**
  String get nightWentWellHint;

  /// No description provided for @nightBetter.
  ///
  /// In en, this message translates to:
  /// **'What could be better tomorrow?'**
  String get nightBetter;

  /// No description provided for @nightBetterHint.
  ///
  /// In en, this message translates to:
  /// **'What small tweak helps tomorrow?'**
  String get nightBetterHint;

  /// No description provided for @tagFocused.
  ///
  /// In en, this message translates to:
  /// **'Focused'**
  String get tagFocused;

  /// No description provided for @tagGoodEnergy.
  ///
  /// In en, this message translates to:
  /// **'Good energy'**
  String get tagGoodEnergy;

  /// No description provided for @tagQuranDone.
  ///
  /// In en, this message translates to:
  /// **'Quran done'**
  String get tagQuranDone;

  /// No description provided for @tagProgressWork.
  ///
  /// In en, this message translates to:
  /// **'Progress at work'**
  String get tagProgressWork;

  /// No description provided for @tagMoved.
  ///
  /// In en, this message translates to:
  /// **'Moved my body'**
  String get tagMoved;

  /// No description provided for @tagFamily.
  ///
  /// In en, this message translates to:
  /// **'Family time'**
  String get tagFamily;

  /// No description provided for @tagDistracted.
  ///
  /// In en, this message translates to:
  /// **'Distracted'**
  String get tagDistracted;

  /// No description provided for @tagOverplanned.
  ///
  /// In en, this message translates to:
  /// **'Overplanned'**
  String get tagOverplanned;

  /// No description provided for @tagLateStart.
  ///
  /// In en, this message translates to:
  /// **'Late start'**
  String get tagLateStart;

  /// No description provided for @tagMissedWorkout.
  ///
  /// In en, this message translates to:
  /// **'Missed workout'**
  String get tagMissedWorkout;

  /// No description provided for @tagTired.
  ///
  /// In en, this message translates to:
  /// **'Tired'**
  String get tagTired;

  /// No description provided for @tagTooManyMeetings.
  ///
  /// In en, this message translates to:
  /// **'Too many meetings'**
  String get tagTooManyMeetings;

  /// No description provided for @nightUnfinished.
  ///
  /// In en, this message translates to:
  /// **'Unfinished actions'**
  String get nightUnfinished;

  /// No description provided for @nightUnfinishedHint.
  ///
  /// In en, this message translates to:
  /// **'Shift to tomorrow or reschedule without pressure.'**
  String get nightUnfinishedHint;

  /// No description provided for @nightMoveTomorrow.
  ///
  /// In en, this message translates to:
  /// **'Tomorrow'**
  String get nightMoveTomorrow;

  /// No description provided for @nightMoving.
  ///
  /// In en, this message translates to:
  /// **'Moving'**
  String get nightMoving;

  /// No description provided for @nightAllDone.
  ///
  /// In en, this message translates to:
  /// **'Everything planned today is done.'**
  String get nightAllDone;

  /// No description provided for @nightTomorrow.
  ///
  /// In en, this message translates to:
  /// **'Tomorrow at a glance'**
  String get nightTomorrow;

  /// No description provided for @nightTomorrowEmpty.
  ///
  /// In en, this message translates to:
  /// **'Nothing scheduled for tomorrow yet.'**
  String get nightTomorrowEmpty;

  /// No description provided for @nightTomorrowReady.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 action ready for tomorrow} other{{count} actions ready for tomorrow}}'**
  String nightTomorrowReady(int count);

  /// No description provided for @nightComplete.
  ///
  /// In en, this message translates to:
  /// **'Complete Day'**
  String get nightComplete;

  /// No description provided for @nightSkip.
  ///
  /// In en, this message translates to:
  /// **'Skip review for now'**
  String get nightSkip;

  /// No description provided for @nightSaved.
  ///
  /// In en, this message translates to:
  /// **'Day closed. Rest well.'**
  String get nightSaved;

  /// No description provided for @nightAlreadyDone.
  ///
  /// In en, this message translates to:
  /// **'You reviewed this day. Saving again will update it.'**
  String get nightAlreadyDone;

  /// No description provided for @quickAddTitle.
  ///
  /// In en, this message translates to:
  /// **'Quick Add'**
  String get quickAddTitle;

  /// No description provided for @quickAddSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Add something without leaving your flow.'**
  String get quickAddSubtitle;

  /// No description provided for @quickTask.
  ///
  /// In en, this message translates to:
  /// **'Task'**
  String get quickTask;

  /// No description provided for @quickTaskHint.
  ///
  /// In en, this message translates to:
  /// **'Add something to do'**
  String get quickTaskHint;

  /// No description provided for @quickQuran.
  ///
  /// In en, this message translates to:
  /// **'Quran'**
  String get quickQuran;

  /// No description provided for @quickQuranHint.
  ///
  /// In en, this message translates to:
  /// **'Log today\'s progress'**
  String get quickQuranHint;

  /// No description provided for @quickMoney.
  ///
  /// In en, this message translates to:
  /// **'Money'**
  String get quickMoney;

  /// No description provided for @quickMoneyHint.
  ///
  /// In en, this message translates to:
  /// **'Income or expense'**
  String get quickMoneyHint;

  /// No description provided for @quickWork.
  ///
  /// In en, this message translates to:
  /// **'Work'**
  String get quickWork;

  /// No description provided for @quickWorkHint.
  ///
  /// In en, this message translates to:
  /// **'Lead, meeting or call'**
  String get quickWorkHint;

  /// No description provided for @quickHabit.
  ///
  /// In en, this message translates to:
  /// **'Habit'**
  String get quickHabit;

  /// No description provided for @quickHabitHint.
  ///
  /// In en, this message translates to:
  /// **'Build consistency'**
  String get quickHabitHint;

  /// No description provided for @quickNote.
  ///
  /// In en, this message translates to:
  /// **'Note'**
  String get quickNote;

  /// No description provided for @quickNoteHint.
  ///
  /// In en, this message translates to:
  /// **'Capture quickly'**
  String get quickNoteHint;

  /// No description provided for @quickSuggested.
  ///
  /// In en, this message translates to:
  /// **'Suggested actions'**
  String get quickSuggested;

  /// No description provided for @quickSuggestQuran.
  ///
  /// In en, this message translates to:
  /// **'Log {pages} Quran pages'**
  String quickSuggestQuran(int pages);

  /// No description provided for @quickSuggestExpense.
  ///
  /// In en, this message translates to:
  /// **'Add expense'**
  String get quickSuggestExpense;

  /// No description provided for @quickSuggestLeads.
  ///
  /// In en, this message translates to:
  /// **'Contact leads'**
  String get quickSuggestLeads;

  /// No description provided for @quickSuggestNightReview.
  ///
  /// In en, this message translates to:
  /// **'Night review'**
  String get quickSuggestNightReview;

  /// No description provided for @quickSuggestCheckIn.
  ///
  /// In en, this message translates to:
  /// **'Morning check-in'**
  String get quickSuggestCheckIn;

  /// No description provided for @noteTitle.
  ///
  /// In en, this message translates to:
  /// **'Quick note'**
  String get noteTitle;

  /// No description provided for @noteHint.
  ///
  /// In en, this message translates to:
  /// **'What\'s on your mind?'**
  String get noteHint;

  /// No description provided for @noteArea.
  ///
  /// In en, this message translates to:
  /// **'Area'**
  String get noteArea;

  /// No description provided for @noteSave.
  ///
  /// In en, this message translates to:
  /// **'Save note'**
  String get noteSave;

  /// No description provided for @noteSaved.
  ///
  /// In en, this message translates to:
  /// **'Note saved'**
  String get noteSaved;

  /// No description provided for @loggedToast.
  ///
  /// In en, this message translates to:
  /// **'Logged'**
  String get loggedToast;

  /// No description provided for @quranLogTitle.
  ///
  /// In en, this message translates to:
  /// **'Log Quran'**
  String get quranLogTitle;

  /// No description provided for @quranReading.
  ///
  /// In en, this message translates to:
  /// **'Reading'**
  String get quranReading;

  /// No description provided for @quranMemorization.
  ///
  /// In en, this message translates to:
  /// **'Memorization'**
  String get quranMemorization;

  /// No description provided for @quranRevision.
  ///
  /// In en, this message translates to:
  /// **'Revision'**
  String get quranRevision;

  /// No description provided for @quranSurah.
  ///
  /// In en, this message translates to:
  /// **'Surah'**
  String get quranSurah;

  /// No description provided for @quranPickSurah.
  ///
  /// In en, this message translates to:
  /// **'Choose a surah'**
  String get quranPickSurah;

  /// No description provided for @quranPagesRead.
  ///
  /// In en, this message translates to:
  /// **'Pages read'**
  String get quranPagesRead;

  /// No description provided for @quranPagesMemorized.
  ///
  /// In en, this message translates to:
  /// **'Pages memorized'**
  String get quranPagesMemorized;

  /// No description provided for @quranPagesRevised.
  ///
  /// In en, this message translates to:
  /// **'Pages revised'**
  String get quranPagesRevised;

  /// No description provided for @quranMinutes.
  ///
  /// In en, this message translates to:
  /// **'Minutes'**
  String get quranMinutes;

  /// No description provided for @quranPortion.
  ///
  /// In en, this message translates to:
  /// **'Portion'**
  String get quranPortion;

  /// No description provided for @quranPortionHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. Pages 18–21'**
  String get quranPortionHint;

  /// No description provided for @quranApproxMinutes.
  ///
  /// In en, this message translates to:
  /// **'About {minutes} minutes'**
  String quranApproxMinutes(int minutes);

  /// No description provided for @quranSaveReading.
  ///
  /// In en, this message translates to:
  /// **'Save reading'**
  String get quranSaveReading;

  /// No description provided for @quranSaveMemorization.
  ///
  /// In en, this message translates to:
  /// **'Save memorization'**
  String get quranSaveMemorization;

  /// No description provided for @quranSaveRevision.
  ///
  /// In en, this message translates to:
  /// **'Save revision'**
  String get quranSaveRevision;

  /// No description provided for @moneyTitle.
  ///
  /// In en, this message translates to:
  /// **'Add transaction'**
  String get moneyTitle;

  /// No description provided for @moneyExpense.
  ///
  /// In en, this message translates to:
  /// **'Expense'**
  String get moneyExpense;

  /// No description provided for @moneyIncome.
  ///
  /// In en, this message translates to:
  /// **'Income'**
  String get moneyIncome;

  /// No description provided for @moneySaving.
  ///
  /// In en, this message translates to:
  /// **'Saving'**
  String get moneySaving;

  /// No description provided for @moneyAmount.
  ///
  /// In en, this message translates to:
  /// **'Amount'**
  String get moneyAmount;

  /// No description provided for @moneyAmountError.
  ///
  /// In en, this message translates to:
  /// **'Enter an amount above zero'**
  String get moneyAmountError;

  /// No description provided for @moneyCategory.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get moneyCategory;

  /// No description provided for @moneyOther.
  ///
  /// In en, this message translates to:
  /// **'Other…'**
  String get moneyOther;

  /// No description provided for @moneyCustomCategory.
  ///
  /// In en, this message translates to:
  /// **'Custom category'**
  String get moneyCustomCategory;

  /// No description provided for @moneyCustomHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. Car repair'**
  String get moneyCustomHint;

  /// No description provided for @moneyTag.
  ///
  /// In en, this message translates to:
  /// **'Type'**
  String get moneyTag;

  /// No description provided for @moneyPersonal.
  ///
  /// In en, this message translates to:
  /// **'Personal'**
  String get moneyPersonal;

  /// No description provided for @moneyBusiness.
  ///
  /// In en, this message translates to:
  /// **'Business'**
  String get moneyBusiness;

  /// No description provided for @moneyNote.
  ///
  /// In en, this message translates to:
  /// **'Note'**
  String get moneyNote;

  /// No description provided for @moneyDate.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get moneyDate;

  /// No description provided for @moneySave.
  ///
  /// In en, this message translates to:
  /// **'Add transaction'**
  String get moneySave;

  /// No description provided for @catFood.
  ///
  /// In en, this message translates to:
  /// **'Food'**
  String get catFood;

  /// No description provided for @catTransport.
  ///
  /// In en, this message translates to:
  /// **'Transport'**
  String get catTransport;

  /// No description provided for @catHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get catHome;

  /// No description provided for @catBills.
  ///
  /// In en, this message translates to:
  /// **'Bills'**
  String get catBills;

  /// No description provided for @catFamily.
  ///
  /// In en, this message translates to:
  /// **'Family'**
  String get catFamily;

  /// No description provided for @catHealth.
  ///
  /// In en, this message translates to:
  /// **'Health'**
  String get catHealth;

  /// No description provided for @catEducation.
  ///
  /// In en, this message translates to:
  /// **'Education'**
  String get catEducation;

  /// No description provided for @catBusiness.
  ///
  /// In en, this message translates to:
  /// **'Business'**
  String get catBusiness;

  /// No description provided for @catShopping.
  ///
  /// In en, this message translates to:
  /// **'Shopping'**
  String get catShopping;

  /// No description provided for @catSalary.
  ///
  /// In en, this message translates to:
  /// **'Salary'**
  String get catSalary;

  /// No description provided for @catClientPayment.
  ///
  /// In en, this message translates to:
  /// **'Client payment'**
  String get catClientPayment;

  /// No description provided for @catFreelance.
  ///
  /// In en, this message translates to:
  /// **'Freelance'**
  String get catFreelance;

  /// No description provided for @catGift.
  ///
  /// In en, this message translates to:
  /// **'Gift'**
  String get catGift;

  /// No description provided for @catEmergency.
  ///
  /// In en, this message translates to:
  /// **'Emergency fund'**
  String get catEmergency;

  /// No description provided for @catSavingsGoal.
  ///
  /// In en, this message translates to:
  /// **'Savings goal'**
  String get catSavingsGoal;

  /// No description provided for @catInvestment.
  ///
  /// In en, this message translates to:
  /// **'Investment'**
  String get catInvestment;

  /// No description provided for @workLogTitle.
  ///
  /// In en, this message translates to:
  /// **'Log work'**
  String get workLogTitle;

  /// No description provided for @workDeepWork.
  ///
  /// In en, this message translates to:
  /// **'Deep work'**
  String get workDeepWork;

  /// No description provided for @workLead.
  ///
  /// In en, this message translates to:
  /// **'Lead'**
  String get workLead;

  /// No description provided for @workFollowUp.
  ///
  /// In en, this message translates to:
  /// **'Follow-up'**
  String get workFollowUp;

  /// No description provided for @workMeeting.
  ///
  /// In en, this message translates to:
  /// **'Meeting'**
  String get workMeeting;

  /// No description provided for @workProposal.
  ///
  /// In en, this message translates to:
  /// **'Proposal'**
  String get workProposal;

  /// No description provided for @workClientWon.
  ///
  /// In en, this message translates to:
  /// **'Client won'**
  String get workClientWon;

  /// No description provided for @workTitle.
  ///
  /// In en, this message translates to:
  /// **'Title'**
  String get workTitle;

  /// No description provided for @workTitleDeepHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. Client proposal'**
  String get workTitleDeepHint;

  /// No description provided for @workTitleLeadHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. ERP system overhaul'**
  String get workTitleLeadHint;

  /// No description provided for @workTitleFollowHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. Send revised quote'**
  String get workTitleFollowHint;

  /// No description provided for @workTitleMeetingHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. Website + CRM presentation'**
  String get workTitleMeetingHint;

  /// No description provided for @workTitleProposalHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. Stock management sync'**
  String get workTitleProposalHint;

  /// No description provided for @workTitleWonHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. Annual support contract'**
  String get workTitleWonHint;

  /// No description provided for @workCounterpart.
  ///
  /// In en, this message translates to:
  /// **'Client or company'**
  String get workCounterpart;

  /// No description provided for @workCounterpartHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. Atlas Construction'**
  String get workCounterpartHint;

  /// No description provided for @workDuration.
  ///
  /// In en, this message translates to:
  /// **'Duration'**
  String get workDuration;

  /// No description provided for @workValue.
  ///
  /// In en, this message translates to:
  /// **'Deal value'**
  String get workValue;

  /// No description provided for @workWhen.
  ///
  /// In en, this message translates to:
  /// **'When'**
  String get workWhen;

  /// No description provided for @workNow.
  ///
  /// In en, this message translates to:
  /// **'Now'**
  String get workNow;

  /// No description provided for @workSave.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get workSave;

  /// No description provided for @habitQuickTitle.
  ///
  /// In en, this message translates to:
  /// **'Habits today'**
  String get habitQuickTitle;

  /// No description provided for @habitNew.
  ///
  /// In en, this message translates to:
  /// **'New habit'**
  String get habitNew;

  /// No description provided for @habitName.
  ///
  /// In en, this message translates to:
  /// **'Habit'**
  String get habitName;

  /// No description provided for @habitNameHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. Walk 8,000 steps'**
  String get habitNameHint;

  /// No description provided for @habitArea.
  ///
  /// In en, this message translates to:
  /// **'Area'**
  String get habitArea;

  /// No description provided for @habitReminder.
  ///
  /// In en, this message translates to:
  /// **'Reminder'**
  String get habitReminder;

  /// No description provided for @habitNoReminder.
  ///
  /// In en, this message translates to:
  /// **'No reminder'**
  String get habitNoReminder;

  /// No description provided for @habitAdd.
  ///
  /// In en, this message translates to:
  /// **'Add habit'**
  String get habitAdd;

  /// No description provided for @habitEmpty.
  ///
  /// In en, this message translates to:
  /// **'No habits yet. Add one to build steady consistency.'**
  String get habitEmpty;

  /// No description provided for @habitDoneCount.
  ///
  /// In en, this message translates to:
  /// **'{done} of {total} done today'**
  String habitDoneCount(int done, int total);

  /// No description provided for @commonDaysAgo.
  ///
  /// In en, this message translates to:
  /// **'{n, plural, =0{today} =1{yesterday} other{{n} days ago}}'**
  String commonDaysAgo(int n);

  /// No description provided for @commonHistory.
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get commonHistory;

  /// No description provided for @commonShowMore.
  ///
  /// In en, this message translates to:
  /// **'Show more'**
  String get commonShowMore;

  /// No description provided for @commonShowLess.
  ///
  /// In en, this message translates to:
  /// **'Show less'**
  String get commonShowLess;

  /// No description provided for @commonTargets.
  ///
  /// In en, this message translates to:
  /// **'Daily targets'**
  String get commonTargets;

  /// No description provided for @commonDeleteEntry.
  ///
  /// In en, this message translates to:
  /// **'Delete entry'**
  String get commonDeleteEntry;

  /// No description provided for @commonDeleteEntryBody.
  ///
  /// In en, this message translates to:
  /// **'This removes the entry and any goal progress it added.'**
  String get commonDeleteEntryBody;

  /// No description provided for @commonTodayAt.
  ///
  /// In en, this message translates to:
  /// **'Today · {time}'**
  String commonTodayAt(Object time);

  /// No description provided for @commonYesterdayAt.
  ///
  /// In en, this message translates to:
  /// **'Yesterday · {time}'**
  String commonYesterdayAt(Object time);

  /// No description provided for @commonDateAt.
  ///
  /// In en, this message translates to:
  /// **'{date} · {time}'**
  String commonDateAt(Object date, Object time);

  /// No description provided for @goalMiniMilestones.
  ///
  /// In en, this message translates to:
  /// **'{done} of {total} milestones completed'**
  String goalMiniMilestones(int done, int total);

  /// No description provided for @goalMiniRoutineDay.
  ///
  /// In en, this message translates to:
  /// **'{done} of {total} today'**
  String goalMiniRoutineDay(int done, int total);

  /// No description provided for @goalMiniRoutineWeek.
  ///
  /// In en, this message translates to:
  /// **'{done} of {total} this week'**
  String goalMiniRoutineWeek(int done, int total);

  /// No description provided for @goalMiniRoutineMonth.
  ///
  /// In en, this message translates to:
  /// **'{done} of {total} this month'**
  String goalMiniRoutineMonth(int done, int total);

  /// No description provided for @goalTargetOn.
  ///
  /// In en, this message translates to:
  /// **'Target: {date}'**
  String goalTargetOn(Object date);

  /// No description provided for @goalAddForArea.
  ///
  /// In en, this message translates to:
  /// **'Add a goal'**
  String get goalAddForArea;

  /// No description provided for @goalAddForAreaBody.
  ///
  /// In en, this message translates to:
  /// **'Link a goal to this area and your logs will move it forward automatically.'**
  String get goalAddForAreaBody;

  /// No description provided for @quranTitle.
  ///
  /// In en, this message translates to:
  /// **'Quran'**
  String get quranTitle;

  /// No description provided for @quranSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Reading, memorization, and revision.'**
  String get quranSubtitle;

  /// No description provided for @quranDailyRoutine.
  ///
  /// In en, this message translates to:
  /// **'Daily routine'**
  String get quranDailyRoutine;

  /// No description provided for @quranRoutineDone.
  ///
  /// In en, this message translates to:
  /// **'{done} of {total} completed'**
  String quranRoutineDone(int done, int total);

  /// No description provided for @quranPagesOf.
  ///
  /// In en, this message translates to:
  /// **'{done} / {target} pages'**
  String quranPagesOf(Object done, Object target);

  /// No description provided for @quranPageOf.
  ///
  /// In en, this message translates to:
  /// **'{done} / {target} page'**
  String quranPageOf(Object done, Object target);

  /// No description provided for @quranMinutesOf.
  ///
  /// In en, this message translates to:
  /// **'{done} / {target} min'**
  String quranMinutesOf(Object done, Object target);

  /// No description provided for @quranLogProgress.
  ///
  /// In en, this message translates to:
  /// **'Log progress'**
  String get quranLogProgress;

  /// No description provided for @quranCurrentMemo.
  ///
  /// In en, this message translates to:
  /// **'Current memorization'**
  String get quranCurrentMemo;

  /// No description provided for @quranSurahBadge.
  ///
  /// In en, this message translates to:
  /// **'Surah {n}'**
  String quranSurahBadge(int n);

  /// No description provided for @quranPagesOfSurah.
  ///
  /// In en, this message translates to:
  /// **'{done} of {total} pages'**
  String quranPagesOfSurah(Object done, Object total);

  /// No description provided for @quranNextStep.
  ///
  /// In en, this message translates to:
  /// **'Next · {amount} page'**
  String quranNextStep(Object amount);

  /// No description provided for @quranContinue.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get quranContinue;

  /// No description provided for @quranNoMemoTitle.
  ///
  /// In en, this message translates to:
  /// **'No memorization yet'**
  String get quranNoMemoTitle;

  /// No description provided for @quranNoMemoBody.
  ///
  /// In en, this message translates to:
  /// **'Log a memorization session to follow your current surah here.'**
  String get quranNoMemoBody;

  /// No description provided for @quranStartMemo.
  ///
  /// In en, this message translates to:
  /// **'Log memorization'**
  String get quranStartMemo;

  /// No description provided for @quranGoal.
  ///
  /// In en, this message translates to:
  /// **'Quran goal'**
  String get quranGoal;

  /// No description provided for @quranRevisionTitle.
  ///
  /// In en, this message translates to:
  /// **'Revision'**
  String get quranRevisionTitle;

  /// No description provided for @quranActiveSchedule.
  ///
  /// In en, this message translates to:
  /// **'Active schedule'**
  String get quranActiveSchedule;

  /// No description provided for @quranLastReviewed.
  ///
  /// In en, this message translates to:
  /// **'Last reviewed {when}'**
  String quranLastReviewed(Object when);

  /// No description provided for @quranReviewToday.
  ///
  /// In en, this message translates to:
  /// **'Review today'**
  String get quranReviewToday;

  /// No description provided for @quranStrong.
  ///
  /// In en, this message translates to:
  /// **'Strong'**
  String get quranStrong;

  /// No description provided for @quranNoRevision.
  ///
  /// In en, this message translates to:
  /// **'Portions you memorize or revise will appear here with a gentle review schedule.'**
  String get quranNoRevision;

  /// No description provided for @quranConsistency.
  ///
  /// In en, this message translates to:
  /// **'Consistency'**
  String get quranConsistency;

  /// No description provided for @quranConsistencyCount.
  ///
  /// In en, this message translates to:
  /// **'{active} of last {days} days'**
  String quranConsistencyCount(int active, int days);

  /// No description provided for @quranConsistencyHint.
  ///
  /// In en, this message translates to:
  /// **'Steady forward movement over rigid streaks.'**
  String get quranConsistencyHint;

  /// No description provided for @quranNoteStart.
  ///
  /// In en, this message translates to:
  /// **'Log a single page to start your rhythm.'**
  String get quranNoteStart;

  /// No description provided for @quranNoteReturned.
  ///
  /// In en, this message translates to:
  /// **'Consistency is building. You returned after missing one day.'**
  String get quranNoteReturned;

  /// No description provided for @quranNoteStreak.
  ///
  /// In en, this message translates to:
  /// **'{n} days in a row. Keep it gentle and steady.'**
  String quranNoteStreak(int n);

  /// No description provided for @quranNoteSteady.
  ///
  /// In en, this message translates to:
  /// **'Every return counts. Pick up with a single page today.'**
  String get quranNoteSteady;

  /// No description provided for @quranThisWeek.
  ///
  /// In en, this message translates to:
  /// **'This week'**
  String get quranThisWeek;

  /// No description provided for @quranRead.
  ///
  /// In en, this message translates to:
  /// **'Read'**
  String get quranRead;

  /// No description provided for @quranMemorized.
  ///
  /// In en, this message translates to:
  /// **'Memorized'**
  String get quranMemorized;

  /// No description provided for @quranRevised.
  ///
  /// In en, this message translates to:
  /// **'Revised'**
  String get quranRevised;

  /// No description provided for @quranUnitPages.
  ///
  /// In en, this message translates to:
  /// **'pages'**
  String get quranUnitPages;

  /// No description provided for @quranUnitMinutes.
  ///
  /// In en, this message translates to:
  /// **'minutes'**
  String get quranUnitMinutes;

  /// No description provided for @quranRecent.
  ///
  /// In en, this message translates to:
  /// **'Recent activity'**
  String get quranRecent;

  /// No description provided for @quranReadN.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{Read {pages} page} other{Read {pages} pages}}'**
  String quranReadN(num count, String pages);

  /// No description provided for @quranMemorizedN.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{Memorized {pages} page} other{Memorized {pages} pages}}'**
  String quranMemorizedN(num count, String pages);

  /// No description provided for @quranRevisedN.
  ///
  /// In en, this message translates to:
  /// **'Revised {minutes} min'**
  String quranRevisedN(int minutes);

  /// No description provided for @quranEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'Start with a single page'**
  String get quranEmptyTitle;

  /// No description provided for @quranEmptyBody.
  ///
  /// In en, this message translates to:
  /// **'Log your first reading, memorization, or revision to see your rhythm here.'**
  String get quranEmptyBody;

  /// No description provided for @quranTargetReading.
  ///
  /// In en, this message translates to:
  /// **'Reading (pages per day)'**
  String get quranTargetReading;

  /// No description provided for @quranTargetMemo.
  ///
  /// In en, this message translates to:
  /// **'Memorization (pages per day)'**
  String get quranTargetMemo;

  /// No description provided for @quranTargetRevision.
  ///
  /// In en, this message translates to:
  /// **'Revision (minutes per day)'**
  String get quranTargetRevision;

  /// No description provided for @workScreenTitle.
  ///
  /// In en, this message translates to:
  /// **'Work'**
  String get workScreenTitle;

  /// No description provided for @workScreenSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Focus, sales, and business progress.'**
  String get workScreenSubtitle;

  /// No description provided for @workTargetAchieved.
  ///
  /// In en, this message translates to:
  /// **'Target achieved'**
  String get workTargetAchieved;

  /// No description provided for @workTargetBanner.
  ///
  /// In en, this message translates to:
  /// **'You\'ve completed your deep work target for today.'**
  String get workTargetBanner;

  /// No description provided for @workMomentum.
  ///
  /// In en, this message translates to:
  /// **'Today\'s momentum'**
  String get workMomentum;

  /// No description provided for @workDeepFocus.
  ///
  /// In en, this message translates to:
  /// **'Deep work focus'**
  String get workDeepFocus;

  /// No description provided for @workLeads.
  ///
  /// In en, this message translates to:
  /// **'Leads'**
  String get workLeads;

  /// No description provided for @workFollowUps.
  ///
  /// In en, this message translates to:
  /// **'Follow-ups'**
  String get workFollowUps;

  /// No description provided for @workMeetings.
  ///
  /// In en, this message translates to:
  /// **'Meetings'**
  String get workMeetings;

  /// No description provided for @workProposals.
  ///
  /// In en, this message translates to:
  /// **'Proposals'**
  String get workProposals;

  /// No description provided for @workPlanned.
  ///
  /// In en, this message translates to:
  /// **'{n} planned'**
  String workPlanned(int n);

  /// No description provided for @workQuickActions.
  ///
  /// In en, this message translates to:
  /// **'Quick actions'**
  String get workQuickActions;

  /// No description provided for @workLogDeep.
  ///
  /// In en, this message translates to:
  /// **'Log deep work'**
  String get workLogDeep;

  /// No description provided for @workAddLead.
  ///
  /// In en, this message translates to:
  /// **'Add lead'**
  String get workAddLead;

  /// No description provided for @workAddFollowUp.
  ///
  /// In en, this message translates to:
  /// **'Add follow-up'**
  String get workAddFollowUp;

  /// No description provided for @workAddMeeting.
  ///
  /// In en, this message translates to:
  /// **'Add meeting'**
  String get workAddMeeting;

  /// No description provided for @workFocus.
  ///
  /// In en, this message translates to:
  /// **'Focus'**
  String get workFocus;

  /// No description provided for @workLogged.
  ///
  /// In en, this message translates to:
  /// **'{time} logged'**
  String workLogged(Object time);

  /// No description provided for @workAllLogs.
  ///
  /// In en, this message translates to:
  /// **'All logs'**
  String get workAllLogs;

  /// No description provided for @workNoFocus.
  ///
  /// In en, this message translates to:
  /// **'No deep work logged today. One focused block moves the needle.'**
  String get workNoFocus;

  /// No description provided for @workSales.
  ///
  /// In en, this message translates to:
  /// **'Sales activity'**
  String get workSales;

  /// No description provided for @workOutreach.
  ///
  /// In en, this message translates to:
  /// **'Outreach'**
  String get workOutreach;

  /// No description provided for @workCadence.
  ///
  /// In en, this message translates to:
  /// **'Cadence'**
  String get workCadence;

  /// No description provided for @workBooked.
  ///
  /// In en, this message translates to:
  /// **'Booked'**
  String get workBooked;

  /// No description provided for @workSent.
  ///
  /// In en, this message translates to:
  /// **'Sent'**
  String get workSent;

  /// No description provided for @workWon.
  ///
  /// In en, this message translates to:
  /// **'{n, plural, =1{1 client won} other{{n} clients won}}'**
  String workWon(int n);

  /// No description provided for @workWonWeek.
  ///
  /// In en, this message translates to:
  /// **'{won} this week'**
  String workWonWeek(Object won);

  /// No description provided for @workWonMonth.
  ///
  /// In en, this message translates to:
  /// **'{won} this month'**
  String workWonMonth(Object won);

  /// No description provided for @workActiveLeads.
  ///
  /// In en, this message translates to:
  /// **'Active leads'**
  String get workActiveLeads;

  /// No description provided for @workStageLead.
  ///
  /// In en, this message translates to:
  /// **'Contacted'**
  String get workStageLead;

  /// No description provided for @workStageFollowUp.
  ///
  /// In en, this message translates to:
  /// **'Following up'**
  String get workStageFollowUp;

  /// No description provided for @workStageMeeting.
  ///
  /// In en, this message translates to:
  /// **'Meeting'**
  String get workStageMeeting;

  /// No description provided for @workStageProposal.
  ///
  /// In en, this message translates to:
  /// **'Proposal sent'**
  String get workStageProposal;

  /// No description provided for @workNext.
  ///
  /// In en, this message translates to:
  /// **'Next: {what}'**
  String workNext(Object what);

  /// No description provided for @workNextNone.
  ///
  /// In en, this message translates to:
  /// **'Next: plan a follow-up'**
  String get workNextNone;

  /// No description provided for @workNoLeads.
  ///
  /// In en, this message translates to:
  /// **'Leads you log with a client or company name build your pipeline here.'**
  String get workNoLeads;

  /// No description provided for @workNextMeetings.
  ///
  /// In en, this message translates to:
  /// **'Next meetings'**
  String get workNextMeetings;

  /// No description provided for @workUpcoming.
  ///
  /// In en, this message translates to:
  /// **'{n} upcoming'**
  String workUpcoming(int n);

  /// No description provided for @workNoMeetings.
  ///
  /// In en, this message translates to:
  /// **'No meetings scheduled. Add one when a conversation is ready.'**
  String get workNoMeetings;

  /// No description provided for @workBusinessGoals.
  ///
  /// In en, this message translates to:
  /// **'Business goals'**
  String get workBusinessGoals;

  /// No description provided for @workInsightTitle.
  ///
  /// In en, this message translates to:
  /// **'Weekly sales pattern'**
  String get workInsightTitle;

  /// No description provided for @workInsightFollowUps.
  ///
  /// In en, this message translates to:
  /// **'Follow-ups are turning into meetings this week. Keep nurturing existing conversations.'**
  String get workInsightFollowUps;

  /// No description provided for @workInsightLeads.
  ///
  /// In en, this message translates to:
  /// **'You\'ve opened new conversations this week. A short follow-up keeps them warm.'**
  String get workInsightLeads;

  /// No description provided for @workInsightDeep.
  ///
  /// In en, this message translates to:
  /// **'Deep work is carrying your week. Protect one outreach block to keep the pipeline moving.'**
  String get workInsightDeep;

  /// No description provided for @workMarkWon.
  ///
  /// In en, this message translates to:
  /// **'Mark client won'**
  String get workMarkWon;

  /// No description provided for @workTargetDeep.
  ///
  /// In en, this message translates to:
  /// **'Deep work (minutes per day)'**
  String get workTargetDeep;

  /// No description provided for @workTargetLeads.
  ///
  /// In en, this message translates to:
  /// **'Leads per day'**
  String get workTargetLeads;

  /// No description provided for @workTargetFollowUps.
  ///
  /// In en, this message translates to:
  /// **'Follow-ups per day'**
  String get workTargetFollowUps;

  /// No description provided for @financeTitle.
  ///
  /// In en, this message translates to:
  /// **'Finance'**
  String get financeTitle;

  /// No description provided for @financeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Personal financial awareness and progress.'**
  String get financeSubtitle;

  /// No description provided for @financeExpensesLower.
  ///
  /// In en, this message translates to:
  /// **'Your expenses are {pct} lower than this time last month.'**
  String financeExpensesLower(Object pct);

  /// No description provided for @financeExpensesHigher.
  ///
  /// In en, this message translates to:
  /// **'Your expenses are {pct} higher than this time last month.'**
  String financeExpensesHigher(Object pct);

  /// No description provided for @financeNet.
  ///
  /// In en, this message translates to:
  /// **'Net savings & surplus'**
  String get financeNet;

  /// No description provided for @financeNetCaption.
  ///
  /// In en, this message translates to:
  /// **'Income after expenses and savings allocated'**
  String get financeNetCaption;

  /// No description provided for @financeLastMonth.
  ///
  /// In en, this message translates to:
  /// **'Last month'**
  String get financeLastMonth;

  /// No description provided for @financeThisYear.
  ///
  /// In en, this message translates to:
  /// **'Year'**
  String get financeThisYear;

  /// No description provided for @financeIncome.
  ///
  /// In en, this message translates to:
  /// **'Income'**
  String get financeIncome;

  /// No description provided for @financeExpenses.
  ///
  /// In en, this message translates to:
  /// **'Expenses'**
  String get financeExpenses;

  /// No description provided for @financeSavings.
  ///
  /// In en, this message translates to:
  /// **'Savings'**
  String get financeSavings;

  /// No description provided for @financeSavingsRate.
  ///
  /// In en, this message translates to:
  /// **'{pct} savings rate'**
  String financeSavingsRate(Object pct);

  /// No description provided for @financeQuickActions.
  ///
  /// In en, this message translates to:
  /// **'Quick actions'**
  String get financeQuickActions;

  /// No description provided for @financeCashFlow.
  ///
  /// In en, this message translates to:
  /// **'Cash flow'**
  String get financeCashFlow;

  /// No description provided for @financeInflow.
  ///
  /// In en, this message translates to:
  /// **'Inflow'**
  String get financeInflow;

  /// No description provided for @financeOutflow.
  ///
  /// In en, this message translates to:
  /// **'Outflow'**
  String get financeOutflow;

  /// No description provided for @financeSpending.
  ///
  /// In en, this message translates to:
  /// **'Spending'**
  String get financeSpending;

  /// No description provided for @financeTotal.
  ///
  /// In en, this message translates to:
  /// **'{amount} total'**
  String financeTotal(Object amount);

  /// No description provided for @financeTxCount.
  ///
  /// In en, this message translates to:
  /// **'{n, plural, =1{1 transaction} other{{n} transactions}}'**
  String financeTxCount(int n);

  /// No description provided for @financeNoSpending.
  ///
  /// In en, this message translates to:
  /// **'No expenses in this period.'**
  String get financeNoSpending;

  /// No description provided for @financeSavingsGoal.
  ///
  /// In en, this message translates to:
  /// **'Savings goal'**
  String get financeSavingsGoal;

  /// No description provided for @financeRemaining.
  ///
  /// In en, this message translates to:
  /// **'{amount} remaining to target'**
  String financeRemaining(Object amount);

  /// No description provided for @financeAddSaving.
  ///
  /// In en, this message translates to:
  /// **'Add saving'**
  String get financeAddSaving;

  /// No description provided for @financeRecent.
  ///
  /// In en, this message translates to:
  /// **'Recent transactions'**
  String get financeRecent;

  /// No description provided for @financeAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get financeAll;

  /// No description provided for @financeViewAll.
  ///
  /// In en, this message translates to:
  /// **'View all transactions'**
  String get financeViewAll;

  /// No description provided for @financeEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'Your money picture starts here'**
  String get financeEmptyTitle;

  /// No description provided for @financeEmptyBody.
  ///
  /// In en, this message translates to:
  /// **'Add an income, expense, or saving to see your balance, spending, and cash flow.'**
  String get financeEmptyBody;

  /// No description provided for @financeNoMatches.
  ///
  /// In en, this message translates to:
  /// **'No transactions of this type in this period.'**
  String get financeNoMatches;

  /// No description provided for @healthTitle.
  ///
  /// In en, this message translates to:
  /// **'Health & Habits'**
  String get healthTitle;

  /// No description provided for @healthSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Movement, sleep, and daily consistency.'**
  String get healthSubtitle;

  /// No description provided for @healthSleepInsight.
  ///
  /// In en, this message translates to:
  /// **'Your sleep averaged {time} over the last {n} nights.'**
  String healthSleepInsight(String time, int n);

  /// No description provided for @healthMovementToday.
  ///
  /// In en, this message translates to:
  /// **'Movement today'**
  String get healthMovementToday;

  /// No description provided for @healthPctCompleted.
  ///
  /// In en, this message translates to:
  /// **'{pct} completed'**
  String healthPctCompleted(Object pct);

  /// No description provided for @healthMinRemaining.
  ///
  /// In en, this message translates to:
  /// **'{n} min remaining'**
  String healthMinRemaining(int n);

  /// No description provided for @healthTargetMet.
  ///
  /// In en, this message translates to:
  /// **'Target reached'**
  String get healthTargetMet;

  /// No description provided for @healthWorkout.
  ///
  /// In en, this message translates to:
  /// **'Workout'**
  String get healthWorkout;

  /// No description provided for @healthDone.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get healthDone;

  /// No description provided for @healthNotYet.
  ///
  /// In en, this message translates to:
  /// **'Not yet'**
  String get healthNotYet;

  /// No description provided for @healthSleep.
  ///
  /// In en, this message translates to:
  /// **'Sleep'**
  String get healthSleep;

  /// No description provided for @healthHabits.
  ///
  /// In en, this message translates to:
  /// **'Habits'**
  String get healthHabits;

  /// No description provided for @healthHabitsOf.
  ///
  /// In en, this message translates to:
  /// **'{done} of {total}'**
  String healthHabitsOf(int done, int total);

  /// No description provided for @healthLogWorkout.
  ///
  /// In en, this message translates to:
  /// **'Log workout'**
  String get healthLogWorkout;

  /// No description provided for @healthLogWalk.
  ///
  /// In en, this message translates to:
  /// **'Log walk'**
  String get healthLogWalk;

  /// No description provided for @healthLogSleep.
  ///
  /// In en, this message translates to:
  /// **'Log sleep'**
  String get healthLogSleep;

  /// No description provided for @healthScheduledLogged.
  ///
  /// In en, this message translates to:
  /// **'Logged this week'**
  String get healthScheduledLogged;

  /// No description provided for @healthCompleted.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get healthCompleted;

  /// No description provided for @healthNoWorkout.
  ///
  /// In en, this message translates to:
  /// **'No workout logged this week. Even 20 minutes counts.'**
  String get healthNoWorkout;

  /// No description provided for @healthWalking.
  ///
  /// In en, this message translates to:
  /// **'Walking'**
  String get healthWalking;

  /// No description provided for @healthTargetMin.
  ///
  /// In en, this message translates to:
  /// **'Target {n} min'**
  String healthTargetMin(int n);

  /// No description provided for @healthWalksToday.
  ///
  /// In en, this message translates to:
  /// **'{n, plural, =0{No walks yet today} =1{1 walk today} other{{n} walks today}}'**
  String healthWalksToday(int n);

  /// No description provided for @healthWalkRemaining.
  ///
  /// In en, this message translates to:
  /// **'{n} min remaining to reach daily movement.'**
  String healthWalkRemaining(int n);

  /// No description provided for @healthWalkDone.
  ///
  /// In en, this message translates to:
  /// **'Daily movement reached. Nicely done.'**
  String get healthWalkDone;

  /// No description provided for @healthSleepRhythm.
  ///
  /// In en, this message translates to:
  /// **'Sleep health rhythm'**
  String get healthSleepRhythm;

  /// No description provided for @healthSleepTarget.
  ///
  /// In en, this message translates to:
  /// **'/ {time} target'**
  String healthSleepTarget(Object time);

  /// No description provided for @healthBelowTarget.
  ///
  /// In en, this message translates to:
  /// **'{time} below target'**
  String healthBelowTarget(Object time);

  /// No description provided for @healthOnTarget.
  ///
  /// In en, this message translates to:
  /// **'On target'**
  String get healthOnTarget;

  /// No description provided for @healthBedWake.
  ///
  /// In en, this message translates to:
  /// **'Bed {bed} · Wake {wake}'**
  String healthBedWake(Object bed, Object wake);

  /// No description provided for @healthEnergyToday.
  ///
  /// In en, this message translates to:
  /// **'Energy today: {energy}'**
  String healthEnergyToday(Object energy);

  /// No description provided for @healthNoSleep.
  ///
  /// In en, this message translates to:
  /// **'Log last night\'s sleep to follow your rhythm.'**
  String get healthNoSleep;

  /// No description provided for @healthDailyHabits.
  ///
  /// In en, this message translates to:
  /// **'Daily habits'**
  String get healthDailyHabits;

  /// No description provided for @healthHabitsCompleted.
  ///
  /// In en, this message translates to:
  /// **'{done} of {total} completed'**
  String healthHabitsCompleted(int done, int total);

  /// No description provided for @healthEditHabits.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get healthEditHabits;

  /// No description provided for @healthDoneEditing.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get healthDoneEditing;

  /// No description provided for @healthArchiveHabit.
  ///
  /// In en, this message translates to:
  /// **'Remove habit'**
  String get healthArchiveHabit;

  /// No description provided for @healthArchiveBody.
  ///
  /// In en, this message translates to:
  /// **'The habit is hidden from your list. Past check-ins stay in your history.'**
  String get healthArchiveBody;

  /// No description provided for @healthRenameHabit.
  ///
  /// In en, this message translates to:
  /// **'Rename habit'**
  String get healthRenameHabit;

  /// No description provided for @healthGoals.
  ///
  /// In en, this message translates to:
  /// **'Health goals'**
  String get healthGoals;

  /// No description provided for @healthWeeklyProgress.
  ///
  /// In en, this message translates to:
  /// **'Weekly progress'**
  String get healthWeeklyProgress;

  /// No description provided for @healthActiveDays.
  ///
  /// In en, this message translates to:
  /// **'{n} of 7 days active this week'**
  String healthActiveDays(int n);

  /// No description provided for @healthWeekNote.
  ///
  /// In en, this message translates to:
  /// **'Movement, sleep, and habits all count. Returning after a missed day is progress.'**
  String get healthWeekNote;

  /// No description provided for @workoutTitle.
  ///
  /// In en, this message translates to:
  /// **'Log workout'**
  String get workoutTitle;

  /// No description provided for @workoutName.
  ///
  /// In en, this message translates to:
  /// **'Workout'**
  String get workoutName;

  /// No description provided for @workoutNameHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. Strength training'**
  String get workoutNameHint;

  /// No description provided for @workoutDetail.
  ///
  /// In en, this message translates to:
  /// **'Detail'**
  String get workoutDetail;

  /// No description provided for @workoutDetailHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. Upper body & core'**
  String get workoutDetailHint;

  /// No description provided for @workoutDuration.
  ///
  /// In en, this message translates to:
  /// **'Duration'**
  String get workoutDuration;

  /// No description provided for @walkTitle.
  ///
  /// In en, this message translates to:
  /// **'Log walk'**
  String get walkTitle;

  /// No description provided for @walkMinutes.
  ///
  /// In en, this message translates to:
  /// **'Minutes walked'**
  String get walkMinutes;

  /// No description provided for @walkSteps.
  ///
  /// In en, this message translates to:
  /// **'Steps'**
  String get walkSteps;

  /// No description provided for @sleepTitle.
  ///
  /// In en, this message translates to:
  /// **'Log sleep'**
  String get sleepTitle;

  /// No description provided for @sleepBed.
  ///
  /// In en, this message translates to:
  /// **'Bedtime'**
  String get sleepBed;

  /// No description provided for @sleepWake.
  ///
  /// In en, this message translates to:
  /// **'Wake time'**
  String get sleepWake;

  /// No description provided for @sleepDuration.
  ///
  /// In en, this message translates to:
  /// **'{time} of sleep'**
  String sleepDuration(Object time);

  /// No description provided for @sleepEnergy.
  ///
  /// In en, this message translates to:
  /// **'How\'s your energy?'**
  String get sleepEnergy;

  /// No description provided for @healthTargetWalk.
  ///
  /// In en, this message translates to:
  /// **'Movement (minutes per day)'**
  String get healthTargetWalk;

  /// No description provided for @healthTargetSleep.
  ///
  /// In en, this message translates to:
  /// **'Sleep (hours per night)'**
  String get healthTargetSleep;

  /// No description provided for @healthTargetWorkouts.
  ///
  /// In en, this message translates to:
  /// **'Workouts per week'**
  String get healthTargetWorkouts;

  /// No description provided for @learnTitle.
  ///
  /// In en, this message translates to:
  /// **'Learning'**
  String get learnTitle;

  /// No description provided for @learnSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Skills, study, and real progress.'**
  String get learnSubtitle;

  /// No description provided for @learnTargetBanner.
  ///
  /// In en, this message translates to:
  /// **'You\'ve completed your daily study target for today.'**
  String get learnTargetBanner;

  /// No description provided for @learnStudyToday.
  ///
  /// In en, this message translates to:
  /// **'Study today'**
  String get learnStudyToday;

  /// No description provided for @learnSkill.
  ///
  /// In en, this message translates to:
  /// **'Skill'**
  String get learnSkill;

  /// No description provided for @learnSession.
  ///
  /// In en, this message translates to:
  /// **'Session'**
  String get learnSession;

  /// No description provided for @learnSessionDone.
  ///
  /// In en, this message translates to:
  /// **'Done ({time})'**
  String learnSessionDone(Object time);

  /// No description provided for @learnApplied.
  ///
  /// In en, this message translates to:
  /// **'Applied'**
  String get learnApplied;

  /// No description provided for @learnActions.
  ///
  /// In en, this message translates to:
  /// **'{n, plural, =1{1 action} other{{n} actions}}'**
  String learnActions(int n);

  /// No description provided for @learnLogStudy.
  ///
  /// In en, this message translates to:
  /// **'Log study'**
  String get learnLogStudy;

  /// No description provided for @learnAddTakeaway.
  ///
  /// In en, this message translates to:
  /// **'Add takeaway'**
  String get learnAddTakeaway;

  /// No description provided for @learnNewAction.
  ///
  /// In en, this message translates to:
  /// **'New action'**
  String get learnNewAction;

  /// No description provided for @learnCurrentFocus.
  ///
  /// In en, this message translates to:
  /// **'Current focus'**
  String get learnCurrentFocus;

  /// No description provided for @learnActiveSubject.
  ///
  /// In en, this message translates to:
  /// **'Active subject'**
  String get learnActiveSubject;

  /// No description provided for @learnWeekOf.
  ///
  /// In en, this message translates to:
  /// **'Week {n} of {total}'**
  String learnWeekOf(int n, int total);

  /// No description provided for @learnCadence.
  ///
  /// In en, this message translates to:
  /// **'{pct} cadence'**
  String learnCadence(Object pct);

  /// No description provided for @learnNext.
  ///
  /// In en, this message translates to:
  /// **'Next · {step}'**
  String learnNext(Object step);

  /// No description provided for @learnContinue.
  ///
  /// In en, this message translates to:
  /// **'Continue study'**
  String get learnContinue;

  /// No description provided for @learnNoFocusTitle.
  ///
  /// In en, this message translates to:
  /// **'Choose a skill to focus on'**
  String get learnNoFocusTitle;

  /// No description provided for @learnNoFocusBody.
  ///
  /// In en, this message translates to:
  /// **'A single focus for a few weeks turns study into real progress.'**
  String get learnNoFocusBody;

  /// No description provided for @learnSetFocus.
  ///
  /// In en, this message translates to:
  /// **'Set focus'**
  String get learnSetFocus;

  /// No description provided for @learnEditFocus.
  ///
  /// In en, this message translates to:
  /// **'Edit focus'**
  String get learnEditFocus;

  /// No description provided for @learnApplyTitle.
  ///
  /// In en, this message translates to:
  /// **'Apply what you learn'**
  String get learnApplyTitle;

  /// No description provided for @learnApplyCount.
  ///
  /// In en, this message translates to:
  /// **'{done} of {total} completed'**
  String learnApplyCount(int done, int total);

  /// No description provided for @learnApplyHint.
  ///
  /// In en, this message translates to:
  /// **'Real progress happens when knowledge turns into action.'**
  String get learnApplyHint;

  /// No description provided for @learnApplyEmpty.
  ///
  /// In en, this message translates to:
  /// **'Turn one idea from your study into an action you can try this week.'**
  String get learnApplyEmpty;

  /// No description provided for @learnCompletedToday.
  ///
  /// In en, this message translates to:
  /// **'Completed today'**
  String get learnCompletedToday;

  /// No description provided for @learnUpcoming.
  ///
  /// In en, this message translates to:
  /// **'Upcoming'**
  String get learnUpcoming;

  /// No description provided for @learnSessions.
  ///
  /// In en, this message translates to:
  /// **'Study sessions'**
  String get learnSessions;

  /// No description provided for @learnRecent.
  ///
  /// In en, this message translates to:
  /// **'Recent activity'**
  String get learnRecent;

  /// No description provided for @learnNoSessions.
  ///
  /// In en, this message translates to:
  /// **'Log a study session to build your learning rhythm.'**
  String get learnNoSessions;

  /// No description provided for @learnGoals.
  ///
  /// In en, this message translates to:
  /// **'Learning goals'**
  String get learnGoals;

  /// No description provided for @learnResources.
  ///
  /// In en, this message translates to:
  /// **'In progress resources'**
  String get learnResources;

  /// No description provided for @learnActiveCount.
  ///
  /// In en, this message translates to:
  /// **'{n} active'**
  String learnActiveCount(int n);

  /// No description provided for @learnAddResource.
  ///
  /// In en, this message translates to:
  /// **'Add resource'**
  String get learnAddResource;

  /// No description provided for @learnNoResources.
  ///
  /// In en, this message translates to:
  /// **'Track a course or book to see your progress through it.'**
  String get learnNoResources;

  /// No description provided for @learnUnitsOf.
  ///
  /// In en, this message translates to:
  /// **'{done} / {total} {unit}'**
  String learnUnitsOf(Object done, Object total, Object unit);

  /// No description provided for @learnUpdateProgress.
  ///
  /// In en, this message translates to:
  /// **'Update progress'**
  String get learnUpdateProgress;

  /// No description provided for @learnArchiveResource.
  ///
  /// In en, this message translates to:
  /// **'Remove resource'**
  String get learnArchiveResource;

  /// No description provided for @learnArchiveBody.
  ///
  /// In en, this message translates to:
  /// **'The resource is hidden from your list. Past study sessions stay in your history.'**
  String get learnArchiveBody;

  /// No description provided for @learnThisWeek.
  ///
  /// In en, this message translates to:
  /// **'This week in learning'**
  String get learnThisWeek;

  /// No description provided for @learnStudyTime.
  ///
  /// In en, this message translates to:
  /// **'Study time'**
  String get learnStudyTime;

  /// No description provided for @learnSessionsCount.
  ///
  /// In en, this message translates to:
  /// **'Sessions'**
  String get learnSessionsCount;

  /// No description provided for @learnAppliedCount.
  ///
  /// In en, this message translates to:
  /// **'Applied'**
  String get learnAppliedCount;

  /// No description provided for @learnDaysStudied.
  ///
  /// In en, this message translates to:
  /// **'{n} of 7 days studied this week.'**
  String learnDaysStudied(int n);

  /// No description provided for @learnDaysNote.
  ///
  /// In en, this message translates to:
  /// **'Steady, incremental knowledge application.'**
  String get learnDaysNote;

  /// No description provided for @kindCourse.
  ///
  /// In en, this message translates to:
  /// **'Course'**
  String get kindCourse;

  /// No description provided for @kindBook.
  ///
  /// In en, this message translates to:
  /// **'Book'**
  String get kindBook;

  /// No description provided for @kindVideo.
  ///
  /// In en, this message translates to:
  /// **'Video'**
  String get kindVideo;

  /// No description provided for @kindArticle.
  ///
  /// In en, this message translates to:
  /// **'Article'**
  String get kindArticle;

  /// No description provided for @unitLessons.
  ///
  /// In en, this message translates to:
  /// **'lessons'**
  String get unitLessons;

  /// No description provided for @unitPages.
  ///
  /// In en, this message translates to:
  /// **'pages'**
  String get unitPages;

  /// No description provided for @unitVideos.
  ///
  /// In en, this message translates to:
  /// **'videos'**
  String get unitVideos;

  /// No description provided for @unitArticles.
  ///
  /// In en, this message translates to:
  /// **'articles'**
  String get unitArticles;

  /// No description provided for @studyTitle.
  ///
  /// In en, this message translates to:
  /// **'Log study'**
  String get studyTitle;

  /// No description provided for @studyTopic.
  ///
  /// In en, this message translates to:
  /// **'What did you study?'**
  String get studyTopic;

  /// No description provided for @studyTopicHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. Discovery question frameworks'**
  String get studyTopicHint;

  /// No description provided for @studySkill.
  ///
  /// In en, this message translates to:
  /// **'Skill'**
  String get studySkill;

  /// No description provided for @studySkillHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. Sales & Negotiation'**
  String get studySkillHint;

  /// No description provided for @studyMinutes.
  ///
  /// In en, this message translates to:
  /// **'Duration'**
  String get studyMinutes;

  /// No description provided for @studyResource.
  ///
  /// In en, this message translates to:
  /// **'Resource'**
  String get studyResource;

  /// No description provided for @studyNoResource.
  ///
  /// In en, this message translates to:
  /// **'No resource'**
  String get studyNoResource;

  /// No description provided for @studyUnits.
  ///
  /// In en, this message translates to:
  /// **'Progress in resource'**
  String get studyUnits;

  /// No description provided for @studyTakeaway.
  ///
  /// In en, this message translates to:
  /// **'Key takeaway'**
  String get studyTakeaway;

  /// No description provided for @studyTakeawayHint.
  ///
  /// In en, this message translates to:
  /// **'One idea worth remembering'**
  String get studyTakeawayHint;

  /// No description provided for @studyAction.
  ///
  /// In en, this message translates to:
  /// **'Action to apply'**
  String get studyAction;

  /// No description provided for @studyActionHint.
  ///
  /// In en, this message translates to:
  /// **'Added to tomorrow\'s plan'**
  String get studyActionHint;

  /// No description provided for @takeawayTitle.
  ///
  /// In en, this message translates to:
  /// **'Add takeaway'**
  String get takeawayTitle;

  /// No description provided for @takeawayHint.
  ///
  /// In en, this message translates to:
  /// **'What\'s one idea you want to keep?'**
  String get takeawayHint;

  /// No description provided for @focusTitle.
  ///
  /// In en, this message translates to:
  /// **'Learning focus'**
  String get focusTitle;

  /// No description provided for @focusSkill.
  ///
  /// In en, this message translates to:
  /// **'Skill'**
  String get focusSkill;

  /// No description provided for @focusDescription.
  ///
  /// In en, this message translates to:
  /// **'What does progress look like?'**
  String get focusDescription;

  /// No description provided for @focusDescriptionHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. Improve client discovery and proposal closing'**
  String get focusDescriptionHint;

  /// No description provided for @focusWeeks.
  ///
  /// In en, this message translates to:
  /// **'Length (weeks)'**
  String get focusWeeks;

  /// No description provided for @focusNextStep.
  ///
  /// In en, this message translates to:
  /// **'Next step'**
  String get focusNextStep;

  /// No description provided for @focusNextStepHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. Practice discovery questions on next call'**
  String get focusNextStepHint;

  /// No description provided for @resourceTitle.
  ///
  /// In en, this message translates to:
  /// **'Add resource'**
  String get resourceTitle;

  /// No description provided for @resourceName.
  ///
  /// In en, this message translates to:
  /// **'Title'**
  String get resourceName;

  /// No description provided for @resourceNameHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. Never Split the Difference'**
  String get resourceNameHint;

  /// No description provided for @resourceKind.
  ///
  /// In en, this message translates to:
  /// **'Type'**
  String get resourceKind;

  /// No description provided for @resourceTotal.
  ///
  /// In en, this message translates to:
  /// **'Total {unit}'**
  String resourceTotal(Object unit);

  /// No description provided for @resourceDone.
  ///
  /// In en, this message translates to:
  /// **'Completed so far'**
  String get resourceDone;

  /// No description provided for @learnTargetStudy.
  ///
  /// In en, this message translates to:
  /// **'Study (minutes per day)'**
  String get learnTargetStudy;

  /// No description provided for @goalsTitle.
  ///
  /// In en, this message translates to:
  /// **'Goals'**
  String get goalsTitle;

  /// No description provided for @goalsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'What you\'re building over time.'**
  String get goalsSubtitle;

  /// No description provided for @goalsNew.
  ///
  /// In en, this message translates to:
  /// **'New goal'**
  String get goalsNew;

  /// No description provided for @goalsActiveCount.
  ///
  /// In en, this message translates to:
  /// **'{n, plural, =1{1 active goal} other{{n} active goals}}'**
  String goalsActiveCount(int n);

  /// No description provided for @goalsOnTrackCount.
  ///
  /// In en, this message translates to:
  /// **'{n} on track'**
  String goalsOnTrackCount(int n);

  /// No description provided for @goalsAttentionCount.
  ///
  /// In en, this message translates to:
  /// **'{n} need attention'**
  String goalsAttentionCount(int n);

  /// No description provided for @goalsFilterAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get goalsFilterAll;

  /// No description provided for @goalsFilterActive.
  ///
  /// In en, this message translates to:
  /// **'Active ({n})'**
  String goalsFilterActive(int n);

  /// No description provided for @goalsFilterCompleted.
  ///
  /// In en, this message translates to:
  /// **'Completed ({n})'**
  String goalsFilterCompleted(int n);

  /// No description provided for @goalsPrimaryFocus.
  ///
  /// In en, this message translates to:
  /// **'Primary focus'**
  String get goalsPrimaryFocus;

  /// No description provided for @goalsKeystone.
  ///
  /// In en, this message translates to:
  /// **'Keystone'**
  String get goalsKeystone;

  /// No description provided for @goalsTargetOn.
  ///
  /// In en, this message translates to:
  /// **'Target · {date}'**
  String goalsTargetOn(Object date);

  /// No description provided for @goalsNextActionToday.
  ///
  /// In en, this message translates to:
  /// **'Next action · Today'**
  String get goalsNextActionToday;

  /// No description provided for @goalsLogProgress.
  ///
  /// In en, this message translates to:
  /// **'Log progress'**
  String get goalsLogProgress;

  /// No description provided for @goalsMonthRecap.
  ///
  /// In en, this message translates to:
  /// **'This month'**
  String get goalsMonthRecap;

  /// No description provided for @goalsMovedForward.
  ///
  /// In en, this message translates to:
  /// **'{n, plural, =1{1 goal moved forward} other{{n} goals moved forward}}'**
  String goalsMovedForward(int n);

  /// No description provided for @goalsRecapBody.
  ///
  /// In en, this message translates to:
  /// **'{n, plural, =1{1 progress update logged.} other{{n} progress updates logged.}}'**
  String goalsRecapBody(int n);

  /// No description provided for @goalsRecapStrongest.
  ///
  /// In en, this message translates to:
  /// **'{areas} kept your strongest rhythm.'**
  String goalsRecapStrongest(Object areas);

  /// No description provided for @goalsAll.
  ///
  /// In en, this message translates to:
  /// **'All goals'**
  String get goalsAll;

  /// No description provided for @goalsAreas.
  ///
  /// In en, this message translates to:
  /// **'{n, plural, =1{1 active life area} other{{n} active life areas}}'**
  String goalsAreas(int n);

  /// No description provided for @goalsPctCompleted.
  ///
  /// In en, this message translates to:
  /// **'{pct}% completed'**
  String goalsPctCompleted(int pct);

  /// No description provided for @goalsNextShort.
  ///
  /// In en, this message translates to:
  /// **'Next: {action}'**
  String goalsNextShort(Object action);

  /// No description provided for @goalsRemaining.
  ///
  /// In en, this message translates to:
  /// **'{value} remaining'**
  String goalsRemaining(Object value);

  /// No description provided for @goalsMetPeriod.
  ///
  /// In en, this message translates to:
  /// **'Met this period'**
  String get goalsMetPeriod;

  /// No description provided for @goalsWeeklyRhythm.
  ///
  /// In en, this message translates to:
  /// **'Weekly rhythm'**
  String get goalsWeeklyRhythm;

  /// No description provided for @goalsDailyRhythm.
  ///
  /// In en, this message translates to:
  /// **'Daily rhythm'**
  String get goalsDailyRhythm;

  /// No description provided for @goalsMonthlyRhythm.
  ///
  /// In en, this message translates to:
  /// **'Monthly rhythm'**
  String get goalsMonthlyRhythm;

  /// No description provided for @goalsCompletedGoals.
  ///
  /// In en, this message translates to:
  /// **'Completed goals'**
  String get goalsCompletedGoals;

  /// No description provided for @goalsCompletedOn.
  ///
  /// In en, this message translates to:
  /// **'Completed {date}'**
  String goalsCompletedOn(Object date);

  /// No description provided for @goalsPaused.
  ///
  /// In en, this message translates to:
  /// **'Paused'**
  String get goalsPaused;

  /// No description provided for @goalsEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'Set your first goal'**
  String get goalsEmptyTitle;

  /// No description provided for @goalsEmptyBody.
  ///
  /// In en, this message translates to:
  /// **'Goals connect your daily actions to what you\'re building over time.'**
  String get goalsEmptyBody;

  /// No description provided for @goalsNoCompleted.
  ///
  /// In en, this message translates to:
  /// **'Completed goals will be kept here as a record of what you\'ve built.'**
  String get goalsNoCompleted;

  /// No description provided for @goalsNoneInFilter.
  ///
  /// In en, this message translates to:
  /// **'No goals match this filter.'**
  String get goalsNoneInFilter;

  /// No description provided for @goalDetailTitle.
  ///
  /// In en, this message translates to:
  /// **'Goal detail'**
  String get goalDetailTitle;

  /// No description provided for @goalPrimaryFocus.
  ///
  /// In en, this message translates to:
  /// **'Primary focus'**
  String get goalPrimaryFocus;

  /// No description provided for @goalTrajectory.
  ///
  /// In en, this message translates to:
  /// **'Trajectory'**
  String get goalTrajectory;

  /// No description provided for @goalOfTarget.
  ///
  /// In en, this message translates to:
  /// **'of {target}'**
  String goalOfTarget(Object target);

  /// No description provided for @goalNextAction.
  ///
  /// In en, this message translates to:
  /// **'Next action'**
  String get goalNextAction;

  /// No description provided for @goalAllActionsDone.
  ///
  /// In en, this message translates to:
  /// **'All actions are done for this period.'**
  String get goalAllActionsDone;

  /// No description provided for @goalActions.
  ///
  /// In en, this message translates to:
  /// **'Actions'**
  String get goalActions;

  /// No description provided for @goalActiveCount.
  ///
  /// In en, this message translates to:
  /// **'{n} active'**
  String goalActiveCount(int n);

  /// No description provided for @goalDoneForPeriod.
  ///
  /// In en, this message translates to:
  /// **'Completed for this period'**
  String get goalDoneForPeriod;

  /// No description provided for @goalNoActions.
  ///
  /// In en, this message translates to:
  /// **'Add a small recurring action that moves this goal forward.'**
  String get goalNoActions;

  /// No description provided for @goalMilestonesDone.
  ///
  /// In en, this message translates to:
  /// **'{done} of {total} completed'**
  String goalMilestonesDone(int done, int total);

  /// No description provided for @goalMilestoneCompleted.
  ///
  /// In en, this message translates to:
  /// **'Completed · {date}'**
  String goalMilestoneCompleted(Object date);

  /// No description provided for @goalMilestoneCurrent.
  ///
  /// In en, this message translates to:
  /// **'Current'**
  String get goalMilestoneCurrent;

  /// No description provided for @goalMilestoneUpcoming.
  ///
  /// In en, this message translates to:
  /// **'Upcoming'**
  String get goalMilestoneUpcoming;

  /// No description provided for @goalHistory.
  ///
  /// In en, this message translates to:
  /// **'Progress history'**
  String get goalHistory;

  /// No description provided for @goalTrend.
  ///
  /// In en, this message translates to:
  /// **'Progress trend'**
  String get goalTrend;

  /// No description provided for @goalTrendChange.
  ///
  /// In en, this message translates to:
  /// **'{pct} since start'**
  String goalTrendChange(Object pct);

  /// No description provided for @goalNoHistory.
  ///
  /// In en, this message translates to:
  /// **'Progress you log, and linked module entries, will show up here.'**
  String get goalNoHistory;

  /// No description provided for @goalProgressAdded.
  ///
  /// In en, this message translates to:
  /// **'+{value}'**
  String goalProgressAdded(Object value);

  /// No description provided for @goalWhyTitle.
  ///
  /// In en, this message translates to:
  /// **'Why this matters'**
  String get goalWhyTitle;

  /// No description provided for @goalMenuEdit.
  ///
  /// In en, this message translates to:
  /// **'Edit goal'**
  String get goalMenuEdit;

  /// No description provided for @goalMenuPause.
  ///
  /// In en, this message translates to:
  /// **'Pause goal'**
  String get goalMenuPause;

  /// No description provided for @goalMenuResume.
  ///
  /// In en, this message translates to:
  /// **'Resume goal'**
  String get goalMenuResume;

  /// No description provided for @goalMenuComplete.
  ///
  /// In en, this message translates to:
  /// **'Mark as completed'**
  String get goalMenuComplete;

  /// No description provided for @goalMenuReopen.
  ///
  /// In en, this message translates to:
  /// **'Reopen goal'**
  String get goalMenuReopen;

  /// No description provided for @goalMenuPrimary.
  ///
  /// In en, this message translates to:
  /// **'Make primary focus'**
  String get goalMenuPrimary;

  /// No description provided for @goalMenuArchive.
  ///
  /// In en, this message translates to:
  /// **'Archive goal'**
  String get goalMenuArchive;

  /// No description provided for @goalMenuDelete.
  ///
  /// In en, this message translates to:
  /// **'Delete goal'**
  String get goalMenuDelete;

  /// No description provided for @goalDeleteTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete this goal?'**
  String get goalDeleteTitle;

  /// No description provided for @goalDeleteBody.
  ///
  /// In en, this message translates to:
  /// **'The goal, its actions, milestones, and progress history will be removed. Logs in other areas stay.'**
  String get goalDeleteBody;

  /// No description provided for @goalArchiveTitle.
  ///
  /// In en, this message translates to:
  /// **'Archive this goal?'**
  String get goalArchiveTitle;

  /// No description provided for @goalArchiveBody.
  ///
  /// In en, this message translates to:
  /// **'It will be hidden from your goals. Its history stays in your activity.'**
  String get goalArchiveBody;

  /// No description provided for @goalNotFound.
  ///
  /// In en, this message translates to:
  /// **'This goal no longer exists.'**
  String get goalNotFound;

  /// No description provided for @goalLogTitle.
  ///
  /// In en, this message translates to:
  /// **'Log progress'**
  String get goalLogTitle;

  /// No description provided for @goalLogAmount.
  ///
  /// In en, this message translates to:
  /// **'Amount to add'**
  String get goalLogAmount;

  /// No description provided for @goalLogTimes.
  ///
  /// In en, this message translates to:
  /// **'Times completed'**
  String get goalLogTimes;

  /// No description provided for @goalLogNote.
  ///
  /// In en, this message translates to:
  /// **'Note'**
  String get goalLogNote;

  /// No description provided for @goalLogSave.
  ///
  /// In en, this message translates to:
  /// **'Save progress'**
  String get goalLogSave;

  /// No description provided for @goalLogged.
  ///
  /// In en, this message translates to:
  /// **'Progress saved'**
  String get goalLogged;

  /// No description provided for @goalCompletedBanner.
  ///
  /// In en, this message translates to:
  /// **'Goal completed. Well done.'**
  String get goalCompletedBanner;

  /// No description provided for @goalPausedBanner.
  ///
  /// In en, this message translates to:
  /// **'This goal is paused. Resume it to track progress again.'**
  String get goalPausedBanner;

  /// No description provided for @healthOnTrack.
  ///
  /// In en, this message translates to:
  /// **'On track'**
  String get healthOnTrack;

  /// No description provided for @healthAttention.
  ///
  /// In en, this message translates to:
  /// **'Needs attention'**
  String get healthAttention;

  /// No description provided for @healthCompletedLabel.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get healthCompletedLabel;

  /// No description provided for @healthPausedLabel.
  ///
  /// In en, this message translates to:
  /// **'Paused'**
  String get healthPausedLabel;

  /// No description provided for @progressTitle.
  ///
  /// In en, this message translates to:
  /// **'Progress'**
  String get progressTitle;

  /// No description provided for @progressSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Consistency, patterns, and long-term direction.'**
  String get progressSubtitle;

  /// No description provided for @progressCalendar.
  ///
  /// In en, this message translates to:
  /// **'Progress calendar'**
  String get progressCalendar;

  /// No description provided for @progressThisWeek.
  ///
  /// In en, this message translates to:
  /// **'This week'**
  String get progressThisWeek;

  /// No description provided for @progressThisMonth.
  ///
  /// In en, this message translates to:
  /// **'This month'**
  String get progressThisMonth;

  /// No description provided for @progressThisYear.
  ///
  /// In en, this message translates to:
  /// **'This year'**
  String get progressThisYear;

  /// No description provided for @progressVsLastWeek.
  ///
  /// In en, this message translates to:
  /// **'{delta} vs last week'**
  String progressVsLastWeek(Object delta);

  /// No description provided for @progressVsLastMonth.
  ///
  /// In en, this message translates to:
  /// **'{delta} vs last month'**
  String progressVsLastMonth(Object delta);

  /// No description provided for @progressVsLastYear.
  ///
  /// In en, this message translates to:
  /// **'{delta} vs last year'**
  String progressVsLastYear(Object delta);

  /// No description provided for @progressOverall.
  ///
  /// In en, this message translates to:
  /// **'Overall consistency'**
  String get progressOverall;

  /// No description provided for @progressDaysBody.
  ///
  /// In en, this message translates to:
  /// **'{active} of {total} days'**
  String progressDaysBody(int active, int total);

  /// No description provided for @progressDaysTail.
  ///
  /// In en, this message translates to:
  /// **'had meaningful progress across your focus areas.'**
  String get progressDaysTail;

  /// No description provided for @progressOverTime.
  ///
  /// In en, this message translates to:
  /// **'Progress over time'**
  String get progressOverTime;

  /// No description provided for @progressDailyTrajectory.
  ///
  /// In en, this message translates to:
  /// **'Daily trajectory this week'**
  String get progressDailyTrajectory;

  /// No description provided for @progressWeeklyTrajectory.
  ///
  /// In en, this message translates to:
  /// **'Weekly trajectory this month'**
  String get progressWeeklyTrajectory;

  /// No description provided for @progressMonthlyTrajectory.
  ///
  /// In en, this message translates to:
  /// **'Monthly trajectory this year'**
  String get progressMonthlyTrajectory;

  /// No description provided for @progressCurrent.
  ///
  /// In en, this message translates to:
  /// **'{pct} · Current'**
  String progressCurrent(Object pct);

  /// No description provided for @progressLifeAreas.
  ///
  /// In en, this message translates to:
  /// **'Life areas'**
  String get progressLifeAreas;

  /// No description provided for @progressTracked.
  ///
  /// In en, this message translates to:
  /// **'{n, plural, =1{1 tracked category} other{{n} tracked categories}}'**
  String progressTracked(int n);

  /// No description provided for @progressNeedsFocus.
  ///
  /// In en, this message translates to:
  /// **'Needs focus'**
  String get progressNeedsFocus;

  /// No description provided for @progressStrongest.
  ///
  /// In en, this message translates to:
  /// **'Strongest rhythm'**
  String get progressStrongest;

  /// No description provided for @progressStrongestBody.
  ///
  /// In en, this message translates to:
  /// **'{pct} consistency — active on {days} of {total} days.'**
  String progressStrongestBody(String pct, int days, int total);

  /// No description provided for @progressAttention.
  ///
  /// In en, this message translates to:
  /// **'Needs attention'**
  String get progressAttention;

  /// No description provided for @progressAttentionBody.
  ///
  /// In en, this message translates to:
  /// **'{pct} consistency. A small daily step here would lift your balance.'**
  String progressAttentionBody(Object pct);

  /// No description provided for @progressConsistency.
  ///
  /// In en, this message translates to:
  /// **'Consistency'**
  String get progressConsistency;

  /// No description provided for @progressMeaningfulDays.
  ///
  /// In en, this message translates to:
  /// **'{n, plural, =1{1 meaningful progress day} other{{n} meaningful progress days}} in {period}'**
  String progressMeaningfulDays(int n, String period);

  /// No description provided for @progressStrong.
  ///
  /// In en, this message translates to:
  /// **'Strong'**
  String get progressStrong;

  /// No description provided for @progressSteady.
  ///
  /// In en, this message translates to:
  /// **'Steady'**
  String get progressSteady;

  /// No description provided for @progressLight.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get progressLight;

  /// No description provided for @progressRest.
  ///
  /// In en, this message translates to:
  /// **'Rest'**
  String get progressRest;

  /// No description provided for @progressNotLogged.
  ///
  /// In en, this message translates to:
  /// **'Not logged'**
  String get progressNotLogged;

  /// No description provided for @progressBestDays.
  ///
  /// In en, this message translates to:
  /// **'Your most consistent days are {first} and {second}.'**
  String progressBestDays(Object first, Object second);

  /// No description provided for @progressActiveGoals.
  ///
  /// In en, this message translates to:
  /// **'Active goals'**
  String get progressActiveGoals;

  /// No description provided for @progressViewGoals.
  ///
  /// In en, this message translates to:
  /// **'View all goals'**
  String get progressViewGoals;

  /// No description provided for @progressMonthlyReady.
  ///
  /// In en, this message translates to:
  /// **'Monthly review ready'**
  String get progressMonthlyReady;

  /// No description provided for @progressMonthlySummary.
  ///
  /// In en, this message translates to:
  /// **'{month} summary'**
  String progressMonthlySummary(Object month);

  /// No description provided for @progressMonthlyBody.
  ///
  /// In en, this message translates to:
  /// **'See your patterns, key accomplishments, and what to adjust next month.'**
  String get progressMonthlyBody;

  /// No description provided for @progressReviewMonth.
  ///
  /// In en, this message translates to:
  /// **'Review this month'**
  String get progressReviewMonth;

  /// No description provided for @progressWeeklyLink.
  ///
  /// In en, this message translates to:
  /// **'Weekly review'**
  String get progressWeeklyLink;

  /// No description provided for @progressEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'Your progress builds here'**
  String get progressEmptyTitle;

  /// No description provided for @progressEmptyBody.
  ///
  /// In en, this message translates to:
  /// **'Complete an action or log something in any area. Consistency, patterns, and trends appear as you go.'**
  String get progressEmptyBody;

  /// No description provided for @progressAddAction.
  ///
  /// In en, this message translates to:
  /// **'Add something'**
  String get progressAddAction;

  /// No description provided for @calTitle.
  ///
  /// In en, this message translates to:
  /// **'Progress Calendar'**
  String get calTitle;

  /// No description provided for @calToday.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get calToday;

  /// No description provided for @calPrevMonth.
  ///
  /// In en, this message translates to:
  /// **'Previous month'**
  String get calPrevMonth;

  /// No description provided for @calNextMonth.
  ///
  /// In en, this message translates to:
  /// **'Next month'**
  String get calNextMonth;

  /// No description provided for @calOverall.
  ///
  /// In en, this message translates to:
  /// **'Overall'**
  String get calOverall;

  /// No description provided for @calActiveDays.
  ///
  /// In en, this message translates to:
  /// **'{active} / {total}'**
  String calActiveDays(Object active, Object total);

  /// No description provided for @calActiveLabel.
  ///
  /// In en, this message translates to:
  /// **'active days'**
  String get calActiveLabel;

  /// No description provided for @calAvg.
  ///
  /// In en, this message translates to:
  /// **'avg'**
  String get calAvg;

  /// No description provided for @calStrongest.
  ///
  /// In en, this message translates to:
  /// **'{area} strongest'**
  String calStrongest(Object area);

  /// No description provided for @calSelected.
  ///
  /// In en, this message translates to:
  /// **'Selected date'**
  String get calSelected;

  /// No description provided for @calStrongDay.
  ///
  /// In en, this message translates to:
  /// **'Strong & focused'**
  String get calStrongDay;

  /// No description provided for @calSteadyDay.
  ///
  /// In en, this message translates to:
  /// **'Steady'**
  String get calSteadyDay;

  /// No description provided for @calLightDay.
  ///
  /// In en, this message translates to:
  /// **'Light day'**
  String get calLightDay;

  /// No description provided for @calNoDay.
  ///
  /// In en, this message translates to:
  /// **'Not logged'**
  String get calNoDay;

  /// No description provided for @calFutureDay.
  ///
  /// In en, this message translates to:
  /// **'Upcoming'**
  String get calFutureDay;

  /// No description provided for @calTotalProgress.
  ///
  /// In en, this message translates to:
  /// **'{pct} total progress'**
  String calTotalProgress(Object pct);

  /// No description provided for @calActionsDone.
  ///
  /// In en, this message translates to:
  /// **'{done} of {total} actions done'**
  String calActionsDone(int done, int total);

  /// No description provided for @calContributions.
  ///
  /// In en, this message translates to:
  /// **'Category contributions'**
  String get calContributions;

  /// No description provided for @calEntries.
  ///
  /// In en, this message translates to:
  /// **'{n, plural, =1{1 entry} other{{n} entries}}'**
  String calEntries(int n);

  /// No description provided for @calActionsOn.
  ///
  /// In en, this message translates to:
  /// **'Actions on {date}'**
  String calActionsOn(Object date);

  /// No description provided for @calDone.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get calDone;

  /// No description provided for @calPending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get calPending;

  /// No description provided for @calNothing.
  ///
  /// In en, this message translates to:
  /// **'Nothing was logged on this day. Rest days are part of a sustainable rhythm.'**
  String get calNothing;

  /// No description provided for @calFutureNothing.
  ///
  /// In en, this message translates to:
  /// **'Plan this day from your daily plan.'**
  String get calFutureNothing;

  /// No description provided for @calOpenPlan.
  ///
  /// In en, this message translates to:
  /// **'Open plan'**
  String get calOpenPlan;

  /// No description provided for @calViewFull.
  ///
  /// In en, this message translates to:
  /// **'View full day breakdown'**
  String get calViewFull;

  /// No description provided for @calInsight.
  ///
  /// In en, this message translates to:
  /// **'Monthly rhythm insight'**
  String get calInsight;

  /// No description provided for @calInsightBody.
  ///
  /// In en, this message translates to:
  /// **'{first} and {second} were your most consistent days.'**
  String calInsightBody(Object first, Object second);

  /// No description provided for @reviewWinGoalCompleted.
  ///
  /// In en, this message translates to:
  /// **'Goal completed'**
  String get reviewWinGoalCompleted;

  /// No description provided for @reviewWinMilestone.
  ///
  /// In en, this message translates to:
  /// **'Milestone reached'**
  String get reviewWinMilestone;

  /// No description provided for @reviewWinMilestoneOf.
  ///
  /// In en, this message translates to:
  /// **'Milestone · {goal}'**
  String reviewWinMilestoneOf(Object goal);

  /// No description provided for @reviewWinMoved.
  ///
  /// In en, this message translates to:
  /// **'+{amount} logged'**
  String reviewWinMoved(Object amount);

  /// No description provided for @reviewWinConsistency.
  ///
  /// In en, this message translates to:
  /// **'Consistent {area} on {days} days'**
  String reviewWinConsistency(String area, int days);

  /// No description provided for @reviewWinConsistencyBody.
  ///
  /// In en, this message translates to:
  /// **'The rhythm held regardless of workload.'**
  String get reviewWinConsistencyBody;

  /// No description provided for @reviewGapNoLog.
  ///
  /// In en, this message translates to:
  /// **'No log'**
  String get reviewGapNoLog;

  /// No description provided for @reviewGapNoProgress.
  ///
  /// In en, this message translates to:
  /// **'No progress logged'**
  String get reviewGapNoProgress;

  /// No description provided for @reviewGapLow.
  ///
  /// In en, this message translates to:
  /// **'{area} consistency'**
  String reviewGapLow(Object area);

  /// No description provided for @reviewGapOf.
  ///
  /// In en, this message translates to:
  /// **'{done} of {target} completed'**
  String reviewGapOf(Object done, Object target);

  /// No description provided for @reviewPrioritiesAdd.
  ///
  /// In en, this message translates to:
  /// **'Add priority'**
  String get reviewPrioritiesAdd;

  /// No description provided for @reviewPriorityTitle.
  ///
  /// In en, this message translates to:
  /// **'Priority'**
  String get reviewPriorityTitle;

  /// No description provided for @reviewPriorityHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. Contact 25 qualified leads'**
  String get reviewPriorityHint;

  /// No description provided for @reviewPriorityArea.
  ///
  /// In en, this message translates to:
  /// **'Area'**
  String get reviewPriorityArea;

  /// No description provided for @reviewPriorityGoal.
  ///
  /// In en, this message translates to:
  /// **'Supports a goal'**
  String get reviewPriorityGoal;

  /// No description provided for @reviewPriorityNoGoal.
  ///
  /// In en, this message translates to:
  /// **'No goal'**
  String get reviewPriorityNoGoal;

  /// No description provided for @reviewPrioritySuggested.
  ///
  /// In en, this message translates to:
  /// **'From your goals'**
  String get reviewPrioritySuggested;

  /// No description provided for @reviewPriorityRemove.
  ///
  /// In en, this message translates to:
  /// **'Remove priority'**
  String get reviewPriorityRemove;

  /// No description provided for @reviewPriorityEdit.
  ///
  /// In en, this message translates to:
  /// **'Edit priority'**
  String get reviewPriorityEdit;

  /// No description provided for @reviewPriorityReorder.
  ///
  /// In en, this message translates to:
  /// **'Reorder priority {n}'**
  String reviewPriorityReorder(Object n);

  /// No description provided for @reviewSelected.
  ///
  /// In en, this message translates to:
  /// **'{n} selected'**
  String reviewSelected(int n);

  /// No description provided for @reviewPrioritiesEmpty.
  ///
  /// In en, this message translates to:
  /// **'Choose up to 3 keystone commitments.'**
  String get reviewPrioritiesEmpty;

  /// No description provided for @reviewPrioritiesMax.
  ///
  /// In en, this message translates to:
  /// **'Three priorities keeps focus sharp. Remove one to add another.'**
  String get reviewPrioritiesMax;

  /// No description provided for @reviewSaveDraft.
  ///
  /// In en, this message translates to:
  /// **'Save and finish later'**
  String get reviewSaveDraft;

  /// No description provided for @reviewSaved.
  ///
  /// In en, this message translates to:
  /// **'Review saved'**
  String get reviewSaved;

  /// No description provided for @reviewCompleted.
  ///
  /// In en, this message translates to:
  /// **'Review completed'**
  String get reviewCompleted;

  /// No description provided for @reviewCompletedOn.
  ///
  /// In en, this message translates to:
  /// **'Completed {date}. You can still update it.'**
  String reviewCompletedOn(Object date);

  /// No description provided for @reviewTagFocused.
  ///
  /// In en, this message translates to:
  /// **'Focused'**
  String get reviewTagFocused;

  /// No description provided for @reviewTagRoutine.
  ///
  /// In en, this message translates to:
  /// **'Good routine'**
  String get reviewTagRoutine;

  /// No description provided for @reviewTagQuran.
  ///
  /// In en, this message translates to:
  /// **'Quran consistency'**
  String get reviewTagQuran;

  /// No description provided for @reviewTagWork.
  ///
  /// In en, this message translates to:
  /// **'Strong work output'**
  String get reviewTagWork;

  /// No description provided for @reviewTagFamily.
  ///
  /// In en, this message translates to:
  /// **'Family time'**
  String get reviewTagFamily;

  /// No description provided for @reviewTagHealth.
  ///
  /// In en, this message translates to:
  /// **'Healthy habits'**
  String get reviewTagHealth;

  /// No description provided for @reviewTagDistraction.
  ///
  /// In en, this message translates to:
  /// **'Less distraction'**
  String get reviewTagDistraction;

  /// No description provided for @reviewTagSleep.
  ///
  /// In en, this message translates to:
  /// **'Sleep earlier'**
  String get reviewTagSleep;

  /// No description provided for @reviewTagFewerTasks.
  ///
  /// In en, this message translates to:
  /// **'Fewer tasks'**
  String get reviewTagFewerTasks;

  /// No description provided for @reviewTagProtectWorkout.
  ///
  /// In en, this message translates to:
  /// **'Protect workout time'**
  String get reviewTagProtectWorkout;

  /// No description provided for @reviewTagPlanAhead.
  ///
  /// In en, this message translates to:
  /// **'Plan ahead'**
  String get reviewTagPlanAhead;

  /// No description provided for @reviewTagConsistency.
  ///
  /// In en, this message translates to:
  /// **'Consistency'**
  String get reviewTagConsistency;

  /// No description provided for @reviewTagWorkProgress.
  ///
  /// In en, this message translates to:
  /// **'Work progress'**
  String get reviewTagWorkProgress;

  /// No description provided for @reviewTagQuranMemo.
  ///
  /// In en, this message translates to:
  /// **'Quran memorization'**
  String get reviewTagQuranMemo;

  /// No description provided for @reviewTagFinance.
  ///
  /// In en, this message translates to:
  /// **'Financial discipline'**
  String get reviewTagFinance;

  /// No description provided for @reviewTagLateSleep.
  ///
  /// In en, this message translates to:
  /// **'Late sleep'**
  String get reviewTagLateSleep;

  /// No description provided for @reviewTagOverplanning.
  ///
  /// In en, this message translates to:
  /// **'Overplanning'**
  String get reviewTagOverplanning;

  /// No description provided for @reviewTagLowEnergy.
  ///
  /// In en, this message translates to:
  /// **'Low energy'**
  String get reviewTagLowEnergy;

  /// No description provided for @reviewTagBedtime.
  ///
  /// In en, this message translates to:
  /// **'Earlier bedtime'**
  String get reviewTagBedtime;

  /// No description provided for @reviewTagSimplerTargets.
  ///
  /// In en, this message translates to:
  /// **'Simpler targets'**
  String get reviewTagSimplerTargets;

  /// No description provided for @reviewTagDelegate.
  ///
  /// In en, this message translates to:
  /// **'Delegate more'**
  String get reviewTagDelegate;

  /// No description provided for @reviewTagFewerPriorities.
  ///
  /// In en, this message translates to:
  /// **'Fewer priorities'**
  String get reviewTagFewerPriorities;

  /// No description provided for @weeklyTitle.
  ///
  /// In en, this message translates to:
  /// **'Weekly Review'**
  String get weeklyTitle;

  /// No description provided for @weeklyGlance.
  ///
  /// In en, this message translates to:
  /// **'Your week at a glance'**
  String get weeklyGlance;

  /// No description provided for @weeklyGlanceBody.
  ///
  /// In en, this message translates to:
  /// **'A quick look at what moved forward.'**
  String get weeklyGlanceBody;

  /// No description provided for @weeklyOverall.
  ///
  /// In en, this message translates to:
  /// **'Overall progress'**
  String get weeklyOverall;

  /// No description provided for @weeklyActiveDays.
  ///
  /// In en, this message translates to:
  /// **'Active days'**
  String get weeklyActiveDays;

  /// No description provided for @weeklyActions.
  ///
  /// In en, this message translates to:
  /// **'Actions'**
  String get weeklyActions;

  /// No description provided for @weeklyGoalsMoved.
  ///
  /// In en, this message translates to:
  /// **'Goals moved'**
  String get weeklyGoalsMoved;

  /// No description provided for @weeklyGoalsUnit.
  ///
  /// In en, this message translates to:
  /// **'goals'**
  String get weeklyGoalsUnit;

  /// No description provided for @weeklyStrongest.
  ///
  /// In en, this message translates to:
  /// **'Strongest consistency'**
  String get weeklyStrongest;

  /// No description provided for @weeklyStrongestDays.
  ///
  /// In en, this message translates to:
  /// **'{active} of {total} active days'**
  String weeklyStrongestDays(int active, int total);

  /// No description provided for @weeklyStrongestBody.
  ///
  /// In en, this message translates to:
  /// **'This rhythm held steady through the week. Keep the same time slot.'**
  String get weeklyStrongestBody;

  /// No description provided for @weeklyAttention.
  ///
  /// In en, this message translates to:
  /// **'Needs attention'**
  String get weeklyAttention;

  /// No description provided for @weeklyAttentionBody.
  ///
  /// In en, this message translates to:
  /// **'Consider making next week\'s target here lighter or more specific.'**
  String get weeklyAttentionBody;

  /// No description provided for @weeklyBiggestWin.
  ///
  /// In en, this message translates to:
  /// **'Biggest win'**
  String get weeklyBiggestWin;

  /// No description provided for @weeklyEditWin.
  ///
  /// In en, this message translates to:
  /// **'Edit win'**
  String get weeklyEditWin;

  /// No description provided for @weeklyWinHint.
  ///
  /// In en, this message translates to:
  /// **'What was your biggest win this week?'**
  String get weeklyWinHint;

  /// No description provided for @weeklyAddWin.
  ///
  /// In en, this message translates to:
  /// **'Add your biggest win'**
  String get weeklyAddWin;

  /// No description provided for @weeklyDidntMove.
  ///
  /// In en, this message translates to:
  /// **'What didn\'t move?'**
  String get weeklyDidntMove;

  /// No description provided for @weeklyCarriedOver.
  ///
  /// In en, this message translates to:
  /// **'Carried over'**
  String get weeklyCarriedOver;

  /// No description provided for @weeklyAllMoved.
  ///
  /// In en, this message translates to:
  /// **'Every active goal moved this week.'**
  String get weeklyAllMoved;

  /// No description provided for @weeklyReflection.
  ///
  /// In en, this message translates to:
  /// **'Weekly reflection'**
  String get weeklyReflection;

  /// No description provided for @weeklyReflectionSub.
  ///
  /// In en, this message translates to:
  /// **'Quick notes to anchor insights'**
  String get weeklyReflectionSub;

  /// No description provided for @weeklyWentWell.
  ///
  /// In en, this message translates to:
  /// **'What went well?'**
  String get weeklyWentWell;

  /// No description provided for @weeklyWentWellHint.
  ///
  /// In en, this message translates to:
  /// **'Key moments or habits that worked...'**
  String get weeklyWentWellHint;

  /// No description provided for @weeklyChange.
  ///
  /// In en, this message translates to:
  /// **'What should change next week?'**
  String get weeklyChange;

  /// No description provided for @weeklyChangeHint.
  ///
  /// In en, this message translates to:
  /// **'Adjustments or focus areas...'**
  String get weeklyChangeHint;

  /// No description provided for @weeklyNextFocus.
  ///
  /// In en, this message translates to:
  /// **'Next week\'s focus'**
  String get weeklyNextFocus;

  /// No description provided for @weeklyNextFocusSub.
  ///
  /// In en, this message translates to:
  /// **'Keystone commitments for {range}'**
  String weeklyNextFocusSub(Object range);

  /// No description provided for @weeklyInsightCheckIn.
  ///
  /// In en, this message translates to:
  /// **'Days that started with a morning check-in scored {pct} higher on average.'**
  String weeklyInsightCheckIn(Object pct);

  /// No description provided for @weeklyInsightDays.
  ///
  /// In en, this message translates to:
  /// **'Your most consistent days were {first} and {second}.'**
  String weeklyInsightDays(Object first, Object second);

  /// No description provided for @weeklyFootnote.
  ///
  /// In en, this message translates to:
  /// **'Saves your reflection and adds your focus to next week\'s plan.'**
  String get weeklyFootnote;

  /// No description provided for @weeklyComplete.
  ///
  /// In en, this message translates to:
  /// **'Complete Weekly Review'**
  String get weeklyComplete;

  /// No description provided for @weeklyUpdate.
  ///
  /// In en, this message translates to:
  /// **'Update Weekly Review'**
  String get weeklyUpdate;

  /// No description provided for @weeklyFocusAdded.
  ///
  /// In en, this message translates to:
  /// **'Weekly focus added to your plan for {date}'**
  String weeklyFocusAdded(Object date);

  /// No description provided for @weeklyFocusBadge.
  ///
  /// In en, this message translates to:
  /// **'Weekly focus'**
  String get weeklyFocusBadge;

  /// No description provided for @monthlyTitle.
  ///
  /// In en, this message translates to:
  /// **'Monthly Review'**
  String get monthlyTitle;

  /// No description provided for @monthlyCadence.
  ///
  /// In en, this message translates to:
  /// **'Taqaddum · Monthly cadence'**
  String get monthlyCadence;

  /// No description provided for @monthlyHero.
  ///
  /// In en, this message translates to:
  /// **'Your month in perspective'**
  String get monthlyHero;

  /// No description provided for @monthlyHeroBody.
  ///
  /// In en, this message translates to:
  /// **'See what moved forward and what should change next.'**
  String get monthlyHeroBody;

  /// No description provided for @monthlyCompletion.
  ///
  /// In en, this message translates to:
  /// **'completion'**
  String get monthlyCompletion;

  /// No description provided for @monthlyVs.
  ///
  /// In en, this message translates to:
  /// **'{delta} vs {month}'**
  String monthlyVs(Object delta, Object month);

  /// No description provided for @monthlyReviewsDone.
  ///
  /// In en, this message translates to:
  /// **'Reviews done'**
  String get monthlyReviewsDone;

  /// No description provided for @monthlyActiveDomains.
  ///
  /// In en, this message translates to:
  /// **'{n, plural, =1{1 active domain} other{{n} active domains}}'**
  String monthlyActiveDomains(int n);

  /// No description provided for @monthlyInsights.
  ///
  /// In en, this message translates to:
  /// **'Constructive insights'**
  String get monthlyInsights;

  /// No description provided for @monthlyStrongestTitle.
  ///
  /// In en, this message translates to:
  /// **'{area} · {days} active days'**
  String monthlyStrongestTitle(String area, int days);

  /// No description provided for @monthlyStrongestBody.
  ///
  /// In en, this message translates to:
  /// **'Your most dependable rhythm this month. Protect what made it easy.'**
  String get monthlyStrongestBody;

  /// No description provided for @monthlyRefocus.
  ///
  /// In en, this message translates to:
  /// **'Area to refocus'**
  String get monthlyRefocus;

  /// No description provided for @monthlyRefocusTitle.
  ///
  /// In en, this message translates to:
  /// **'{area} · {pct} consistency'**
  String monthlyRefocusTitle(Object area, Object pct);

  /// No description provided for @monthlyRefocusBody.
  ///
  /// In en, this message translates to:
  /// **'A simpler weekly target may be easier to sustain next month.'**
  String get monthlyRefocusBody;

  /// No description provided for @monthlyGoals.
  ///
  /// In en, this message translates to:
  /// **'Active goals progress'**
  String get monthlyGoals;

  /// No description provided for @monthlyGoalsActive.
  ///
  /// In en, this message translates to:
  /// **'{n} active'**
  String monthlyGoalsActive(int n);

  /// No description provided for @monthlyGoalMoved.
  ///
  /// In en, this message translates to:
  /// **'+{amount} this month'**
  String monthlyGoalMoved(Object amount);

  /// No description provided for @monthlyGoalMilestones.
  ///
  /// In en, this message translates to:
  /// **'{n, plural, =1{1 milestone reached this month} other{{n} milestones reached this month}}'**
  String monthlyGoalMilestones(int n);

  /// No description provided for @monthlyGoalNoMove.
  ///
  /// In en, this message translates to:
  /// **'No progress logged this month'**
  String get monthlyGoalNoMove;

  /// No description provided for @monthlyTarget.
  ///
  /// In en, this message translates to:
  /// **'Target: {value}'**
  String monthlyTarget(Object value);

  /// No description provided for @monthlyQuote.
  ///
  /// In en, this message translates to:
  /// **'Momentum comes from regular reflection, not sudden intensity.'**
  String get monthlyQuote;

  /// No description provided for @monthlySnapshots.
  ///
  /// In en, this message translates to:
  /// **'Category snapshots'**
  String get monthlySnapshots;

  /// No description provided for @monthlySnapshotsSub.
  ///
  /// In en, this message translates to:
  /// **'Tap to inspect'**
  String get monthlySnapshotsSub;

  /// No description provided for @monthlyDeepWork.
  ///
  /// In en, this message translates to:
  /// **'{time} deep work'**
  String monthlyDeepWork(Object time);

  /// No description provided for @monthlyClientsWon.
  ///
  /// In en, this message translates to:
  /// **'{n, plural, =1{1 client won} other{{n} clients won}}'**
  String monthlyClientsWon(int n);

  /// No description provided for @monthlyLeads.
  ///
  /// In en, this message translates to:
  /// **'Leads'**
  String get monthlyLeads;

  /// No description provided for @monthlyFollowUps.
  ///
  /// In en, this message translates to:
  /// **'Follow-ups'**
  String get monthlyFollowUps;

  /// No description provided for @monthlyProposals.
  ///
  /// In en, this message translates to:
  /// **'Proposals'**
  String get monthlyProposals;

  /// No description provided for @monthlyRevenue.
  ///
  /// In en, this message translates to:
  /// **'Revenue'**
  String get monthlyRevenue;

  /// No description provided for @monthlyIncome.
  ///
  /// In en, this message translates to:
  /// **'Income'**
  String get monthlyIncome;

  /// No description provided for @monthlyExpenses.
  ///
  /// In en, this message translates to:
  /// **'Expenses'**
  String get monthlyExpenses;

  /// No description provided for @monthlySaved.
  ///
  /// In en, this message translates to:
  /// **'Saved'**
  String get monthlySaved;

  /// No description provided for @monthlyNet.
  ///
  /// In en, this message translates to:
  /// **'Net {amount}'**
  String monthlyNet(Object amount);

  /// No description provided for @monthlyPagesRead.
  ///
  /// In en, this message translates to:
  /// **'{pages} pages read'**
  String monthlyPagesRead(Object pages);

  /// No description provided for @monthlyActiveDaysShort.
  ///
  /// In en, this message translates to:
  /// **'{n, plural, =1{1 active day} other{{n} active days}}'**
  String monthlyActiveDaysShort(int n);

  /// No description provided for @monthlyMemorized.
  ///
  /// In en, this message translates to:
  /// **'Memorized'**
  String get monthlyMemorized;

  /// No description provided for @monthlyRevision.
  ///
  /// In en, this message translates to:
  /// **'Revision'**
  String get monthlyRevision;

  /// No description provided for @monthlyActive.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get monthlyActive;

  /// No description provided for @monthlyDays.
  ///
  /// In en, this message translates to:
  /// **'{n} days'**
  String monthlyDays(int n);

  /// No description provided for @monthlyWorkouts.
  ///
  /// In en, this message translates to:
  /// **'{n, plural, =1{1 workout} other{{n} workouts}}'**
  String monthlyWorkouts(int n);

  /// No description provided for @monthlyAvgSleepValue.
  ///
  /// In en, this message translates to:
  /// **'{time} sleep'**
  String monthlyAvgSleepValue(Object time);

  /// No description provided for @monthlyWalkDays.
  ///
  /// In en, this message translates to:
  /// **'Walk days'**
  String get monthlyWalkDays;

  /// No description provided for @monthlyAvgSleep.
  ///
  /// In en, this message translates to:
  /// **'Avg sleep'**
  String get monthlyAvgSleep;

  /// No description provided for @monthlyHabits.
  ///
  /// In en, this message translates to:
  /// **'Habits'**
  String get monthlyHabits;

  /// No description provided for @monthlyStudy.
  ///
  /// In en, this message translates to:
  /// **'{time} study'**
  String monthlyStudy(Object time);

  /// No description provided for @monthlySessions.
  ///
  /// In en, this message translates to:
  /// **'Sessions'**
  String get monthlySessions;

  /// No description provided for @monthlyTakeaways.
  ///
  /// In en, this message translates to:
  /// **'Takeaways'**
  String get monthlyTakeaways;

  /// No description provided for @monthlyFocus.
  ///
  /// In en, this message translates to:
  /// **'Focus'**
  String get monthlyFocus;

  /// No description provided for @monthlyNotes.
  ///
  /// In en, this message translates to:
  /// **'{n, plural, =1{1 note} other{{n} notes}}'**
  String monthlyNotes(int n);

  /// No description provided for @monthlyPersonalTasks.
  ///
  /// In en, this message translates to:
  /// **'Actions done'**
  String get monthlyPersonalTasks;

  /// No description provided for @monthlyNoData.
  ///
  /// In en, this message translates to:
  /// **'Nothing logged here this month.'**
  String get monthlyNoData;

  /// No description provided for @monthlyWins.
  ///
  /// In en, this message translates to:
  /// **'Biggest wins this month'**
  String get monthlyWins;

  /// No description provided for @monthlyNotPlanned.
  ///
  /// In en, this message translates to:
  /// **'What didn\'t go as planned'**
  String get monthlyNotPlanned;

  /// No description provided for @monthlyReflection.
  ///
  /// In en, this message translates to:
  /// **'Monthly reflection'**
  String get monthlyReflection;

  /// No description provided for @monthlyReflectionSub.
  ///
  /// In en, this message translates to:
  /// **'3 quick questions'**
  String get monthlyReflectionSub;

  /// No description provided for @monthlyProud.
  ///
  /// In en, this message translates to:
  /// **'1. What am I proud of?'**
  String get monthlyProud;

  /// No description provided for @monthlyHeldBack.
  ///
  /// In en, this message translates to:
  /// **'2. What held me back?'**
  String get monthlyHeldBack;

  /// No description provided for @monthlyDifferent.
  ///
  /// In en, this message translates to:
  /// **'3. What should I do differently next month?'**
  String get monthlyDifferent;

  /// No description provided for @monthlyNoteHint.
  ///
  /// In en, this message translates to:
  /// **'Add a note...'**
  String get monthlyNoteHint;

  /// No description provided for @monthlyLesson.
  ///
  /// In en, this message translates to:
  /// **'One lesson to carry forward'**
  String get monthlyLesson;

  /// No description provided for @monthlyLessonHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. Fewer priorities helped me finish more meaningful work.'**
  String get monthlyLessonHint;

  /// No description provided for @monthlyNextFocus.
  ///
  /// In en, this message translates to:
  /// **'{month} focus'**
  String monthlyNextFocus(Object month);

  /// No description provided for @monthlyNextFocusSub.
  ///
  /// In en, this message translates to:
  /// **'Top 3 committed priorities'**
  String get monthlyNextFocusSub;

  /// No description provided for @monthlyBalanced.
  ///
  /// In en, this message translates to:
  /// **'Your next-month focus looks balanced across {n} areas.'**
  String monthlyBalanced(int n);

  /// No description provided for @monthlyNarrow.
  ///
  /// In en, this message translates to:
  /// **'All priorities sit in one area. That\'s fine if it\'s intentional.'**
  String get monthlyNarrow;

  /// No description provided for @monthlyComplete.
  ///
  /// In en, this message translates to:
  /// **'Complete Monthly Review'**
  String get monthlyComplete;

  /// No description provided for @monthlyUpdate.
  ///
  /// In en, this message translates to:
  /// **'Update Monthly Review'**
  String get monthlyUpdate;

  /// No description provided for @monthlyNothingYet.
  ///
  /// In en, this message translates to:
  /// **'Nothing to highlight yet. Log progress through the month and it will appear here.'**
  String get monthlyNothingYet;

  /// No description provided for @activityTitle.
  ///
  /// In en, this message translates to:
  /// **'Activity History'**
  String get activityTitle;

  /// No description provided for @activitySearchHint.
  ///
  /// In en, this message translates to:
  /// **'Search activity, notes, metrics...'**
  String get activitySearchHint;

  /// No description provided for @activityClearSearch.
  ///
  /// In en, this message translates to:
  /// **'Clear search'**
  String get activityClearSearch;

  /// No description provided for @activityAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get activityAll;

  /// No description provided for @activityReviews.
  ///
  /// In en, this message translates to:
  /// **'Reviews'**
  String get activityReviews;

  /// No description provided for @activityReview.
  ///
  /// In en, this message translates to:
  /// **'Review'**
  String get activityReview;

  /// No description provided for @activityEntries.
  ///
  /// In en, this message translates to:
  /// **'{n, plural, =1{1 entry} other{{n} entries}}'**
  String activityEntries(int n);

  /// No description provided for @activityAreas.
  ///
  /// In en, this message translates to:
  /// **'{n, plural, =0{no focus areas} =1{1 focus area} other{{n} focus areas}}'**
  String activityAreas(int n);

  /// No description provided for @activityShowing.
  ///
  /// In en, this message translates to:
  /// **'Showing {entries} across {areas}'**
  String activityShowing(Object areas, Object entries);

  /// No description provided for @activityLogs.
  ///
  /// In en, this message translates to:
  /// **'{n, plural, =1{1 log} other{{n} logs}}'**
  String activityLogs(int n);

  /// No description provided for @activityToday.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get activityToday;

  /// No description provided for @activityYesterday.
  ///
  /// In en, this message translates to:
  /// **'Yesterday'**
  String get activityYesterday;

  /// No description provided for @activityRangeTitle.
  ///
  /// In en, this message translates to:
  /// **'Date range'**
  String get activityRangeTitle;

  /// No description provided for @activityRangeAll.
  ///
  /// In en, this message translates to:
  /// **'All time'**
  String get activityRangeAll;

  /// No description provided for @activityRangeWeek.
  ///
  /// In en, this message translates to:
  /// **'This week'**
  String get activityRangeWeek;

  /// No description provided for @activityRangeMonth.
  ///
  /// In en, this message translates to:
  /// **'This month'**
  String get activityRangeMonth;

  /// No description provided for @activityRangeLastMonth.
  ///
  /// In en, this message translates to:
  /// **'Last month'**
  String get activityRangeLastMonth;

  /// No description provided for @activityRangeYear.
  ///
  /// In en, this message translates to:
  /// **'This year'**
  String get activityRangeYear;

  /// No description provided for @activityFilterDate.
  ///
  /// In en, this message translates to:
  /// **'Filter by date range'**
  String get activityFilterDate;

  /// No description provided for @activityEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'No logs found'**
  String get activityEmptyTitle;

  /// No description provided for @activityEmptyBody.
  ///
  /// In en, this message translates to:
  /// **'No activities matched your current category or search query.'**
  String get activityEmptyBody;

  /// No description provided for @activityReset.
  ///
  /// In en, this message translates to:
  /// **'Reset filters'**
  String get activityReset;

  /// No description provided for @activityNothingTitle.
  ///
  /// In en, this message translates to:
  /// **'No activity yet'**
  String get activityNothingTitle;

  /// No description provided for @activityNothingBody.
  ///
  /// In en, this message translates to:
  /// **'Everything you log, from actions and Quran to work, money, health, and learning, appears here.'**
  String get activityNothingBody;

  /// No description provided for @activityDetail.
  ///
  /// In en, this message translates to:
  /// **'Activity detail'**
  String get activityDetail;

  /// No description provided for @activityLoggedTime.
  ///
  /// In en, this message translates to:
  /// **'Logged time'**
  String get activityLoggedTime;

  /// No description provided for @activityAmount.
  ///
  /// In en, this message translates to:
  /// **'Amount'**
  String get activityAmount;

  /// No description provided for @activityType.
  ///
  /// In en, this message translates to:
  /// **'Type'**
  String get activityType;

  /// No description provided for @activityDismiss.
  ///
  /// In en, this message translates to:
  /// **'Dismiss'**
  String get activityDismiss;

  /// No description provided for @activityOpenPlan.
  ///
  /// In en, this message translates to:
  /// **'Open day plan'**
  String get activityOpenPlan;

  /// No description provided for @activityOpenGoal.
  ///
  /// In en, this message translates to:
  /// **'Open goal'**
  String get activityOpenGoal;

  /// No description provided for @activityTypeCreated.
  ///
  /// In en, this message translates to:
  /// **'Created'**
  String get activityTypeCreated;

  /// No description provided for @activityTypeCompleted.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get activityTypeCompleted;

  /// No description provided for @activityTypeLogged.
  ///
  /// In en, this message translates to:
  /// **'Logged'**
  String get activityTypeLogged;

  /// No description provided for @activityTypeReviewed.
  ///
  /// In en, this message translates to:
  /// **'Reviewed'**
  String get activityTypeReviewed;

  /// No description provided for @activityTypeUpdated.
  ///
  /// In en, this message translates to:
  /// **'Updated'**
  String get activityTypeUpdated;

  /// No description provided for @activityTypeMilestone.
  ///
  /// In en, this message translates to:
  /// **'Milestone'**
  String get activityTypeMilestone;

  /// No description provided for @notifTitle.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifTitle;

  /// No description provided for @notifHeadline.
  ///
  /// In en, this message translates to:
  /// **'Notifications & Reminders'**
  String get notifHeadline;

  /// No description provided for @notifSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Choose the reminders that help you stay consistent.'**
  String get notifSubtitle;

  /// No description provided for @notifActiveCount.
  ///
  /// In en, this message translates to:
  /// **'{n, plural, =0{No active reminders} =1{1 active reminder} other{{n} active reminders}}'**
  String notifActiveCount(int n);

  /// No description provided for @notifQuietActive.
  ///
  /// In en, this message translates to:
  /// **'Quiet hours active ({range})'**
  String notifQuietActive(Object range);

  /// No description provided for @notifPaused.
  ///
  /// In en, this message translates to:
  /// **'All reminders paused'**
  String get notifPaused;

  /// No description provided for @notifAll.
  ///
  /// In en, this message translates to:
  /// **'All notifications'**
  String get notifAll;

  /// No description provided for @notifAllBody.
  ///
  /// In en, this message translates to:
  /// **'Pause all Taqaddum reminders without losing your scheduled times.'**
  String get notifAllBody;

  /// No description provided for @notifDailyRoutine.
  ///
  /// In en, this message translates to:
  /// **'Daily routine'**
  String get notifDailyRoutine;

  /// No description provided for @notifMorningBody.
  ///
  /// In en, this message translates to:
  /// **'Start the day with your 3 keystone priorities.'**
  String get notifMorningBody;

  /// No description provided for @notifNightBody.
  ///
  /// In en, this message translates to:
  /// **'Close the day with a quiet 3-question reflection.'**
  String get notifNightBody;

  /// No description provided for @notifQuranSection.
  ///
  /// In en, this message translates to:
  /// **'Quran & Spiritual'**
  String get notifQuranSection;

  /// No description provided for @notifQuranReading.
  ///
  /// In en, this message translates to:
  /// **'Daily reading reminder'**
  String get notifQuranReading;

  /// No description provided for @notifQuranReadingBody.
  ///
  /// In en, this message translates to:
  /// **'A gentle reminder for today\'s Quran reading.'**
  String get notifQuranReadingBody;

  /// No description provided for @notifQuranMemo.
  ///
  /// In en, this message translates to:
  /// **'Memorization practice'**
  String get notifQuranMemo;

  /// No description provided for @notifQuranMemoBody.
  ///
  /// In en, this message translates to:
  /// **'Continue your active memorization.'**
  String get notifQuranMemoBody;

  /// No description provided for @notifQuranRevision.
  ///
  /// In en, this message translates to:
  /// **'Revision & review'**
  String get notifQuranRevision;

  /// No description provided for @notifQuranRevisionBody.
  ///
  /// In en, this message translates to:
  /// **'Keep previously memorized pages fresh.'**
  String get notifQuranRevisionBody;

  /// No description provided for @notifHabitsSection.
  ///
  /// In en, this message translates to:
  /// **'Habits & Health'**
  String get notifHabitsSection;

  /// No description provided for @notifManageHabits.
  ///
  /// In en, this message translates to:
  /// **'Manage habit reminders'**
  String get notifManageHabits;

  /// No description provided for @notifNoHabitReminders.
  ///
  /// In en, this message translates to:
  /// **'No habit reminders yet.'**
  String get notifNoHabitReminders;

  /// No description provided for @notifAddHabit.
  ///
  /// In en, this message translates to:
  /// **'Add a habit'**
  String get notifAddHabit;

  /// No description provided for @notifHabitPicker.
  ///
  /// In en, this message translates to:
  /// **'Habit reminders'**
  String get notifHabitPicker;

  /// No description provided for @notifHabitPickerBody.
  ///
  /// In en, this message translates to:
  /// **'Choose a habit, then pick a time.'**
  String get notifHabitPickerBody;

  /// No description provided for @notifHabitSet.
  ///
  /// In en, this message translates to:
  /// **'Reminder at {time}'**
  String notifHabitSet(Object time);

  /// No description provided for @notifHabitNone.
  ///
  /// In en, this message translates to:
  /// **'No reminder'**
  String get notifHabitNone;

  /// No description provided for @notifRemoveReminder.
  ///
  /// In en, this message translates to:
  /// **'Remove reminder'**
  String get notifRemoveReminder;

  /// No description provided for @notifWorkSection.
  ///
  /// In en, this message translates to:
  /// **'Work & Business'**
  String get notifWorkSection;

  /// No description provided for @notifFollowUps.
  ///
  /// In en, this message translates to:
  /// **'Follow-up reminders'**
  String get notifFollowUps;

  /// No description provided for @notifFollowUpsBody.
  ///
  /// In en, this message translates to:
  /// **'Remind me when proposals or lead follow-ups are due.'**
  String get notifFollowUpsBody;

  /// No description provided for @notifMorningSummary.
  ///
  /// In en, this message translates to:
  /// **'Morning summary ({time})'**
  String notifMorningSummary(Object time);

  /// No description provided for @notifReviewsSection.
  ///
  /// In en, this message translates to:
  /// **'Cadence reviews'**
  String get notifReviewsSection;

  /// No description provided for @notifWeeklyBody.
  ///
  /// In en, this message translates to:
  /// **'Reflect on the week and set your next 3 priorities.'**
  String get notifWeeklyBody;

  /// No description provided for @notifMonthlyBody.
  ///
  /// In en, this message translates to:
  /// **'Review your month and plan the next one.'**
  String get notifMonthlyBody;

  /// No description provided for @notifEvery.
  ///
  /// In en, this message translates to:
  /// **'Every {day} · {time}'**
  String notifEvery(Object day, Object time);

  /// No description provided for @notifLastDay.
  ///
  /// In en, this message translates to:
  /// **'Last day of month · {time}'**
  String notifLastDay(Object time);

  /// No description provided for @notifReviewDay.
  ///
  /// In en, this message translates to:
  /// **'Review day'**
  String get notifReviewDay;

  /// No description provided for @notifQuietSection.
  ///
  /// In en, this message translates to:
  /// **'Quiet hours & Calm UX'**
  String get notifQuietSection;

  /// No description provided for @notifQuiet.
  ///
  /// In en, this message translates to:
  /// **'Quiet hours'**
  String get notifQuiet;

  /// No description provided for @notifQuietBody.
  ///
  /// In en, this message translates to:
  /// **'No sound or pop-up reminders during your rest window.'**
  String get notifQuietBody;

  /// No description provided for @notifQuietStart.
  ///
  /// In en, this message translates to:
  /// **'Quiet hours start'**
  String get notifQuietStart;

  /// No description provided for @notifQuietEnd.
  ///
  /// In en, this message translates to:
  /// **'Quiet hours end'**
  String get notifQuietEnd;

  /// No description provided for @notifSmart.
  ///
  /// In en, this message translates to:
  /// **'Smart reminder suppression'**
  String get notifSmart;

  /// No description provided for @notifSmartBody.
  ///
  /// In en, this message translates to:
  /// **'If you already logged the activity (for example read Quran or completed a habit), Taqaddum skips that day\'s reminder.'**
  String get notifSmartBody;

  /// No description provided for @notifActive.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get notifActive;

  /// No description provided for @notifOff.
  ///
  /// In en, this message translates to:
  /// **'Off'**
  String get notifOff;

  /// No description provided for @notifPreview.
  ///
  /// In en, this message translates to:
  /// **'Preview'**
  String get notifPreview;

  /// No description provided for @notifPreviewNext.
  ///
  /// In en, this message translates to:
  /// **'Next · {when}'**
  String notifPreviewNext(Object when);

  /// No description provided for @notifPreviewNone.
  ///
  /// In en, this message translates to:
  /// **'No upcoming reminders with your current settings.'**
  String get notifPreviewNone;

  /// No description provided for @notifInQuiet.
  ///
  /// In en, this message translates to:
  /// **'Falls in quiet hours'**
  String get notifInQuiet;

  /// No description provided for @notifDaily.
  ///
  /// In en, this message translates to:
  /// **'Daily'**
  String get notifDaily;

  /// No description provided for @notifWeekdays.
  ///
  /// In en, this message translates to:
  /// **'Weekdays'**
  String get notifWeekdays;

  /// No description provided for @notifRepeat.
  ///
  /// In en, this message translates to:
  /// **'Repeat on'**
  String get notifRepeat;

  /// No description provided for @notifDays.
  ///
  /// In en, this message translates to:
  /// **'Days'**
  String get notifDays;

  /// No description provided for @notifAuthorized.
  ///
  /// In en, this message translates to:
  /// **'System notifications are authorized'**
  String get notifAuthorized;

  /// No description provided for @notifDenied.
  ///
  /// In en, this message translates to:
  /// **'Notifications are off for Taqaddum'**
  String get notifDenied;

  /// No description provided for @notifDeniedBody.
  ///
  /// In en, this message translates to:
  /// **'Reminders can\'t appear until you allow notifications. If the prompt doesn\'t show, enable them in your device Settings.'**
  String get notifDeniedBody;

  /// No description provided for @notifAllow.
  ///
  /// In en, this message translates to:
  /// **'Allow notifications'**
  String get notifAllow;

  /// No description provided for @notifTime.
  ///
  /// In en, this message translates to:
  /// **'Time'**
  String get notifTime;

  /// No description provided for @profileTitle.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profileTitle;

  /// No description provided for @profileSettings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get profileSettings;

  /// No description provided for @profileEdit.
  ///
  /// In en, this message translates to:
  /// **'Edit profile'**
  String get profileEdit;

  /// No description provided for @profileMember.
  ///
  /// In en, this message translates to:
  /// **'Taqaddum member · Personal workspace'**
  String get profileMember;

  /// No description provided for @profileCurrentFocus.
  ///
  /// In en, this message translates to:
  /// **'Current focus'**
  String get profileCurrentFocus;

  /// No description provided for @profilePrimaryFocus.
  ///
  /// In en, this message translates to:
  /// **'Primary focus'**
  String get profilePrimaryFocus;

  /// No description provided for @profileTarget.
  ///
  /// In en, this message translates to:
  /// **'Target: {value}'**
  String profileTarget(Object value);

  /// No description provided for @profileInitiated.
  ///
  /// In en, this message translates to:
  /// **'Started {date}'**
  String profileInitiated(Object date);

  /// No description provided for @profileNext.
  ///
  /// In en, this message translates to:
  /// **'Next: {action}'**
  String profileNext(Object action);

  /// No description provided for @profileNoFocus.
  ///
  /// In en, this message translates to:
  /// **'No primary focus yet'**
  String get profileNoFocus;

  /// No description provided for @profileNoFocusBody.
  ///
  /// In en, this message translates to:
  /// **'Mark one goal as your primary focus to keep it front and center.'**
  String get profileNoFocusBody;

  /// No description provided for @profileChooseFocus.
  ///
  /// In en, this message translates to:
  /// **'Choose a focus'**
  String get profileChooseFocus;

  /// No description provided for @profileYearProgress.
  ///
  /// In en, this message translates to:
  /// **'{year} progress'**
  String profileYearProgress(Object year);

  /// No description provided for @profileAnnual.
  ///
  /// In en, this message translates to:
  /// **'Annual horizon'**
  String get profileAnnual;

  /// No description provided for @profileAlignment.
  ///
  /// In en, this message translates to:
  /// **'Overall consistency across your focus areas'**
  String get profileAlignment;

  /// No description provided for @profileOnSchedule.
  ///
  /// In en, this message translates to:
  /// **'On schedule'**
  String get profileOnSchedule;

  /// No description provided for @profileSteady.
  ///
  /// In en, this message translates to:
  /// **'Steady'**
  String get profileSteady;

  /// No description provided for @profileBuilding.
  ///
  /// In en, this message translates to:
  /// **'Building'**
  String get profileBuilding;

  /// No description provided for @profileActiveConsistency.
  ///
  /// In en, this message translates to:
  /// **'Active consistency'**
  String get profileActiveConsistency;

  /// No description provided for @profileActiveThisMonth.
  ///
  /// In en, this message translates to:
  /// **'Active this month'**
  String get profileActiveThisMonth;

  /// No description provided for @profileYearGoals.
  ///
  /// In en, this message translates to:
  /// **'Year goals'**
  String get profileYearGoals;

  /// No description provided for @profileGoalsSummary.
  ///
  /// In en, this message translates to:
  /// **'{active} active · {done} done'**
  String profileGoalsSummary(int active, int done);

  /// No description provided for @profileGoalsTotal.
  ///
  /// In en, this message translates to:
  /// **'{n} total declared'**
  String profileGoalsTotal(int n);

  /// No description provided for @profileLifeAreas.
  ///
  /// In en, this message translates to:
  /// **'My life areas'**
  String get profileLifeAreas;

  /// No description provided for @profileLifeAreasSub.
  ///
  /// In en, this message translates to:
  /// **'{n, plural, =1{1 active life area} other{{n} active life areas}}'**
  String profileLifeAreasSub(int n);

  /// No description provided for @profileEditAreas.
  ///
  /// In en, this message translates to:
  /// **'Edit life areas'**
  String get profileEditAreas;

  /// No description provided for @profileAreaActive.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get profileAreaActive;

  /// No description provided for @profileAreaOff.
  ///
  /// In en, this message translates to:
  /// **'Off'**
  String get profileAreaOff;

  /// No description provided for @profileIntention.
  ///
  /// In en, this message translates to:
  /// **'{year} intention'**
  String profileIntention(Object year);

  /// No description provided for @profileIntentionHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. Build a balanced year with faith, meaningful work, and family.'**
  String get profileIntentionHint;

  /// No description provided for @profileAddIntention.
  ///
  /// In en, this message translates to:
  /// **'Add your intention for the year'**
  String get profileAddIntention;

  /// No description provided for @profileEditIntention.
  ///
  /// In en, this message translates to:
  /// **'Edit intention'**
  String get profileEditIntention;

  /// No description provided for @profileYourTaqaddum.
  ///
  /// In en, this message translates to:
  /// **'Your Taqaddum'**
  String get profileYourTaqaddum;

  /// No description provided for @profileActivity.
  ///
  /// In en, this message translates to:
  /// **'Activity history'**
  String get profileActivity;

  /// No description provided for @profileActivityBody.
  ///
  /// In en, this message translates to:
  /// **'See your past activity and logs'**
  String get profileActivityBody;

  /// No description provided for @profileWeekly.
  ///
  /// In en, this message translates to:
  /// **'Weekly review'**
  String get profileWeekly;

  /// No description provided for @profileWeeklyBody.
  ///
  /// In en, this message translates to:
  /// **'Reflect on your week'**
  String get profileWeeklyBody;

  /// No description provided for @profileMonthly.
  ///
  /// In en, this message translates to:
  /// **'Monthly review'**
  String get profileMonthly;

  /// No description provided for @profileMonthlyBody.
  ///
  /// In en, this message translates to:
  /// **'Review your monthly progress'**
  String get profileMonthlyBody;

  /// No description provided for @profileNotifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications & reminders'**
  String get profileNotifications;

  /// No description provided for @profileNotificationsBody.
  ///
  /// In en, this message translates to:
  /// **'Manage reminders and quiet hours'**
  String get profileNotificationsBody;

  /// No description provided for @profileSettingsBody.
  ///
  /// In en, this message translates to:
  /// **'Language, preferences, account and app options'**
  String get profileSettingsBody;

  /// No description provided for @profileExport.
  ///
  /// In en, this message translates to:
  /// **'Export my data'**
  String get profileExport;

  /// No description provided for @profileBackup.
  ///
  /// In en, this message translates to:
  /// **'Stored on this device'**
  String get profileBackup;

  /// No description provided for @profileFooter.
  ///
  /// In en, this message translates to:
  /// **'Taqaddum v{version} · Using since {date}'**
  String profileFooter(Object date, Object version);

  /// No description provided for @profilePrivate.
  ///
  /// In en, this message translates to:
  /// **'Private and on-device'**
  String get profilePrivate;

  /// No description provided for @profileName.
  ///
  /// In en, this message translates to:
  /// **'Full name'**
  String get profileName;

  /// No description provided for @profileRole.
  ///
  /// In en, this message translates to:
  /// **'Role'**
  String get profileRole;

  /// No description provided for @profileRoleHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. Entrepreneur'**
  String get profileRoleHint;

  /// No description provided for @profileSaved.
  ///
  /// In en, this message translates to:
  /// **'Profile updated'**
  String get profileSaved;

  /// No description provided for @settingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// No description provided for @settingsUpdated.
  ///
  /// In en, this message translates to:
  /// **'Preference updated'**
  String get settingsUpdated;

  /// No description provided for @settingsPreferences.
  ///
  /// In en, this message translates to:
  /// **'Preferences'**
  String get settingsPreferences;

  /// No description provided for @settingsLanguage.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get settingsLanguage;

  /// No description provided for @settingsReduceMotion.
  ///
  /// In en, this message translates to:
  /// **'Reduce motion'**
  String get settingsReduceMotion;

  /// No description provided for @settingsReduceMotionBody.
  ///
  /// In en, this message translates to:
  /// **'Shorter, simpler transitions'**
  String get settingsReduceMotionBody;

  /// No description provided for @settingsPlanning.
  ///
  /// In en, this message translates to:
  /// **'Planning'**
  String get settingsPlanning;

  /// No description provided for @settingsWeekStart.
  ///
  /// In en, this message translates to:
  /// **'Week starts on'**
  String get settingsWeekStart;

  /// No description provided for @settingsCurrency.
  ///
  /// In en, this message translates to:
  /// **'Currency'**
  String get settingsCurrency;

  /// No description provided for @settingsTimeFormat.
  ///
  /// In en, this message translates to:
  /// **'Time format'**
  String get settingsTimeFormat;

  /// No description provided for @settings24h.
  ///
  /// In en, this message translates to:
  /// **'24-hour'**
  String get settings24h;

  /// No description provided for @settings12h.
  ///
  /// In en, this message translates to:
  /// **'12-hour'**
  String get settings12h;

  /// No description provided for @settingsNotifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get settingsNotifications;

  /// No description provided for @settingsNotificationsBody.
  ///
  /// In en, this message translates to:
  /// **'Manage reminder schedule and quiet hours'**
  String get settingsNotificationsBody;

  /// No description provided for @settingsOn.
  ///
  /// In en, this message translates to:
  /// **'On'**
  String get settingsOn;

  /// No description provided for @settingsOff.
  ///
  /// In en, this message translates to:
  /// **'Off'**
  String get settingsOff;

  /// No description provided for @settingsPersonalization.
  ///
  /// In en, this message translates to:
  /// **'Personalization'**
  String get settingsPersonalization;

  /// No description provided for @settingsLifeAreas.
  ///
  /// In en, this message translates to:
  /// **'Life areas'**
  String get settingsLifeAreas;

  /// No description provided for @settingsLifeAreasBody.
  ///
  /// In en, this message translates to:
  /// **'Choose the areas you track'**
  String get settingsLifeAreasBody;

  /// No description provided for @settingsLifeAreasCount.
  ///
  /// In en, this message translates to:
  /// **'{n} active'**
  String settingsLifeAreasCount(int n);

  /// No description provided for @settingsLifeAreasMin.
  ///
  /// In en, this message translates to:
  /// **'Keep at least one area active.'**
  String get settingsLifeAreasMin;

  /// No description provided for @settingsPrimaryFocus.
  ///
  /// In en, this message translates to:
  /// **'Primary focus'**
  String get settingsPrimaryFocus;

  /// No description provided for @settingsPrimaryFocusBody.
  ///
  /// In en, this message translates to:
  /// **'Your current keystone commitment'**
  String get settingsPrimaryFocusBody;

  /// No description provided for @settingsNoGoals.
  ///
  /// In en, this message translates to:
  /// **'Create a goal first'**
  String get settingsNoGoals;

  /// No description provided for @settingsDataPrivacy.
  ///
  /// In en, this message translates to:
  /// **'Data & Privacy'**
  String get settingsDataPrivacy;

  /// No description provided for @settingsActivity.
  ///
  /// In en, this message translates to:
  /// **'Activity history'**
  String get settingsActivity;

  /// No description provided for @settingsActivityBody.
  ///
  /// In en, this message translates to:
  /// **'Review your past logs and entries'**
  String get settingsActivityBody;

  /// No description provided for @settingsExport.
  ///
  /// In en, this message translates to:
  /// **'Export my data'**
  String get settingsExport;

  /// No description provided for @settingsExportBody.
  ///
  /// In en, this message translates to:
  /// **'Create a copy of your progress data'**
  String get settingsExportBody;

  /// No description provided for @settingsExportJson.
  ///
  /// In en, this message translates to:
  /// **'JSON (complete backup)'**
  String get settingsExportJson;

  /// No description provided for @settingsExportJsonBody.
  ///
  /// In en, this message translates to:
  /// **'Every table in one file'**
  String get settingsExportJsonBody;

  /// No description provided for @settingsExportCsv.
  ///
  /// In en, this message translates to:
  /// **'CSV (spreadsheets)'**
  String get settingsExportCsv;

  /// No description provided for @settingsExportCsvBody.
  ///
  /// In en, this message translates to:
  /// **'Transactions and activity log'**
  String get settingsExportCsvBody;

  /// No description provided for @settingsExportFailed.
  ///
  /// In en, this message translates to:
  /// **'Export failed. Please try again.'**
  String get settingsExportFailed;

  /// No description provided for @settingsPrivacy.
  ///
  /// In en, this message translates to:
  /// **'Privacy & security'**
  String get settingsPrivacy;

  /// No description provided for @settingsPrivacyBody.
  ///
  /// In en, this message translates to:
  /// **'Local storage, no third-party tracking'**
  String get settingsPrivacyBody;

  /// No description provided for @settingsPrivacyP4.
  ///
  /// In en, this message translates to:
  /// **'Everything you log is stored in the app\'s private storage on this device. Uninstalling the app removes it, so export a copy if you want a backup.'**
  String get settingsPrivacyP4;

  /// No description provided for @settingsAccount.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get settingsAccount;

  /// No description provided for @settingsAccountProfile.
  ///
  /// In en, this message translates to:
  /// **'Account profile'**
  String get settingsAccountProfile;

  /// No description provided for @settingsEmail.
  ///
  /// In en, this message translates to:
  /// **'Email address'**
  String get settingsEmail;

  /// No description provided for @settingsEmailNone.
  ///
  /// In en, this message translates to:
  /// **'Not set'**
  String get settingsEmailNone;

  /// No description provided for @settingsEmailSaved.
  ///
  /// In en, this message translates to:
  /// **'Email updated'**
  String get settingsEmailSaved;

  /// No description provided for @settingsSecurity.
  ///
  /// In en, this message translates to:
  /// **'Sign-in security'**
  String get settingsSecurity;

  /// No description provided for @settingsPasswordSet.
  ///
  /// In en, this message translates to:
  /// **'Password set'**
  String get settingsPasswordSet;

  /// No description provided for @settingsPasswordNone.
  ///
  /// In en, this message translates to:
  /// **'No password'**
  String get settingsPasswordNone;

  /// No description provided for @settingsPasswordTitle.
  ///
  /// In en, this message translates to:
  /// **'Change password'**
  String get settingsPasswordTitle;

  /// No description provided for @settingsPasswordAddTitle.
  ///
  /// In en, this message translates to:
  /// **'Add a password'**
  String get settingsPasswordAddTitle;

  /// No description provided for @settingsPasswordCurrent.
  ///
  /// In en, this message translates to:
  /// **'Current password'**
  String get settingsPasswordCurrent;

  /// No description provided for @settingsPasswordNew.
  ///
  /// In en, this message translates to:
  /// **'New password'**
  String get settingsPasswordNew;

  /// No description provided for @settingsPasswordSaved.
  ///
  /// In en, this message translates to:
  /// **'Password saved'**
  String get settingsPasswordSaved;

  /// No description provided for @settingsPasswordNeedsEmail.
  ///
  /// In en, this message translates to:
  /// **'Add an email first. You\'ll use it with your password to sign in.'**
  String get settingsPasswordNeedsEmail;

  /// No description provided for @settingsLogout.
  ///
  /// In en, this message translates to:
  /// **'Log out'**
  String get settingsLogout;

  /// No description provided for @settingsLogoutTitle.
  ///
  /// In en, this message translates to:
  /// **'Log out?'**
  String get settingsLogoutTitle;

  /// No description provided for @settingsLogoutBody.
  ///
  /// In en, this message translates to:
  /// **'Your data stays on this device. Sign in again to continue where you left off.'**
  String get settingsLogoutBody;

  /// No description provided for @settingsLogoutNoPassword.
  ///
  /// In en, this message translates to:
  /// **'This device has no password. You can continue on this device from the sign-in screen at any time.'**
  String get settingsLogoutNoPassword;

  /// No description provided for @settingsSupport.
  ///
  /// In en, this message translates to:
  /// **'Support & About'**
  String get settingsSupport;

  /// No description provided for @settingsHelp.
  ///
  /// In en, this message translates to:
  /// **'Help & FAQ'**
  String get settingsHelp;

  /// No description provided for @settingsHelpQ1.
  ///
  /// In en, this message translates to:
  /// **'Where is my data stored?'**
  String get settingsHelpQ1;

  /// No description provided for @settingsHelpA1.
  ///
  /// In en, this message translates to:
  /// **'Only on this device. Taqaddum works fully offline and never sends your records anywhere.'**
  String get settingsHelpA1;

  /// No description provided for @settingsHelpQ2.
  ///
  /// In en, this message translates to:
  /// **'How is progress calculated?'**
  String get settingsHelpQ2;

  /// No description provided for @settingsHelpA2.
  ///
  /// In en, this message translates to:
  /// **'A day\'s score is the share of planned actions you completed. Without a plan, three logged activities count as a full day.'**
  String get settingsHelpA2;

  /// No description provided for @settingsHelpQ3.
  ///
  /// In en, this message translates to:
  /// **'How do I back up?'**
  String get settingsHelpQ3;

  /// No description provided for @settingsHelpA3.
  ///
  /// In en, this message translates to:
  /// **'Use Export my data to save a JSON copy wherever you choose.'**
  String get settingsHelpA3;

  /// No description provided for @settingsHelpQ4.
  ///
  /// In en, this message translates to:
  /// **'Why didn\'t a reminder appear?'**
  String get settingsHelpQ4;

  /// No description provided for @settingsHelpA4.
  ///
  /// In en, this message translates to:
  /// **'Reminders are skipped during quiet hours, and smart suppression skips a reminder when you\'ve already logged that activity today.'**
  String get settingsHelpA4;

  /// No description provided for @settingsAbout.
  ///
  /// In en, this message translates to:
  /// **'About Taqaddum'**
  String get settingsAbout;

  /// No description provided for @settingsLicenses.
  ///
  /// In en, this message translates to:
  /// **'Open-source licenses'**
  String get settingsLicenses;

  /// No description provided for @settingsTerms.
  ///
  /// In en, this message translates to:
  /// **'Terms'**
  String get settingsTerms;

  /// No description provided for @settingsPrivacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get settingsPrivacyPolicy;

  /// No description provided for @settingsDanger.
  ///
  /// In en, this message translates to:
  /// **'Account actions'**
  String get settingsDanger;

  /// No description provided for @settingsDelete.
  ///
  /// In en, this message translates to:
  /// **'Delete account'**
  String get settingsDelete;

  /// No description provided for @settingsDeleteBody.
  ///
  /// In en, this message translates to:
  /// **'Permanently erase your Taqaddum account and every local record on this device.'**
  String get settingsDeleteBody;

  /// No description provided for @settingsDeleteTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete everything?'**
  String get settingsDeleteTitle;

  /// No description provided for @settingsDeleteConfirm.
  ///
  /// In en, this message translates to:
  /// **'This erases your account, goals, logs, reviews, reminders and preferences from this device. It cannot be undone.'**
  String get settingsDeleteConfirm;

  /// No description provided for @settingsDeleteButton.
  ///
  /// In en, this message translates to:
  /// **'Delete permanently'**
  String get settingsDeleteButton;

  /// No description provided for @settingsFooter.
  ///
  /// In en, this message translates to:
  /// **'Crafted for calm consistency'**
  String get settingsFooter;

  /// No description provided for @settingsDeveloper.
  ///
  /// In en, this message translates to:
  /// **'Developer'**
  String get settingsDeveloper;

  /// No description provided for @settingsDemo.
  ///
  /// In en, this message translates to:
  /// **'Load demo data'**
  String get settingsDemo;

  /// No description provided for @settingsDemoBody.
  ///
  /// In en, this message translates to:
  /// **'Fill the app with sample goals and logs for testing'**
  String get settingsDemoBody;

  /// No description provided for @settingsDemoConfirm.
  ///
  /// In en, this message translates to:
  /// **'This adds sample goals, tasks and logs to your current data. Use it only for testing.'**
  String get settingsDemoConfirm;

  /// No description provided for @settingsDemoDone.
  ///
  /// In en, this message translates to:
  /// **'Demo data added'**
  String get settingsDemoDone;

  /// No description provided for @activityCheckInTitle.
  ///
  /// In en, this message translates to:
  /// **'Morning check-in'**
  String get activityCheckInTitle;

  /// No description provided for @activityNightReviewTitle.
  ///
  /// In en, this message translates to:
  /// **'Night review completed'**
  String get activityNightReviewTitle;

  /// No description provided for @activityWeeklyReviewTitle.
  ///
  /// In en, this message translates to:
  /// **'Weekly review completed'**
  String get activityWeeklyReviewTitle;

  /// No description provided for @activityMonthlyReviewTitle.
  ///
  /// In en, this message translates to:
  /// **'Monthly review completed'**
  String get activityMonthlyReviewTitle;

  /// No description provided for @activityPrioritiesSet.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{No priorities set} =1{1 priority set} other{{count} priorities set}}'**
  String activityPrioritiesSet(int count);

  /// No description provided for @activityDayRated.
  ///
  /// In en, this message translates to:
  /// **'Day rated {rating} of 5'**
  String activityDayRated(int rating);

  /// No description provided for @activityDateRange.
  ///
  /// In en, this message translates to:
  /// **'{start} – {end}'**
  String activityDateRange(String start, String end);

  /// No description provided for @activityHabitAdded.
  ///
  /// In en, this message translates to:
  /// **'Habit added'**
  String get activityHabitAdded;

  /// No description provided for @activityHabit.
  ///
  /// In en, this message translates to:
  /// **'Habit'**
  String get activityHabit;

  /// No description provided for @activityGoalCreated.
  ///
  /// In en, this message translates to:
  /// **'Goal created'**
  String get activityGoalCreated;

  /// No description provided for @activityGoalUpdated.
  ///
  /// In en, this message translates to:
  /// **'Goal updated'**
  String get activityGoalUpdated;

  /// No description provided for @activityGoalCompleted.
  ///
  /// In en, this message translates to:
  /// **'Goal completed'**
  String get activityGoalCompleted;

  /// No description provided for @activityProgressLogged.
  ///
  /// In en, this message translates to:
  /// **'Progress logged'**
  String get activityProgressLogged;

  /// No description provided for @activityNote.
  ///
  /// In en, this message translates to:
  /// **'Note'**
  String get activityNote;

  /// No description provided for @activityStudySession.
  ///
  /// In en, this message translates to:
  /// **'Study session · {topic}'**
  String activityStudySession(String topic);

  /// No description provided for @activityWalkTitle.
  ///
  /// In en, this message translates to:
  /// **'Walk · {duration}'**
  String activityWalkTitle(String duration);

  /// No description provided for @activitySleepTitle.
  ///
  /// In en, this message translates to:
  /// **'Sleep · {duration}'**
  String activitySleepTitle(String duration);

  /// No description provided for @activitySteps.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 step} other{{steps} steps}}'**
  String activitySteps(int count, String steps);

  /// No description provided for @activitySleepWindow.
  ///
  /// In en, this message translates to:
  /// **'Bed {bed} · Wake {wake}'**
  String activitySleepWindow(String bed, String wake);

  /// No description provided for @activityOpenArea.
  ///
  /// In en, this message translates to:
  /// **'Open {area}'**
  String activityOpenArea(String area);

  /// No description provided for @unitNamePages.
  ///
  /// In en, this message translates to:
  /// **'pages'**
  String get unitNamePages;

  /// No description provided for @unitNameJuz.
  ///
  /// In en, this message translates to:
  /// **'juz'**
  String get unitNameJuz;

  /// No description provided for @unitNameHours.
  ///
  /// In en, this message translates to:
  /// **'hours'**
  String get unitNameHours;

  /// No description provided for @unitNameMinutes.
  ///
  /// In en, this message translates to:
  /// **'minutes'**
  String get unitNameMinutes;

  /// No description provided for @unitNameSessions.
  ///
  /// In en, this message translates to:
  /// **'sessions'**
  String get unitNameSessions;

  /// No description provided for @unitNameBooks.
  ///
  /// In en, this message translates to:
  /// **'books'**
  String get unitNameBooks;

  /// No description provided for @unitNameKm.
  ///
  /// In en, this message translates to:
  /// **'km'**
  String get unitNameKm;

  /// No description provided for @unitNameTimes.
  ///
  /// In en, this message translates to:
  /// **'times'**
  String get unitNameTimes;

  /// No description provided for @qtyPages.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{{value} page} other{{value} pages}}'**
  String qtyPages(num count, String value);

  /// No description provided for @qtyJuz.
  ///
  /// In en, this message translates to:
  /// **'{value} juz'**
  String qtyJuz(num count, String value);

  /// No description provided for @qtyHours.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{{value} hour} other{{value} hours}}'**
  String qtyHours(num count, String value);

  /// No description provided for @qtyMinutes.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{{value} minute} other{{value} minutes}}'**
  String qtyMinutes(num count, String value);

  /// No description provided for @qtySessions.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{{value} session} other{{value} sessions}}'**
  String qtySessions(num count, String value);

  /// No description provided for @qtyBooks.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{{value} book} other{{value} books}}'**
  String qtyBooks(num count, String value);

  /// No description provided for @qtyKm.
  ///
  /// In en, this message translates to:
  /// **'{value} km'**
  String qtyKm(num count, String value);

  /// No description provided for @qtyTimes.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{{value} time} other{{value} times}}'**
  String qtyTimes(num count, String value);

  /// No description provided for @currencyDzd.
  ///
  /// In en, this message translates to:
  /// **'Algerian Dinar'**
  String get currencyDzd;

  /// No description provided for @currencyMad.
  ///
  /// In en, this message translates to:
  /// **'Moroccan Dirham'**
  String get currencyMad;

  /// No description provided for @currencyTnd.
  ///
  /// In en, this message translates to:
  /// **'Tunisian Dinar'**
  String get currencyTnd;

  /// No description provided for @currencySar.
  ///
  /// In en, this message translates to:
  /// **'Saudi Riyal'**
  String get currencySar;

  /// No description provided for @currencyAed.
  ///
  /// In en, this message translates to:
  /// **'UAE Dirham'**
  String get currencyAed;

  /// No description provided for @currencyEgp.
  ///
  /// In en, this message translates to:
  /// **'Egyptian Pound'**
  String get currencyEgp;

  /// No description provided for @currencyEur.
  ///
  /// In en, this message translates to:
  /// **'Euro'**
  String get currencyEur;

  /// No description provided for @currencyUsd.
  ///
  /// In en, this message translates to:
  /// **'US Dollar'**
  String get currencyUsd;

  /// No description provided for @currencyGbp.
  ///
  /// In en, this message translates to:
  /// **'British Pound'**
  String get currencyGbp;

  /// No description provided for @settingsCurrencyOption.
  ///
  /// In en, this message translates to:
  /// **'{code} — {name}'**
  String settingsCurrencyOption(String code, String name);

  /// No description provided for @notifChannelName.
  ///
  /// In en, this message translates to:
  /// **'Reminders'**
  String get notifChannelName;

  /// No description provided for @notifChannelDescription.
  ///
  /// In en, this message translates to:
  /// **'Gentle local reminders you configure in Taqaddum'**
  String get notifChannelDescription;

  /// No description provided for @progressWeekAxis.
  ///
  /// In en, this message translates to:
  /// **'W{week}'**
  String progressWeekAxis(int week);

  /// No description provided for @progressChartLabel.
  ///
  /// In en, this message translates to:
  /// **'Progress over time, {period}'**
  String progressChartLabel(String period);

  /// No description provided for @commonOfTargetMinutes.
  ///
  /// In en, this message translates to:
  /// **'/ {target} min'**
  String commonOfTargetMinutes(int target);

  /// No description provided for @commonMinutesOfTarget.
  ///
  /// In en, this message translates to:
  /// **'{minutes} / {target} min'**
  String commonMinutesOfTarget(int minutes, int target);

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'Taqaddum'**
  String get appName;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en', 'fr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
    case 'fr':
      return AppLocalizationsFr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
