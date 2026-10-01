abstract final class AppRoutes {
  static const splash = '/splash';
  static const auth = '/auth';
  static const onboarding = '/onboarding';
  static const goalSetup = '/goal-setup';
  static const today = '/today';
  static const morningCheckIn = '/today/morning-checkin';
  static const plan = '/today/plan';
  static const nightReview = '/today/night-review';
  static const quran = '/quran';
  static const work = '/work';
  static const finance = '/finance';
  static const health = '/health';
  static const learning = '/learning';
  static const goals = '/goals';
  static const newGoal = '/goals/new';
  static const progress = '/progress';
  static const calendar = '/progress/calendar';
  static const weeklyReview = '/progress/weekly-review';
  static const monthlyReview = '/progress/monthly-review';
  static const activity = '/activity';
  static const notifications = '/notifications';
  static const profile = '/profile';
  static const settings = '/settings';

  static String goal(String id) => '/goals/$id';
  static String editGoal(String id) => '/goals/$id/edit';
  static String activityOn(String dayKey) => '/activity?date=$dayKey';
  static String planOn(String dayKey) => '/today/plan?date=$dayKey';
}
