// Flags user-visible string literals in lib/ that bypass localization.
//
// Usage: dart run tool/l10n_audit.dart [--strict]
//
// Two checks run on every Dart file outside generated code:
//
// * a literal containing a letter in a UI position (Text(), label:, title:,
//   hint:, message:, tooltip:, semanticLabel:, …);
// * an interpolated literal that glues English words to values
//   ('$n steps', 'Walk · $time'), which can't be translated or pluralized.
//
// The script only reports; it never edits files. Developer logs
// (debugPrint), route paths, database ids and test fixtures are out of scope.
// Lines may opt out with a trailing `// l10n-ignore` comment and whole files
// with `// l10n-ignore-file` (frozen legacy values, demo-only sample content).
// With --strict the script exits with code 1 when anything is found.
import 'dart:io';

final _uiPosition = RegExp(
  r'''(?:Text\(\s*|(?:label|title|subtitle|hint|hintText|labelText|helperText|message|tooltip|semanticLabel|semanticsLabel|actionLabel|confirmLabel|cancelLabel|body|placeholder|trailingText|errorText|description)\s*:\s*)(['"])((?:(?!\1).)*[A-Za-z](?:(?!\1).)*)\1''',
);

final _literal = RegExp(r"""'((?:[^'\\]|\\.)*)'""");
final _interpolation = RegExp(r'\$\{[^}]*\}|\$[A-Za-z_]\w*');
final _word = RegExp(r'(?:^|\s)[A-Za-z]{2,}(?:\s|$)');

const _skipDirs = ['lib/l10n/generated'];
const _skipLinePrefixes = ['import ', 'export ', 'part ', 'debugPrint('];

void main(List<String> args) {
  final strict = args.contains('--strict');
  final findings = <String>[];
  final files = Directory('lib')
      .listSync(recursive: true)
      .whereType<File>()
      .where((f) => f.path.endsWith('.dart'))
      .where((f) => !f.path.endsWith('.g.dart'))
      .where((f) => !_skipDirs.any(f.path.startsWith));
  for (final file in files) {
    final lines = file.readAsLinesSync();
    if (lines.take(5).any((l) => l.contains('l10n-ignore-file'))) continue;
    for (final (i, line) in lines.indexed) {
      if (line.contains('l10n-ignore')) continue;
      final trimmed = line.trimLeft();
      if (trimmed.startsWith('//')) continue;
      if (_skipLinePrefixes.any(trimmed.startsWith)) continue;
      final where = '${file.path}:${i + 1}';
      final seen = <String>{};
      for (final m in _uiPosition.allMatches(line)) {
        final value = m.group(2)!;
        if (value.startsWith(r'$') && !value.contains(' ')) continue;
        if (seen.add(value)) findings.add('$where: "$value"');
      }
      for (final m in _literal.allMatches(line)) {
        final value = m.group(1)!;
        if (!value.contains(r'$')) continue;
        final bare = value.replaceAll(_interpolation, ' ');
        if (_word.hasMatch(bare) && seen.add(value)) {
          findings.add('$where: "$value" (interpolated English)');
        }
      }
    }
  }
  for (final f in findings) {
    stdout.writeln(f);
  }
  stdout.writeln('${findings.length} suspicious literal(s).');
  if (strict && findings.isNotEmpty) exit(1);
}
