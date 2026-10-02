/// Folds text for forgiving local search: English is case-insensitive and
/// Arabic ignores diacritics, tatweel and common letter variants
/// (أ/إ/آ → ا, ى → ي, ة → ه, ؤ → و, ئ → ي). Bidi isolate marks are dropped.
String foldForSearch(String text) {
  final out = StringBuffer();
  for (final rune in text.toLowerCase().runes) {
    if ((rune >= 0x064B && rune <= 0x065F) || rune == 0x0670) continue;
    if (rune == 0x0640 || (rune >= 0x2066 && rune <= 0x2069)) continue;
    out.writeCharCode(switch (rune) {
      0x0623 || 0x0625 || 0x0622 || 0x0671 => 0x0627,
      0x0649 => 0x064A,
      0x0629 => 0x0647,
      0x0624 => 0x0648,
      0x0626 => 0x064A,
      _ => rune,
    });
  }
  return out.toString().trim();
}

/// True when every word of [query] appears in one of [fields].
bool matchesSearch(Iterable<String?> fields, String query) {
  final words = foldForSearch(query).split(RegExp(r'\s+'))
    ..removeWhere((w) => w.isEmpty);
  if (words.isEmpty) return true;
  final haystack = fields.nonNulls.map(foldForSearch).join(' ');
  return words.every(haystack.contains);
}
