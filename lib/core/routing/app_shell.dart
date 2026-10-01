import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/notifications/data/reminder_scheduler.dart';
import '../../features/today/presentation/quick_add/quick_add_sheet.dart';
import '../widgets/app_bottom_navigation.dart';

/// Hosts the four main tabs with the single bottom navigation bar.
class AppShell extends ConsumerWidget {
  const AppShell({super.key, required this.shell});

  final StatefulNavigationShell shell;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(reminderSyncProvider);
    return Scaffold(
      body: shell,
      bottomNavigationBar: AppBottomNavigation(
        currentIndex: shell.currentIndex,
        onTabSelected: (index) =>
            shell.goBranch(index, initialLocation: index == shell.currentIndex),
        onQuickAdd: () => showQuickAddSheet(context),
      ),
    );
  }
}
