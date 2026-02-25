import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';
import '../router.dart';
import '../../features/program/presentation/screens/program_screen.dart';
import '../../features/sessions/presentation/screens/sessions_screen.dart';
import '../../features/timer/presentation/screens/timer_home_screen.dart';
import '../../features/progress/presentation/screens/progress_screen.dart';
import '../../features/profile/presentation/screens/profile_screen.dart';

/// Shell principale con bottom navigation bar + swipe tra tab.
class MainShell extends StatefulWidget {
  const MainShell({super.key, required this.child});
  final Widget child;

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  late PageController _pageController;

  static const _routes = [
    AppRoutes.home,
    AppRoutes.sessions,
    AppRoutes.timer,
    AppRoutes.progress,
    AppRoutes.profile,
  ];

  static const _screens = [
    ProgramScreen(),
    SessionsScreen(),
    TimerHomeScreen(),
    ProgressScreen(),
    ProfileScreen(),
  ];

  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  int _indexFromLocation(String location) {
    if (location.startsWith(AppRoutes.sessions)) return 1;
    if (location.startsWith(AppRoutes.timer)) return 2;
    if (location.startsWith(AppRoutes.progress)) return 3;
    if (location.startsWith(AppRoutes.profile)) return 4;
    return 0;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final location = GoRouterState.of(context).uri.toString();
    final newIndex = _indexFromLocation(location);
    if (newIndex != _currentIndex) {
      _currentIndex = newIndex;
      if (_pageController.hasClients) {
        _pageController.jumpToPage(newIndex);
      }
    }
  }

  void _onPageChanged(int index) {
    if (index != _currentIndex) {
      setState(() => _currentIndex = index);
      context.go(_routes[index]);
    }
  }

  void _onTabTapped(int index) {
    if (index != _currentIndex) {
      setState(() => _currentIndex = index);
      _pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      context.go(_routes[index]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: _onPageChanged,
        physics: const BouncingScrollPhysics(),
        children: _screens,
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: AppColors.darkBackground,
          border: Border(
            top: BorderSide(
              color: AppColors.darkBorderLight,
              width: 0.5,
            ),
          ),
        ),
        child: SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.only(top: 8, bottom: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildTab(0, 'Home', Icons.home_outlined, Icons.home),
                _buildTab(1, 'Sessioni', Icons.calendar_month_outlined, Icons.calendar_month),
                _buildTimerFab(),
                _buildTab(3, 'Progressi', Icons.bar_chart_outlined, Icons.bar_chart),
                _buildTab(4, 'Profilo', Icons.person_outline, Icons.person),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTab(int index, String label, IconData icon, IconData activeIcon) {
    final isSelected = _currentIndex == index;
    return GestureDetector(
      onTap: () => _onTabTapped(index),
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 64,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isSelected ? activeIcon : icon,
              color: isSelected
                  ? AppColors.accent
                  : AppColors.darkTextSecondary.withValues(alpha: 0.4),
              size: 26,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontFamily: AppTypography.fontFamily,
                fontSize: 10,
                fontWeight: FontWeight.w500,
                color: isSelected
                    ? AppColors.accent
                    : AppColors.darkTextSecondary.withValues(alpha: 0.4),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimerFab() {
    final isSelected = _currentIndex == 2;
    return GestureDetector(
      onTap: () => _onTabTapped(2),
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 64,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Transform.translate(
              offset: const Offset(0, -12),
              child: Container(
                width: 56,
                height: 56,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.accent,
                ),
                child: const Icon(
                  Icons.timer,
                  color: AppColors.textOnAccent,
                  size: 28,
                ),
              ),
            ),
            Transform.translate(
              offset: const Offset(0, -8),
              child: Text(
                'Timer',
                style: TextStyle(
                  fontFamily: AppTypography.fontFamily,
                  fontSize: 10,
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                  color: isSelected
                      ? AppColors.accent
                      : AppColors.darkTextSecondary.withValues(alpha: 0.6),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
