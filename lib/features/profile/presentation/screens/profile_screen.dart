import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_widgets.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('PROFILO'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () {}, // TODO: settings
          ),
        ],
      ),
      body: ScaffoldGradientBackground(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Avatar + nome
            Center(
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: const SweepGradient(
                        colors: [
                          AppColors.accent,
                          AppColors.accentAlt,
                          AppColors.accent,
                        ],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.accent.withValues(alpha: 0.4),
                          blurRadius: 24,
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(3),
                    child: const CircleAvatar(
                      radius: 44,
                      backgroundColor: AppColors.darkSurface,
                      child: Icon(Icons.person, size: 44, color: AppColors.accent),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text('Marco Rossi', style: theme.textTheme.headlineMedium),
                  Text('marco.rossi@email.com', style: theme.textTheme.bodySmall),
                ],
              ),
            ).animate().fadeIn(duration: 500.ms).slideY(begin: -0.1, end: 0),

            const SizedBox(height: 24),

            // Stats
            Row(
              children: [
                Expanded(child: _StatCard(value: '24', label: 'Sessioni')),
                const SizedBox(width: 16),
                Expanded(child: _StatCard(value: '8', label: 'Settimane')),
                const SizedBox(width: 16),
                Expanded(child: _StatCard(value: '5', label: 'Streak')),
              ],
            ).animate().fadeIn(duration: 500.ms, delay: 150.ms).slideY(begin: 0.1, end: 0),

            const SizedBox(height: 24),

            // Menu items
            _MenuSection(
              title: 'ACCOUNT',
              items: [
                _MenuItem(icon: Icons.person_outline, label: 'Modifica profilo', onTap: () {}),
                _MenuItem(icon: Icons.lock_outline, label: 'Cambia password', onTap: () {}),
                _MenuItem(icon: Icons.notifications_outlined, label: 'Notifiche', onTap: () {}),
              ],
              theme: theme,
            ).animate().fadeIn(duration: 500.ms, delay: 300.ms),

            const SizedBox(height: 16),

            _MenuSection(
              title: 'ATTIVITÀ',
              items: [
                _MenuItem(icon: Icons.history, label: 'Storico allenamenti', onTap: () {}),
                _MenuItem(icon: Icons.bar_chart_outlined, label: 'Statistiche', onTap: () {}),
                _MenuItem(icon: Icons.calendar_month_outlined, label: 'Le mie prenotazioni', onTap: () {}),
              ],
              theme: theme,
            ).animate().fadeIn(duration: 500.ms, delay: 400.ms),

            const SizedBox(height: 16),

            _MenuSection(
              title: 'APP',
              items: [
                _MenuItem(icon: Icons.help_outline, label: 'Supporto', onTap: () {}),
              ],
              theme: theme,
            ).animate().fadeIn(duration: 500.ms, delay: 500.ms),

            const SizedBox(height: 24),

            // Logout
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {}, // TODO: logout
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.error,
                  side: const BorderSide(color: AppColors.error),
                ),
                child: const Text('ESCI'),
              ),
            ).animate().fadeIn(duration: 500.ms, delay: 600.ms),

            const SizedBox(height: 96), // space for floating nav
          ],
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({required this.value, required this.label});
  final String value, label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GlowCard(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        children: [
          Text(
            value,
            style: theme.textTheme.headlineLarge?.copyWith(
              color: AppColors.accent,
              shadows: [
                Shadow(
                  color: AppColors.accent.withValues(alpha: 0.4),
                  blurRadius: 12,
                ),
              ],
            ),
          ),
          const SizedBox(height: 2),
          Text(label, style: theme.textTheme.bodySmall),
        ],
      ),
    );
  }
}

class _MenuSection extends StatelessWidget {
  const _MenuSection({
    required this.title,
    required this.items,
    required this.theme,
  });
  final String title;
  final List<_MenuItem> items;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: theme.textTheme.bodySmall?.copyWith(
            fontWeight: FontWeight.w700,
            letterSpacing: 1.5,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: AppColors.glassSurface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.glassBorderSubtle, width: 0.5),
          ),
          child: Column(
            children: items.asMap().entries.map((entry) {
              final i = entry.key;
              final item = entry.value;
              return Column(
                children: [
                  ListTile(
                    leading: Icon(item.icon, color: AppColors.accent, size: 22),
                    title: Text(item.label, style: theme.textTheme.bodyLarge),
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      size: 14,
                      color: AppColors.darkTextTertiary,
                    ),
                    onTap: item.onTap,
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 8),
                  ),
                  if (i < items.length - 1)
                    const Divider(
                      height: 1,
                      indent: 52,
                      color: AppColors.darkBorder,
                    ),
                ],
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}

class _MenuItem {
  const _MenuItem({required this.icon, required this.label, required this.onTap});
  final IconData icon;
  final String label;
  final VoidCallback onTap;
}
