import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/localization/l10n.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_bottom_sheet.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../../../core/widgets/area_style.dart';
import '../../../../core/widgets/buttons.dart';
import '../../../../core/widgets/chips.dart';
import '../../data/notes_repository.dart';

class NoteForm extends ConsumerStatefulWidget {
  const NoteForm({super.key, this.onBack, this.onSaved});

  final VoidCallback? onBack;
  final VoidCallback? onSaved;

  @override
  ConsumerState<NoteForm> createState() => _NoteFormState();
}

class _NoteFormState extends ConsumerState<NoteForm> {
  final _body = TextEditingController();
  LifeArea _area = LifeArea.personal;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    _body.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _body.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    setState(() => _saving = true);
    await ref.read(notesRepositoryProvider).add(_body.text, area: _area);
    if (!mounted) return;
    widget.onSaved?.call();
    if (widget.onSaved == null) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    return AppBottomSheet(
      title: l.noteTitle,
      leading: widget.onBack == null
          ? null
          : SheetBackButton(onPressed: widget.onBack!),
      showClose: widget.onBack == null,
      action: PrimaryButton(
        key: const Key('note-save'),
        label: l.noteSave,
        icon: Symbols.check,
        loading: _saving,
        onPressed: _body.text.trim().isEmpty || _saving ? null : _save,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AppTextField(
            fieldKey: const Key('note-body'),
            hint: l.noteHint,
            controller: _body,
            autofocus: true,
            minLines: 4,
            maxLines: 8,
            keyboardType: TextInputType.multiline,
            textCapitalization: TextCapitalization.sentences,
          ),
          AppSpacing.gap20,
          FieldLabel(label: l.noteArea),
          AppSpacing.gap8,
          Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            children: [
              for (final area in LifeArea.values)
                ChoiceTag(
                  label: area.label(context),
                  selected: _area == area,
                  color: area.color,
                  soft: area.soft,
                  onTap: () => setState(() => _area = area),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
