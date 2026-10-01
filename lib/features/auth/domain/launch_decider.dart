enum LaunchTarget { authCreate, authSignIn, onboarding, goalSetup, today }

class SessionState {
  const SessionState({
    this.hasAccount = false,
    this.hasPassword = false,
    this.userId,
    this.email,
    this.onboardingDone = false,
    this.goalSetupDone = false,
  });

  final bool hasAccount;
  final bool hasPassword;
  final String? userId;
  final String? email;
  final bool onboardingDone;
  final bool goalSetupDone;

  bool get signedIn => userId != null;

  SessionState copyWith({
    bool? hasAccount,
    bool? hasPassword,
    String? Function()? userId,
    String? Function()? email,
    bool? onboardingDone,
    bool? goalSetupDone,
  }) => SessionState(
    hasAccount: hasAccount ?? this.hasAccount,
    hasPassword: hasPassword ?? this.hasPassword,
    userId: userId != null ? userId() : this.userId,
    email: email != null ? email() : this.email,
    onboardingDone: onboardingDone ?? this.onboardingDone,
    goalSetupDone: goalSetupDone ?? this.goalSetupDone,
  );
}

LaunchTarget decideLaunch(SessionState s) {
  if (!s.hasAccount) return LaunchTarget.authCreate;
  if (!s.signedIn) return LaunchTarget.authSignIn;
  if (!s.onboardingDone) return LaunchTarget.onboarding;
  if (!s.goalSetupDone) return LaunchTarget.goalSetup;
  return LaunchTarget.today;
}

String routeFor(LaunchTarget target) => switch (target) {
  LaunchTarget.authCreate => '/auth?mode=create',
  LaunchTarget.authSignIn => '/auth',
  LaunchTarget.onboarding => '/onboarding',
  LaunchTarget.goalSetup => '/goal-setup',
  LaunchTarget.today => '/today',
};
