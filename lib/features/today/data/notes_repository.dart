import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/app_database.dart';
import '../../../core/providers.dart';
import '../../../core/utilities/ids.dart';
import '../../history/data/activity_repository.dart';

class NotesRepository {
  NotesRepository(this._db, this._activity);

  final AppDatabase _db;
  final ActivityRepository _activity;

  Future<void> add(String body, {LifeArea? area}) => _db.transaction(() async {
    final id = newId();
    final text = body.trim();
    await _db
        .into(_db.notes)
        .insert(
          NotesCompanion.insert(
            id: id,
            body: text,
            area: Value(area),
            createdAt: DateTime.now().toUtc(),
          ),
        );
    final firstLine = text.split('\n').first;
    await _activity.record(
      area: area ?? LifeArea.personal,
      type: ActivityType.logged,
      title: firstLine.length > 60
          ? '${firstLine.substring(0, 60)}…'
          : firstLine,
      subtitle: 'Note',
      entityType: 'note',
      entityId: id,
    );
  });
}

final notesRepositoryProvider = Provider<NotesRepository>(
  (ref) => NotesRepository(
    ref.watch(databaseProvider),
    ref.watch(activityRepositoryProvider),
  ),
);
