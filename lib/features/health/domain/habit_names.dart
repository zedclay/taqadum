import '../../../core/database/app_database.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../../onboarding/domain/onboarding_draft.dart';

/// Starter habits follow the app language; habits the user named keep their
/// own text.
String habitDisplayName(AppLocalizations l, Habit habit) {
  final template = habit.templateId;
  if (template == null) return habit.name;
  return starterTargetLabel(l, template) ?? habit.name;
}
