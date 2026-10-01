import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../../core/database/app_database.dart';
import '../../../core/localization/l10n.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/utilities/formatters.dart';
import '../../../core/utilities/number_input.dart';
import '../../../core/widgets/app_bottom_sheet.dart';
import '../../../core/widgets/app_text_field.dart';
import '../../../core/widgets/buttons.dart';
import '../../../core/widgets/input_sheets.dart';
import '../../../core/widgets/segmented.dart';
import '../../goals/data/goals_repository.dart';
import '../../goals/presentation/widgets/goal_link_field.dart';
import '../../settings/data/settings_store.dart';
import '../../today/data/notes_repository.dart';
import '../data/learning_repository.dart';

String resourceKindLabel(BuildContext context, ResourceKind kind) {
  final l = context.l10n;
  return switch (kind) {
    ResourceKind.course => l.kindCourse,
    ResourceKind.book => l.kindBook,
    ResourceKind.video => l.kindVideo,
    ResourceKind.article => l.kindArticle,
  };
}

String resourceUnit(BuildContext context, ResourceKind kind) {
  final l = context.l10n;
  return switch (kind) {
    ResourceKind.course => l.unitLessons,
    ResourceKind.book => l.unitPages,
    ResourceKind.video => l.unitVideos,
    ResourceKind.article => l.unitArticles,
  };
}

IconData resourceIcon(ResourceKind kind) => switch (kind) {
  ResourceKind.course => Symbols.play_circle,
  ResourceKind.book => Symbols.auto_stories,
  ResourceKind.video => Symbols.smart_display,
  ResourceKind.article => Symbols.article,
};

Future<void> showStudySheet(BuildContext context, {String? topic}) =>
    showAppSheet<void>(context, builder: (_) => _StudyForm(topic: topic));

Future<void> showTakeawaySheet(BuildContext context, WidgetRef ref) async {
  final l = context.l10n;
  final text = await showTextSheet(
    context,
    title: l.takeawayTitle,
    hint: l.takeawayHint,
    actionLabel: l.commonSave,
  );
  if (text == null) return;
  await ref.read(notesRepositoryProvider).add(text, area: LifeArea.learning);
}

Future<void> showFocusSheet(BuildContext context) =>
    showAppSheet<void>(context, builder: (_) => const _FocusForm());

Future<void> showResourceSheet(BuildContext context) =>
    showAppSheet<void>(context, builder: (_) => const _ResourceForm());

class _StudyForm extends ConsumerStatefulWidget {
  const _StudyForm({this.topic});

  final String? topic;

  @override
  ConsumerState<_StudyForm> createState() => _StudyFormState();
}

class _StudyFormState extends ConsumerState<_StudyForm> {
  late final _topic = TextEditingController(text: widget.topic);
  late final _skill = TextEditingController(
    text: ref.read(learningFocusProvider)?.skill,
  );
  final _takeaway = TextEditingController();
  final _action = TextEditingController();
  int _minutes = 30;
  LearningResource? _resource;
  int _units = 0;
  String? _goalChoice;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    _topic.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _topic.dispose();
    _skill.dispose();
    _takeaway.dispose();
    _action.dispose();
    super.dispose();
  }

  Future<void> _pickResource(List<LearningResource> resources) async {
    final l = context.l10n;
    final picked = await showOptionSheet<String>(
      context,
      title: l.studyResource,
      selected: _resource?.id ?? '',
      options: [
        SheetOption(value: '', label: l.studyNoResource),
        for (final r in resources)
          SheetOption(
            value: r.id,
            label: r.title,
            subtitle: l.learnUnitsOf(
              r.completedUnits,
              r.totalUnits,
              resourceUnit(context, r.kind),
            ),
          ),
      ],
    );
    if (picked == null) return;
    setState(() {
      _resource = resources.where((r) => r.id == picked).firstOrNull;
      _units = 0;
    });
  }

  Future<void> _save() async {
    setState(() => _saving = true);
    final goals = (ref.read(goalsProvider).value ?? const <Goal>[])
        .where((g) => g.status == GoalStatus.active)
        .toList();
    final skill = _skill.text.trim();
    await ref
        .read(learningRepositoryProvider)
        .logSession(
          topic: _topic.text,
          minutes: _minutes,
          skill: skill.isEmpty ? null : skill,
          resource: _resource,
          resourceUnits: _units,
          takeaway: _takeaway.text,
          appliedAction: _action.text,
          goal: resolveLinkedGoal(goals, LifeArea.learning, _goalChoice),
        );
    if (mounted) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final resources =
        ref.watch(learningResourcesProvider).value ??
        const <LearningResource>[];
    final r = _resource;
    return AppBottomSheet(
      title: l.studyTitle,
      action: PrimaryButton(
        key: const Key('study-save'),
        label: l.commonSave,
        icon: Symbols.check,
        color: AppColors.learning,
        loading: _saving,
        onPressed: _topic.text.trim().isEmpty || _saving ? null : _save,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AppTextField(
            fieldKey: const Key('study-topic'),
            label: l.studyTopic,
            hint: l.studyTopicHint,
            controller: _topic,
            autofocus: widget.topic == null,
            textCapitalization: TextCapitalization.sentences,
          ),
          AppSpacing.gap16,
          AppTextField(
            label: l.studySkill,
            trailingLabel: l.commonOptional,
            hint: l.studySkillHint,
            controller: _skill,
            textCapitalization: TextCapitalization.words,
          ),
          AppSpacing.gap16,
          FieldLabel(label: l.studyMinutes),
          AppSpacing.gap8,
          NumberStepper(
            value: _minutes.toDouble(),
            step: 5,
            min: 5,
            max: 480,
            format: (v) => Fmt.minutes(v.round()),
            onChanged: (v) => setState(() => _minutes = v.round()),
          ),
          if (resources.isNotEmpty) ...[
            AppSpacing.gap16,
            FieldLabel(label: l.studyResource, trailing: l.commonOptional),
            AppSpacing.gap8,
            OutlinedButton.icon(
              onPressed: () => _pickResource(resources),
              icon: Icon(
                r == null ? Symbols.library_books : resourceIcon(r.kind),
                size: 18,
              ),
              label: Text(r?.title ?? l.studyNoResource),
            ),
            if (r != null) ...[
              AppSpacing.gap12,
              FieldLabel(label: l.studyUnits),
              AppSpacing.gap8,
              NumberStepper(
                value: _units.toDouble(),
                min: 0,
                max: (r.totalUnits - r.completedUnits).toDouble(),
                format: (v) => '+${v.round()} ${resourceUnit(context, r.kind)}',
                onChanged: (v) => setState(() => _units = v.round()),
              ),
            ],
          ],
          AppSpacing.gap16,
          AppTextField(
            label: l.studyTakeaway,
            trailingLabel: l.commonOptional,
            hint: l.studyTakeawayHint,
            controller: _takeaway,
            maxLines: 3,
            minLines: 1,
            textCapitalization: TextCapitalization.sentences,
          ),
          AppSpacing.gap16,
          AppTextField(
            label: l.studyAction,
            trailingLabel: l.commonOptional,
            hint: l.studyActionHint,
            controller: _action,
            textCapitalization: TextCapitalization.sentences,
          ),
          AppSpacing.gap20,
          GoalLinkField(
            area: LifeArea.learning,
            choice: _goalChoice,
            onChanged: (c) => setState(() => _goalChoice = c),
          ),
        ],
      ),
    );
  }
}

class _FocusForm extends ConsumerStatefulWidget {
  const _FocusForm();

  @override
  ConsumerState<_FocusForm> createState() => _FocusFormState();
}

class _FocusFormState extends ConsumerState<_FocusForm> {
  late final LearningFocus? _initial = ref.read(learningFocusProvider);
  late final _skill = TextEditingController(text: _initial?.skill);
  late final _description = TextEditingController(text: _initial?.description);
  late final _next = TextEditingController(text: _initial?.nextStep);
  late int _weeks = _initial?.weeks ?? 4;

  @override
  void initState() {
    super.initState();
    _skill.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _skill.dispose();
    _description.dispose();
    _next.dispose();
    super.dispose();
  }

  String? _clean(TextEditingController c) =>
      c.text.trim().isEmpty ? null : c.text.trim();

  Future<void> _save() async {
    final skill = _skill.text.trim();
    // Keep the start date when only details change.
    final startedOn = _initial != null && _initial.skill == skill
        ? _initial.startedOn
        : DateTime.now();
    await ref
        .read(settingsStoreProvider)
        .setLearningFocus(
          LearningFocus(
            skill: skill,
            description: _clean(_description),
            startedOn: startedOn,
            weeks: _weeks,
            nextStep: _clean(_next),
          ),
        );
    if (mounted) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    return AppBottomSheet(
      title: l.focusTitle,
      action: PrimaryButton(
        key: const Key('focus-save'),
        label: l.commonSave,
        color: AppColors.learning,
        onPressed: _skill.text.trim().isEmpty ? null : _save,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AppTextField(
            fieldKey: const Key('focus-skill'),
            label: l.focusSkill,
            hint: l.studySkillHint,
            controller: _skill,
            autofocus: _initial == null,
            textCapitalization: TextCapitalization.words,
          ),
          AppSpacing.gap16,
          AppTextField(
            label: l.focusDescription,
            trailingLabel: l.commonOptional,
            hint: l.focusDescriptionHint,
            controller: _description,
            maxLines: 3,
            minLines: 1,
            textCapitalization: TextCapitalization.sentences,
          ),
          AppSpacing.gap16,
          FieldLabel(label: l.focusWeeks),
          AppSpacing.gap8,
          NumberStepper(
            value: _weeks.toDouble(),
            min: 1,
            max: 26,
            onChanged: (v) => setState(() => _weeks = v.round()),
          ),
          AppSpacing.gap16,
          AppTextField(
            label: l.focusNextStep,
            trailingLabel: l.commonOptional,
            hint: l.focusNextStepHint,
            controller: _next,
            textCapitalization: TextCapitalization.sentences,
          ),
        ],
      ),
    );
  }
}

class _ResourceForm extends ConsumerStatefulWidget {
  const _ResourceForm();

  @override
  ConsumerState<_ResourceForm> createState() => _ResourceFormState();
}

class _ResourceFormState extends ConsumerState<_ResourceForm> {
  final _title = TextEditingController();
  final _total = TextEditingController();
  final _done = TextEditingController();
  ResourceKind _kind = ResourceKind.course;

  @override
  void initState() {
    super.initState();
    _title.addListener(() => setState(() {}));
    _total.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _title.dispose();
    _total.dispose();
    _done.dispose();
    super.dispose();
  }

  int? get _totalUnits {
    final v = parseNumber(_total.text)?.round();
    return v == null || v <= 0 ? null : v;
  }

  Future<void> _save() async {
    final total = _totalUnits!;
    final done = (parseNumber(_done.text)?.round() ?? 0).clamp(0, total);
    await ref
        .read(learningRepositoryProvider)
        .addResource(
          title: _title.text,
          kind: _kind,
          totalUnits: total,
          completedUnits: done,
          skill: ref.read(learningFocusProvider)?.skill,
        );
    if (mounted) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final unit = resourceUnit(context, _kind);
    return AppBottomSheet(
      title: l.resourceTitle,
      action: PrimaryButton(
        key: const Key('resource-save'),
        label: l.commonSave,
        color: AppColors.learning,
        onPressed: _title.text.trim().isEmpty || _totalUnits == null
            ? null
            : _save,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AppTextField(
            label: l.resourceName,
            hint: l.resourceNameHint,
            controller: _title,
            autofocus: true,
            textCapitalization: TextCapitalization.words,
          ),
          AppSpacing.gap16,
          FieldLabel(label: l.resourceKind),
          AppSpacing.gap8,
          SegmentedPills<ResourceKind>(
            values: ResourceKind.values,
            selected: _kind,
            compact: true,
            labelOf: (k) => resourceKindLabel(context, k),
            onChanged: (k) => setState(() => _kind = k),
          ),
          AppSpacing.gap16,
          Row(
            children: [
              Expanded(
                child: AppTextField(
                  label: l.resourceTotal(unit),
                  hint: '12',
                  controller: _total,
                  keyboardType: TextInputType.number,
                  inputFormatters: numberInputFormatters,
                ),
              ),
              AppSpacing.gap12,
              Expanded(
                child: AppTextField(
                  label: l.resourceDone,
                  hint: '0',
                  controller: _done,
                  keyboardType: TextInputType.number,
                  inputFormatters: numberInputFormatters,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
