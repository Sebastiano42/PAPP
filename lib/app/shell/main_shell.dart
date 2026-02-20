import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../theme/app_colors.dart';
import '../router.dart';

/// Shell principale con bottom navigation bar.
/// Wrappa tutto il contenuto delle schermate autenticate.
class MainShell extends StatelessWidget {
  const MainShell({super.key, required this.child});

  final Widget child;

  static const _tabs = [
    _TabItem(label: 'Home', icon: Icons.home_outlined, activeIcon: Icons.home, route: AppRoutes.home),
    _TabItem(label: 'Sessioni', icon: Icons.calendar_month_outlined, activeIcon: Icons.calendar_month, route: AppRoutes.sessions),
    _TabItem(label: 'Esercizi', icon: Icons.fitness_center_outlined, activeIcon: Icons.fitness_center, route: AppRoutes.exercises),
    _TabItem(label: 'Profilo', icon: Icons.person_outline, activeIcon: Icons.person, route: AppRoutes.profile),
  ];

  int _currentIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    if (location.startsWith(AppRoutes.sessions)) return 1;
    if (location.startsWith(AppRoutes.exercises)) return 2;
    if (location.startsWith(AppRoutes.profile)) return 3;
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    final currentIndex = _currentIndex(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: child,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
              width: 1,
            ),
          ),
        ),
        child: NavigationBar(
          selectedIndex: currentIndex,
          onDestinationSelected: (index) {
            context.go(_tabs[index].route);
          },
          destinations: _tabs.map((tab) {
            return NavigationDestination(
              icon: Icon(tab.icon),
              selectedIcon: Icon(tab.activeIcon),
              label: tab.label,
            );
          }).toList(),
        ),
      ),
    );
  }
}

class _TabItem {
  const _TabItem({
    required this.label,
    required this.icon,
    required this.activeIcon,
    required this.route,
  });

  final String label;
  final IconData icon;
  final IconData activeIcon;
  final String route;
}
