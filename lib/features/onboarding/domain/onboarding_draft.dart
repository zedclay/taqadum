import '../../../core/database/app_database.dart';
import '../../../l10n/generated/app_localizations.dart';

class StarterTarget {
  const StarterTarget(this.id, this.area, this.label, {this.custom = false});

  final String id;
  final LifeArea area;
  final String label;
  final bool custom;
}

List<StarterTarget> starterTargetsFor(AppLocalizations l) => [
  StarterTarget('quran1', LifeArea.quran, l.onbTargetQuran1),
  StarterTarget('quran2', LifeArea.quran, l.onbTargetQuran2),
  StarterTarget('quran3', LifeArea.quran, l.onbTargetQuran3),
  StarterTarget('work1', LifeArea.work, l.onbTargetWork1),
  StarterTarget('work2', LifeArea.work, l.onbTargetWork2),
  StarterTarget('finance1', LifeArea.finance, l.onbTargetFinance1),
  StarterTarget('finance2', LifeArea.finance, l.onbTargetFinance2),
  StarterTarget('health1', LifeArea.health, l.onbTargetHealth1),
  StarterTarget('health2', LifeArea.health, l.onbTargetHealth2),
  StarterTarget('learning1', LifeArea.learning, l.onbTargetLearning1),
  StarterTarget('learning2', LifeArea.learning, l.onbTargetLearning2),
  StarterTarget('personal1', LifeArea.personal, l.onbTargetPersonal1),
  StarterTarget('personal2', LifeArea.personal, l.onbTargetPersonal2),
];

/// Everything collected across the four onboarding steps.
class OnboardingDraft {
  const OnboardingDraft({
    this.areas = const {LifeArea.quran, LifeArea.work, LifeArea.health},
    this.targetIds = const {'quran1', 'work1', 'health1'},
    this.customTargets = const [],
    this.pace = DayPace.balanced,
    this.morningOn = true,
    this.morningMinute = 7 * 60 + 30,
    this.eveningOn = true,
    this.eveningMinute = 21 * 60 + 30,
  });

  final Set<LifeArea> areas;
  final Set<String> targetIds;
  final List<StarterTarget> customTargets;
  final DayPace pace;
  final bool morningOn;
  final int morningMinute;
  final bool eveningOn;
  final int eveningMinute;

  List<LifeArea> get orderedAreas =>
      LifeArea.values.where(areas.contains).toList();

  /// Selected targets that belong to a selected area, in display order.
  List<StarterTarget> selectedTargets(List<StarterTarget> starters) => [
    ...starters,
    ...customTargets,
  ].where((t) => areas.contains(t.area) && targetIds.contains(t.id)).toList();

  OnboardingDraft copyWith({
    Set<LifeArea>? areas,
    Set<String>? targetIds,
    List<StarterTarget>? customTargets,
    DayPace? pace,
    bool? morningOn,
    int? morningMinute,
    bool? eveningOn,
    int? eveningMinute,
  }) => OnboardingDraft(
    areas: areas ?? this.areas,
    targetIds: targetIds ?? this.targetIds,
    customTargets: customTargets ?? this.customTargets,
    pace: pace ?? this.pace,
    morningOn: morningOn ?? this.morningOn,
    morningMinute: morningMinute ?? this.morningMinute,
    eveningOn: eveningOn ?? this.eveningOn,
    eveningMinute: eveningMinute ?? this.eveningMinute,
  );
}
