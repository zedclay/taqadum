import 'package:flutter/widgets.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../domain/enums.dart';
import '../localization/l10n.dart';
import '../theme/app_colors.dart';

extension LifeAreaStyle on LifeArea {
  Color get color => switch (this) {
    LifeArea.quran => AppColors.quran,
    LifeArea.work => AppColors.work,
    LifeArea.finance => AppColors.finance,
    LifeArea.health => AppColors.health,
    LifeArea.learning => AppColors.learning,
    LifeArea.personal => AppColors.personal,
  };

  Color get soft => switch (this) {
    LifeArea.quran => AppColors.quranSoft,
    LifeArea.work => AppColors.workSoft,
    LifeArea.finance => AppColors.financeSoft,
    LifeArea.health => AppColors.healthSoft,
    LifeArea.learning => AppColors.learningSoft,
    LifeArea.personal => AppColors.personalSoft,
  };

  IconData get icon => switch (this) {
    LifeArea.quran => Symbols.menu_book,
    LifeArea.work => Symbols.work,
    LifeArea.finance => Symbols.account_balance_wallet,
    LifeArea.health => Symbols.favorite,
    LifeArea.learning => Symbols.school,
    LifeArea.personal => Symbols.family_restroom,
  };

  String label(BuildContext context) {
    final l = context.l10n;
    return switch (this) {
      LifeArea.quran => l.areaQuran,
      LifeArea.work => l.areaWork,
      LifeArea.finance => l.areaFinance,
      LifeArea.health => l.areaHealth,
      LifeArea.learning => l.areaLearning,
      LifeArea.personal => l.areaPersonal,
    };
  }

  String longLabel(BuildContext context) {
    final l = context.l10n;
    return switch (this) {
      LifeArea.quran => l.areaQuranLong,
      LifeArea.work => l.areaWorkLong,
      LifeArea.finance => l.areaFinanceLong,
      LifeArea.health => l.areaHealthLong,
      LifeArea.learning => l.areaLearningLong,
      LifeArea.personal => l.areaPersonalLong,
    };
  }

  String? get route => switch (this) {
    LifeArea.quran => '/quran',
    LifeArea.work => '/work',
    LifeArea.finance => '/finance',
    LifeArea.health => '/health',
    LifeArea.learning => '/learning',
    LifeArea.personal => null,
  };
}
