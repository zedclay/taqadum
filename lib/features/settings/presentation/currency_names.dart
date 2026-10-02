import '../../../core/localization/l10n.dart';

/// Localized name of a supported currency code.
String currencyDisplayName(AppLocalizations l, String code) => switch (code) {
  'DZD' => l.currencyDzd,
  'MAD' => l.currencyMad,
  'TND' => l.currencyTnd,
  'SAR' => l.currencySar,
  'AED' => l.currencyAed,
  'EGP' => l.currencyEgp,
  'EUR' => l.currencyEur,
  'USD' => l.currencyUsd,
  'GBP' => l.currencyGbp,
  _ => code,
};
