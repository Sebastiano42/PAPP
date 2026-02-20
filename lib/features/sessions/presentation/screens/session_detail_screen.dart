import 'package:flutter/material.dart';
import '../../../../app/theme/app_colors.dart';

class SessionDetailScreen extends StatelessWidget {
  const SessionDetailScreen({super.key, required this.sessionId});
  final String sessionId;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('DETTAGLIO SESSIONE'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: isDark
                          ? AppColors.accentTintDark
                          : AppColors.accentTintLight,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Text(
                      'HIIT',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: AppColors.accent,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text('HIIT MORNING BLAST', style: theme.textTheme.headlineLarge),
                  const SizedBox(height: 8),
                  Text(
                    'Un allenamento ad alta intensità progettato per bruciare calorie e migliorare la resistenza cardiovascolare.',
                    style: theme.textTheme.bodyMedium,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Info grid
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  _InfoRow(icon: Icons.person_outline, label: 'Coach', value: 'Sara Rossi'),
                  _Divider(),
                  _InfoRow(icon: Icons.schedule_outlined, label: 'Orario', value: 'Lun 20 Feb · 09:00 – 10:00'),
                  _Divider(),
                  _InfoRow(icon: Icons.location_on_outlined, label: 'Sala', value: 'Sala 1'),
                  _Divider(),
                  _InfoRow(icon: Icons.timer_outlined, label: 'Durata', value: '60 minuti'),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Disponibilità
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('DISPONIBILITÀ', style: theme.textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.2,
                  )),
                  const SizedBox(height: 12),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(999),
                    child: LinearProgressIndicator(
                      value: 8 / 15,
                      minHeight: 8,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text('8 / 15 posti disponibili', style: theme.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.accent,
                  )),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // CTA
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // TODO: implementare prenotazione via Supabase
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Prenotazione confermata!')),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 18),
                ),
                child: const Text('PRENOTA SESSIONE'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.icon, required this.label, required this.value});
  final IconData icon;
  final String label, value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Icon(icon, size: 20, color: AppColors.accent),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: theme.textTheme.bodySmall),
              Text(value, style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600)),
            ],
          ),
        ],
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Divider(
      color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
      height: 1,
    );
  }
}
