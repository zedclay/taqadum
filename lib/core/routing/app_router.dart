import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/data/session_controller.dart';
import '../../features/auth/domain/launch_decider.dart';
import '../../features/auth/presentation/auth_screen.dart';
import '../../features/finance/presentation/finance_screen.dart';
import '../../features/goals/presentation/goal_detail_screen.dart';
import '../../features/goals/presentation/goal_editor_screen.dart';
import '../../features/goals/presentation/goals_screen.dart';
import '../../features/health/presentation/health_screen.dart';
import '../../features/history/presentation/activity_screen.dart';
import '../../features/learning/presentation/learning_screen.dart';
import '../../features/notifications/presentation/notifications_screen.dart';
import '../../features/onboarding/presentation/onboarding_screen.dart';
import '../../features/profile/presentation/profile_screen.dart';
import '../../features/progress/presentation/progress_calendar_screen.dart';
import '../../features/progress/presentation/progress_screen.dart';
import '../../features/quran/presentation/quran_screen.dart';
import '../../features/reviews/presentation/monthly_review_screen.dart';
import '../../features/reviews/presentation/weekly_review_screen.dart';
import '../../features/settings/presentation/settings_screen.dart';
import '../../features/splash/presentation/splash_screen.dart';
import '../../features/today/presentation/daily_plan_screen.dart';
import '../../features/today/presentation/morning_checkin_screen.dart';
import '../../features/today/presentation/night_review_screen.dart';
import '../../features/today/presentation/today_screen.dart';
import '../../features/work/presentation/work_screen.dart';
import 'app_routes.dart';
import 'app_shell.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');

/// Decides where a navigation attempt should land given the session.
String? guardRoute(SessionState session, String location) {
  if (location == AppRoutes.splash) return null;
  final target = decideLaunch(session);
  switch (target) {
    case LaunchTarget.authCreate:
    case LaunchTarget.authSignIn:
      return location == AppRoutes.auth ? null : routeFor(target);
    case LaunchTarget.onboarding:
      return location == AppRoutes.onboarding ? null : AppRoutes.onboarding;
    case LaunchTarget.goalSetup:
      return location == AppRoutes.goalSetup ? null : AppRoutes.goalSetup;
    case LaunchTarget.today:
      const gated = {AppRoutes.auth, AppRoutes.onboarding, AppRoutes.goalSetup};
      return gated.contains(location) ? AppRoutes.today : null;
  }
}

class _SessionRefresh extends ChangeNotifier {
  void ping() => notifyListeners();
}

final routerProvider = Provider<GoRouter>((ref) {
  final refresh = _SessionRefresh();
  ref.listen(sessionProvider, (_, _) => refresh.ping());
  ref.onDispose(refresh.dispose);

  GoRoute focused(String path, Widget Function(GoRouterState) build) => GoRoute(
    path: path,
    parentNavigatorKey: rootNavigatorKey,
    builder: (context, state) => build(state),
  );

  final router = GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: AppRoutes.splash,
    refreshListenable: refresh,
    redirect: (context, state) =>
        guardRoute(ref.read(sessionProvider), state.matchedLocation),
    routes: [
      GoRoute(
        path: AppRoutes.splash,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: AppRoutes.auth,
        builder: (context, state) => AuthScreen(
          createMode: state.uri.queryParameters['mode'] == 'create',
        ),
      ),
      GoRoute(
        path: AppRoutes.onboarding,
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: AppRoutes.goalSetup,
        builder: (context, state) => const GoalEditorScreen(setupFlow: true),
      ),
      GoRoute(
        path: AppRoutes.notifications,
        builder: (context, state) => const NotificationsScreen(),
      ),
      GoRoute(
        path: AppRoutes.settings,
        builder: (context, state) => const SettingsScreen(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, shell) => AppShell(shell: shell),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.today,
                builder: (context, state) => const TodayScreen(),
                routes: [
                  GoRoute(
                    path: 'plan',
                    builder: (context, state) => DailyPlanScreen(
                      initialDayKey: state.uri.queryParameters['date'],
                    ),
                  ),
                  focused(
                    'morning-checkin',
                    (_) => const MorningCheckInScreen(),
                  ),
                  focused('night-review', (_) => const NightReviewScreen()),
                ],
              ),
              GoRoute(
                path: AppRoutes.quran,
                builder: (context, state) => const QuranScreen(),
              ),
              GoRoute(
                path: AppRoutes.work,
                builder: (context, state) => const WorkScreen(),
              ),
              GoRoute(
                path: AppRoutes.finance,
                builder: (context, state) => const FinanceScreen(),
              ),
              GoRoute(
                path: AppRoutes.health,
                builder: (context, state) => const HealthScreen(),
              ),
              GoRoute(
                path: AppRoutes.learning,
                builder: (context, state) => const LearningScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.progress,
                builder: (context, state) => const ProgressScreen(),
                routes: [
                  GoRoute(
                    path: 'calendar',
                    builder: (context, state) => const ProgressCalendarScreen(),
                  ),
                  focused('weekly-review', (_) => const WeeklyReviewScreen()),
                  focused('monthly-review', (_) => const MonthlyReviewScreen()),
                ],
              ),
              GoRoute(
                path: AppRoutes.activity,
                builder: (context, state) => ActivityScreen(
                  initialDayKey: state.uri.queryParameters['date'],
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.goals,
                builder: (context, state) => const GoalsScreen(),
                routes: [
                  focused('new', (_) => const GoalEditorScreen()),
                  GoRoute(
                    path: ':goalId',
                    builder: (context, state) => GoalDetailScreen(
                      goalId: state.pathParameters['goalId']!,
                    ),
                    routes: [
                      focused(
                        'edit',
                        (s) => GoalEditorScreen(
                          goalId: s.pathParameters['goalId'],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.profile,
                builder: (context, state) => const ProfileScreen(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
  ref.onDispose(router.dispose);
  return router;
});
