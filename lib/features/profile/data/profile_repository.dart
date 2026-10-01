import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/app_database.dart';
import '../../../core/providers.dart';

class ProfileRepository {
  ProfileRepository(this._db);

  final AppDatabase _db;

  Stream<UserProfile?> watch() =>
      (_db.select(_db.userProfiles)..limit(1)).watchSingleOrNull();

  Future<UserProfile?> get() =>
      (_db.select(_db.userProfiles)..limit(1)).getSingleOrNull();

  Future<void> create({
    required String id,
    required String name,
    String? email,
  }) => _db
      .into(_db.userProfiles)
      .insert(
        UserProfilesCompanion.insert(
          id: id,
          name: name,
          email: Value(email),
          avatarColor: Value(name.hashCode.abs() % 6),
          createdAt: DateTime.now().toUtc(),
        ),
      );

  Future<void> update({
    required String id,
    String? name,
    String? Function()? role,
    String? Function()? email,
    String? Function()? intention,
  }) => (_db.update(_db.userProfiles)..where((t) => t.id.equals(id))).write(
    UserProfilesCompanion(
      name: name == null ? const Value.absent() : Value(name),
      role: role == null ? const Value.absent() : Value(role()),
      email: email == null ? const Value.absent() : Value(email()),
      intention: intention == null ? const Value.absent() : Value(intention()),
    ),
  );
}

final profileRepositoryProvider = Provider<ProfileRepository>(
  (ref) => ProfileRepository(ref.watch(databaseProvider)),
);

final profileProvider = StreamProvider<UserProfile?>(
  (ref) => ref.watch(profileRepositoryProvider).watch(),
);

String initialsOf(String name) {
  final parts = name.trim().split(RegExp(r'\s+')).where((p) => p.isNotEmpty);
  if (parts.isEmpty) return '?';
  final letters = parts.take(2).map((p) => p.characters.first.toUpperCase());
  return letters.join();
}

extension on String {
  Iterable<String> get characters => runes.map(String.fromCharCode);
}
