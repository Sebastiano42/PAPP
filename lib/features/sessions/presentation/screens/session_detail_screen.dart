import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_widgets.dart';

class SessionDetailScreen extends StatelessWidget {
  const SessionDetailScreen({super.key, required this.sessionId});
  final String sessionId;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('DETTAGLIO SESSIONE'),
      ),
      body: ScaffoldGradientBackground(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Hero header
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      AppColors.darkSurfaceHigh,
                      AppColors.darkSurface,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.glassSurface,
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(
                          color: AppColors.accent.withValues(alpha: 0.4),
                        ),
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
              ).animate().fadeIn(duration: 500.ms).slideY(begin: 0.1, end: 0),

              const SizedBox(height: 16),

              // Info grid
              GlowCard(
                child: Column(
                  children: [
                    _InfoRow(icon: Icons.person_outline, label: 'Coach', value: 'Sara Rossi'),
                    const Divider(color: AppColors.darkBorder, height: 1),
                    _InfoRow(icon: Icons.schedule_outlined, label: 'Orario', value: 'Lun 20 Feb · 09:00 – 10:00'),
                    const Divider(color: AppColors.darkBorder, height: 1),
                    _InfoRow(icon: Icons.location_on_outlined, label: 'Sala', value: 'Sala 1'),
                    const Divider(color: AppColors.darkBorder, height: 1),
                    _InfoRow(icon: Icons.timer_outlined, label: 'Durata', value: '60 minuti'),
                  ],
                ),
              ).animate().fadeIn(duration: 500.ms, delay: 150.ms).slideY(begin: 0.1, end: 0),

              const SizedBox(height: 16),

              // Disponibilità
              GlowCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('DISPONIBILITÀ', style: theme.textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.2,
                    )),
                    const SizedBox(height: 12),
                    const GlowProgressBar(value: 8 / 15, height: 8),
                    const SizedBox(height: 8),
                    Text('8 / 15 posti disponibili', style: theme.textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.accent,
                    )),
                  ],
                ),
              ).animate().fadeIn(duration: 500.ms, delay: 300.ms).slideY(begin: 0.1, end: 0),

              const SizedBox(height: 32),

              // CTA
              GlowButton(
                label: 'PRENOTA SESSIONE',
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Prenotazione confermata!')),
                  );
                },
              ).animate().fadeIn(duration: 500.ms, delay: 450.ms).slideY(begin: 0.1, end: 0),
            ],
          ),
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
      padding: const EdgeInsets.symmetric(vertical: 12),
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
