import '../../../core/database/app_database.dart';
import '../../settings/data/preferences.dart';

abstract final class GoalUnits {
  static const common = [
    'pages',
    'juz',
    'hours',
    'minutes',
    'sessions',
    'books',
    'km',
    'times',
  ];

  static String defaultFor(LifeArea area, String currency) => switch (area) {
    LifeArea.quran => 'juz',
    LifeArea.work => currency,
    LifeArea.finance => currency,
    LifeArea.health => 'sessions',
    LifeArea.learning => 'hours',
    LifeArea.personal => 'times',
  };

  static bool isCurrency(String unit) =>
      supportedCurrencies.contains(unit.toUpperCase());
}
