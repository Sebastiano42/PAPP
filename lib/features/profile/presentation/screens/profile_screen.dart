import 'package:flutter/material.dart';
import '../../../../app/theme/app_colors.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

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
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Avatar + nome
          Center(
            child: Column(
              children: [
                CircleAvatar(
                  radius: 44,
                  backgroundColor: isDark ? AppColors.darkSurface : AppColors.lightSurface,
                  child: const Icon(Icons.person, size: 44, color: AppColors.accent),
                ),
                const SizedBox(height: 12),
                Text('Marco Rossi', style: theme.textTheme.headlineMedium),
                Text('marco.rossi@email.com', style: theme.textTheme.bodySmall),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Stats
          Row(
            children: [
              Expanded(child: _StatCard(value: '24', label: 'Sessioni', isDark: isDark)),
              const SizedBox(width: 12),
              Expanded(child: _StatCard(value: '8', label: 'Settimane', isDark: isDark)),
              const SizedBox(width: 12),
              Expanded(child: _StatCard(value: '5', label: 'Streak', isDark: isDark)),
            ],
          ),

          const SizedBox(height: 24),

          // Menu items
          _MenuSection(
            title: 'ACCOUNT',
            items: [
              _MenuItem(icon: Icons.person_outline, label: 'Modifica profilo', onTap: () {}),
              _MenuItem(icon: Icons.lock_outline, label: 'Cambia password', onTap: () {}),
              _MenuItem(icon: Icons.notifications_outlined, label: 'Notifiche', onTap: () {}),
            ],
            isDark: isDark,
            theme: theme,
          ),

          const SizedBox(height: 16),

          _MenuSection(
            title: 'ATTIVITÀ',
            items: [
              _MenuItem(icon: Icons.history, label: 'Storico allenamenti', onTap: () {}),
              _MenuItem(icon: Icons.bar_chart_outlined, label: 'Statistiche', onTap: () {}),
              _MenuItem(icon: Icons.calendar_month_outlined, label: 'Le mie prenotazioni', onTap: () {}),
            ],
            isDark: isDark,
            theme: theme,
          ),

          const SizedBox(height: 16),

          _MenuSection(
            title: 'APP',
            items: [
              _MenuItem(icon: Icons.dark_mode_outlined, label: 'Tema', onTap: () {}),
              _MenuItem(icon: Icons.help_outline, label: 'Supporto', onTap: () {}),
            ],
            isDark: isDark,
            theme: theme,
          ),

          const SizedBox(height: 24),

          // Logout
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () {}, // TODO: logout
              child: const Text('ESCI'),
            ),
          ),

          const SizedBox(height: 32),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({required this.value, required this.label, required this.isDark});
  final String value, label;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
        ),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: theme.textTheme.headlineLarge?.copyWith(
              color: AppColors.accent,
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
    required this.isDark,
    required this.theme,
  });
  final String title;
  final List<_MenuItem> items;
  final bool isDark;
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
            color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
            ),
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
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      size: 14,
                      color: isDark
                          ? AppColors.darkTextTertiary
                          : AppColors.lightTextTertiary,
                    ),
                    onTap: item.onTap,
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 4),
                  ),
                  if (i < items.length - 1)
                    Divider(
                      height: 1,
                      indent: 52,
                      color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
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
