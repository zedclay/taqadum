import 'dart:convert';
import 'dart:io';

import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../../core/database/app_database.dart';
import '../../../core/domain/period.dart';
import '../../../core/providers.dart';

enum ExportFormat { json, csv }

class ExportService {
  ExportService(this._db, this._now);

  final AppDatabase _db;
  final Clock _now;

  static const formatVersion = 1;

  Future<Map<String, Object?>> buildJson() async {
    final tables = <String, Object?>{};
    for (final table in _db.allTables) {
      final rows = await _db.select(table as TableInfo<Table, DataClass>).get();
      tables[table.actualTableName] = [for (final r in rows) r.toJson()];
    }
    return {
      'app': 'Taqaddum',
      'formatVersion': formatVersion,
      'schemaVersion': _db.schemaVersion,
      'exportedAt': _now().toUtc().toIso8601String(),
      'tables': tables,
    };
  }

  static String csv(List<List<Object?>> rows) {
    String cell(Object? v) {
      final s = v?.toString() ?? '';
      final needsQuotes =
          s.contains(',') || s.contains('"') || s.contains('\n');
      return needsQuotes ? '"${s.replaceAll('"', '""')}"' : s;
    }

    return rows.map((r) => r.map(cell).join(',')).join('\n');
  }

  Future<String> transactionsCsv(String currency) async {
    final rows = await (_db.select(
      _db.financeTransactions,
    )..orderBy([(t) => OrderingTerm.asc(t.occurredAt)])).get();
    return csv([
      ['date', 'type', 'amount', 'currency', 'category', 'tag', 'note'],
      for (final t in rows)
        [
          dayKeyOf(t.occurredAt),
          t.type.name,
          (t.amountMinor / 100).toStringAsFixed(2),
          currency,
          t.category,
          t.tag.name,
          t.note,
        ],
    ]);
  }

  Future<String> activityCsv() async {
    final rows = await (_db.select(
      _db.activityEvents,
    )..orderBy([(t) => OrderingTerm.asc(t.occurredAt)])).get();
    return csv([
      ['occurred_at', 'area', 'type', 'title', 'detail'],
      for (final e in rows)
        [
          e.occurredAt.toLocal().toIso8601String(),
          e.area?.name,
          e.type.name,
          e.title,
          e.subtitle,
        ],
    ]);
  }

  Future<List<File>> writeFiles(
    ExportFormat format, {
    String currency = 'DZD',
  }) async {
    final dir = await getTemporaryDirectory();
    final stamp = dayKeyOf(_now());
    Future<File> write(String name, String content) =>
        File(p.join(dir.path, name)).writeAsString(content, flush: true);
    return switch (format) {
      ExportFormat.json => [
        await write(
          'taqaddum-export-$stamp.json',
          const JsonEncoder.withIndent('  ').convert(await buildJson()),
        ),
      ],
      ExportFormat.csv => [
        await write(
          'taqaddum-transactions-$stamp.csv',
          await transactionsCsv(currency),
        ),
        await write('taqaddum-activity-$stamp.csv', await activityCsv()),
      ],
    };
  }

  Future<void> share(ExportFormat format, {String currency = 'DZD'}) async {
    final files = await writeFiles(format, currency: currency);
    await SharePlus.instance.share(
      ShareParams(
        files: [for (final f in files) XFile(f.path)],
        subject: 'Taqaddum export',
      ),
    );
  }
}

final exportServiceProvider = Provider<ExportService>(
  (ref) => ExportService(ref.watch(databaseProvider), ref.watch(clockProvider)),
);
