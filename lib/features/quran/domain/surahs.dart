/// The 114 surahs with transliterated names and page counts in the standard
/// 604-page Madani mushaf.
const surahNames = [
  'Al-Fatihah', 'Al-Baqarah', 'Ali Imran', 'An-Nisa', 'Al-Maidah', //
  'Al-Anam', 'Al-Araf', 'Al-Anfal', 'At-Tawbah', 'Yunus',
  'Hud', 'Yusuf', 'Ar-Rad', 'Ibrahim', 'Al-Hijr',
  'An-Nahl', 'Al-Isra', 'Al-Kahf', 'Maryam', 'Ta-Ha',
  'Al-Anbiya', 'Al-Hajj', 'Al-Muminun', 'An-Nur', 'Al-Furqan',
  'Ash-Shuara', 'An-Naml', 'Al-Qasas', 'Al-Ankabut', 'Ar-Rum',
  'Luqman', 'As-Sajdah', 'Al-Ahzab', 'Saba', 'Fatir',
  'Ya-Sin', 'As-Saffat', 'Sad', 'Az-Zumar', 'Ghafir',
  'Fussilat', 'Ash-Shura', 'Az-Zukhruf', 'Ad-Dukhan', 'Al-Jathiyah',
  'Al-Ahqaf', 'Muhammad', 'Al-Fath', 'Al-Hujurat', 'Qaf',
  'Adh-Dhariyat', 'At-Tur', 'An-Najm', 'Al-Qamar', 'Ar-Rahman',
  'Al-Waqiah', 'Al-Hadid', 'Al-Mujadilah', 'Al-Hashr', 'Al-Mumtahanah',
  'As-Saff', 'Al-Jumuah', 'Al-Munafiqun', 'At-Taghabun', 'At-Talaq',
  'At-Tahrim', 'Al-Mulk', 'Al-Qalam', 'Al-Haqqah', 'Al-Maarij',
  'Nuh', 'Al-Jinn', 'Al-Muzzammil', 'Al-Muddaththir', 'Al-Qiyamah',
  'Al-Insan', 'Al-Mursalat', 'An-Naba', 'An-Naziat', 'Abasa',
  'At-Takwir', 'Al-Infitar', 'Al-Mutaffifin', 'Al-Inshiqaq', 'Al-Buruj',
  'At-Tariq', 'Al-Ala', 'Al-Ghashiyah', 'Al-Fajr', 'Al-Balad',
  'Ash-Shams', 'Al-Layl', 'Ad-Duha', 'Ash-Sharh', 'At-Tin',
  'Al-Alaq', 'Al-Qadr', 'Al-Bayyinah', 'Az-Zalzalah', 'Al-Adiyat',
  'Al-Qariah', 'At-Takathur', 'Al-Asr', 'Al-Humazah', 'Al-Fil',
  'Quraysh', 'Al-Maun', 'Al-Kawthar', 'Al-Kafirun', 'An-Nasr',
  'Al-Masad', 'Al-Ikhlas', 'Al-Falaq', 'An-Nas',
];

/// Arabic surah names, indexed like [surahNames].
const surahNamesAr = [
  'الفاتحة', 'البقرة', 'آل عمران', 'النساء', 'المائدة', //
  'الأنعام', 'الأعراف', 'الأنفال', 'التوبة', 'يونس',
  'هود', 'يوسف', 'الرعد', 'إبراهيم', 'الحجر',
  'النحل', 'الإسراء', 'الكهف', 'مريم', 'طه',
  'الأنبياء', 'الحج', 'المؤمنون', 'النور', 'الفرقان',
  'الشعراء', 'النمل', 'القصص', 'العنكبوت', 'الروم',
  'لقمان', 'السجدة', 'الأحزاب', 'سبأ', 'فاطر',
  'يس', 'الصافات', 'ص', 'الزمر', 'غافر',
  'فصلت', 'الشورى', 'الزخرف', 'الدخان', 'الجاثية',
  'الأحقاف', 'محمد', 'الفتح', 'الحجرات', 'ق',
  'الذاريات', 'الطور', 'النجم', 'القمر', 'الرحمن',
  'الواقعة', 'الحديد', 'المجادلة', 'الحشر', 'الممتحنة',
  'الصف', 'الجمعة', 'المنافقون', 'التغابن', 'الطلاق',
  'التحريم', 'الملك', 'القلم', 'الحاقة', 'المعارج',
  'نوح', 'الجن', 'المزمل', 'المدثر', 'القيامة',
  'الإنسان', 'المرسلات', 'النبأ', 'النازعات', 'عبس',
  'التكوير', 'الانفطار', 'المطففين', 'الانشقاق', 'البروج',
  'الطارق', 'الأعلى', 'الغاشية', 'الفجر', 'البلد',
  'الشمس', 'الليل', 'الضحى', 'الشرح', 'التين',
  'العلق', 'القدر', 'البينة', 'الزلزلة', 'العاديات',
  'القارعة', 'التكاثر', 'العصر', 'الهمزة', 'الفيل',
  'قريش', 'الماعون', 'الكوثر', 'الكافرون', 'النصر',
  'المسد', 'الإخلاص', 'الفلق', 'الناس',
];

/// First page of each surah in the 604-page Madani mushaf.
const _surahStartPages = [
  1, 2, 50, 77, 106, 128, 151, 177, 187, 208, //
  221, 235, 249, 255, 262, 267, 282, 293, 305, 312,
  322, 332, 342, 350, 359, 367, 377, 385, 396, 404,
  411, 415, 418, 428, 434, 440, 446, 453, 458, 467,
  477, 483, 489, 496, 499, 502, 507, 511, 515, 518,
  520, 523, 526, 528, 531, 534, 537, 542, 545, 549,
  551, 553, 554, 556, 558, 560, 562, 564, 566, 568,
  570, 572, 574, 575, 577, 578, 580, 582, 583, 585,
  586, 587, 587, 589, 590, 591, 591, 592, 593, 594,
  595, 595, 596, 596, 597, 597, 598, 598, 599, 599,
  600, 600, 601, 601, 601, 602, 602, 602, 603, 603,
  603, 604, 604, 604,
];

/// Approximate page length of a surah; short surahs sharing a page count as 1.
int surahPageCount(int number) {
  final start = _surahStartPages[number - 1];
  final next = number == 114 ? 605 : _surahStartPages[number];
  return (next - start).clamp(1, 604);
}

String surahLabel(int number) => '${surahNames[number - 1]} (Surah $number)';

/// Finds the surah number from a stored label or plain name.
int? surahNumberOf(String? label) {
  if (label == null) return null;
  final match = RegExp(r'Surah (\d+)').firstMatch(label);
  if (match != null) return int.tryParse(match.group(1)!);
  final index = surahNames.indexWhere(
    (n) => label.toLowerCase().startsWith(n.toLowerCase()),
  );
  return index < 0 ? null : index + 1;
}

String surahShortName(String label) {
  final n = surahNumberOf(label);
  return n == null ? label : surahNames[n - 1];
}

/// Surah name in the display language: "Al-Kahf" or "الكهف".
String surahName(int number, {required bool arabic}) =>
    (arabic ? surahNamesAr : surahNames)[number - 1];

/// Display form of a stored surah label such as
/// "Al-Baqarah (Surah 2) · Pages 18–21": the canonical name is swapped for the
/// Arabic one ("سورة البقرة · Pages 18–21"); the user's portion is kept.
String localizeSurahLabel(String label, {required bool arabic}) {
  if (!arabic) return label;
  final tagged = RegExp(r'^(.*?)\s*\(Surah (\d+)\)').firstMatch(label);
  int? number;
  var rest = label;
  if (tagged != null) {
    number = int.tryParse(tagged.group(2)!);
    rest = label.substring(tagged.end);
  } else {
    final index = surahNames.indexWhere(
      (n) => label.toLowerCase().startsWith(n.toLowerCase()),
    );
    if (index >= 0) {
      number = index + 1;
      rest = label.substring(surahNames[index].length);
    }
  }
  if (number == null || number < 1 || number > 114) return label;
  return 'سورة ${surahNamesAr[number - 1]}$rest';
}
