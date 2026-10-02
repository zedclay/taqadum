import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/localization/app_locale.dart';
import '../core/localization/l10n.dart';
import '../core/providers.dart';
import '../core/routing/app_router.dart';
import '../core/theme/app_theme.dart';
import '../core/theme/app_typography.dart';
import '../features/settings/data/preferences.dart';

class TaqaddumApp extends ConsumerStatefulWidget {
  const TaqaddumApp({super.key});

  @override
  ConsumerState<TaqaddumApp> createState() => _TaqaddumAppState();
}

class _TaqaddumAppState extends ConsumerState<TaqaddumApp> {
  late final AppLifecycleListener _lifecycle;
  Timer? _dayTicker;
  String? _language;
  ThemeData? _theme;

  @override
  void initState() {
    super.initState();
    _lifecycle = AppLifecycleListener(onResume: _refreshDay);
    _dayTicker = Timer.periodic(
      const Duration(minutes: 1),
      (_) => _refreshDay(),
    );
  }

  void _refreshDay() => ref.read(currentDayProvider.notifier).refresh();

  /// Formatting and typography read the language globally, so it is applied
  /// before the tree builds. After a switch every element is rebuilt once so
  /// widgets that don't depend on [Localizations] pick up the new script.
  ThemeData _applyLanguage(String code) {
    if (code == _language && _theme != null) return _theme!;
    final switching = _language != null;
    _language = code;
    AppLocale.apply(code);
    AppTypography.useArabic(code == AppLanguages.arabic);
    _theme = AppTheme.light();
    if (switching) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        void rebuild(Element element) {
          element.markNeedsBuild();
          element.visitChildren(rebuild);
        }

        (context as Element).visitChildren(rebuild);
      });
    }
    return _theme!;
  }

  @override
  void dispose() {
    _dayTicker?.cancel();
    _lifecycle.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final router = ref.watch(routerProvider);
    final prefs = ref.watch(preferencesProvider);
    final theme = _applyLanguage(prefs.localeCode);
    return MaterialApp.router(
      onGenerateTitle: (context) => context.l10n.appName,
      debugShowCheckedModeBanner: false,
      theme: theme,
      themeMode: ThemeMode.light,
      locale: prefs.locale,
      supportedLocales: const [Locale('en'), Locale('ar', 'DZ'), Locale('ar')],
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      routerConfig: router,
      builder: (context, child) {
        final media = MediaQuery.of(context);
        return MediaQuery(
          data: media.copyWith(
            disableAnimations: media.disableAnimations || prefs.reduceMotion,
            textScaler: media.textScaler.clamp(maxScaleFactor: 1.35),
          ),
          child: child ?? const SizedBox.shrink(),
        );
      },
    );
  }
}
