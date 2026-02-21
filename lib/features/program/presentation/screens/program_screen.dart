import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_widgets.dart';

/// Home screen — mostra programma della settimana, prossima sessione, stats
class ProgramScreen extends StatelessWidget {
  const ProgramScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'BUONGIORNO, MARCO',
              style: theme.textTheme.headlineMedium,
            ),
            Text(
              'Lunedì 20 Febbraio',
              style: theme.textTheme.bodySmall,
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.accent.withValues(alpha: 0.3),
                    blurRadius: 12,
                  ),
                ],
              ),
              child: CircleAvatar(
                radius: 18,
                backgroundColor: AppColors.darkSurface,
                child: const Icon(Icons.person, color: AppColors.accent, size: 20),
              ),
            ),
          ),
        ],
      ),
      body: ScaffoldGradientBackground(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Prossima sessione
            _SectionHeader(title: 'PROSSIMA SESSIONE'),
            const SizedBox(height: 8),
            _NextSessionCard(theme: theme)
                .animate().fadeIn(duration: 500.ms).slideY(begin: 0.1, end: 0),

            const SizedBox(height: 24),

            // Settimana corrente — streak
            _SectionHeader(title: 'QUESTA SETTIMANA'),
            const SizedBox(height: 8),
            _WeekStreak(theme: theme)
                .animate().fadeIn(duration: 500.ms, delay: 150.ms).slideY(begin: 0.1, end: 0),

            const SizedBox(height: 24),

            // Allenamento di oggi
            _SectionHeader(title: 'ALLENAMENTO DI OGGI'),
            const SizedBox(height: 8),
            _TodayWorkout(theme: theme)
                .animate().fadeIn(duration: 500.ms, delay: 300.ms).slideY(begin: 0.1, end: 0),

            const SizedBox(height: 96), // space for floating nav
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Prossima sessione card
// ---------------------------------------------------------------------------
class _NextSessionCard extends StatelessWidget {
  const _NextSessionCard({required this.theme});
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return GlowCard(
      glowBorder: true,
      padding: const EdgeInsets.all(20),
      onTap: () => context.go('/sessions/1'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text('HIIT MORNING BLAST',
                    style: theme.textTheme.headlineMedium),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
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
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: AppColors.accent,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text('Coach: Sara Rossi', style: theme.textTheme.bodyMedium),
          const SizedBox(height: 12),
          Row(
            children: [
              const Icon(Icons.schedule_outlined, size: 14, color: AppColors.accent),
              const SizedBox(width: 6),
              Text('Oggi · 18:30', style: theme.textTheme.bodySmall),
              const SizedBox(width: 16),
              const Icon(Icons.location_on_outlined, size: 14, color: AppColors.accent),
              const SizedBox(width: 6),
              Text('Sala 1', style: theme.textTheme.bodySmall),
            ],
          ),
          const SizedBox(height: 16),

          // Progress bar posti
          const GlowProgressBar(value: 8 / 15),
          const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('8/15 posti', style: theme.textTheme.bodySmall),
              GlowButton(
                label: 'PRENOTA',
                expand: false,
                onPressed: () => context.go('/sessions/1'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Week streak
// ---------------------------------------------------------------------------
class _WeekStreak extends StatelessWidget {
  const _WeekStreak({required this.theme});
  final ThemeData theme;

  static const _days = ['L', 'M', 'M', 'G', 'V', 'S', 'D'];
  static const _done = [true, true, true, false, false, false, false];

  @override
  Widget build(BuildContext context) {
    return GlowCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: List.generate(7, (i) {
              final done = _done[i];
              final isToday = i == 3;
              return Expanded(
                child: Column(
                  children: [
                    Text(
                      _days[i],
                      style: theme.textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: isToday ? AppColors.accent : null,
                      ) ?? theme.textTheme.bodySmall,
                    ),
                    const SizedBox(height: 6),
                    Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: done
                            ? AppColors.accent
                            : AppColors.darkSurfaceHigh,
                        border: isToday && !done
                            ? Border.all(color: AppColors.accent, width: 2)
                            : null,
                        boxShadow: done
                            ? [
                                BoxShadow(
                                  color: AppColors.accent.withValues(alpha: 0.4),
                                  blurRadius: 8,
                                ),
                              ]
                            : null,
                      ),
                      child: done
                          ? const Icon(Icons.check, size: 16, color: AppColors.textOnAccent)
                          : null,
                    ),
                  ],
                ),
              );
            }),
          ),
          const SizedBox(height: 12),
          const GlowProgressBar(value: 3 / 7),
          const SizedBox(height: 6),
          Text('3 su 7 giorni completati', style: theme.textTheme.bodySmall),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Allenamento di oggi
// ---------------------------------------------------------------------------
class _TodayWorkout extends StatelessWidget {
  const _TodayWorkout({required this.theme});
  final ThemeData theme;

  static const _exercises = [
    _ExItem(name: 'Squat', detail: '4 × 10 · 90s rest'),
    _ExItem(name: 'Romanian Deadlift', detail: '3 × 12 · 60s rest'),
    _ExItem(name: 'Leg Press', detail: '3 × 15 · 60s rest'),
    _ExItem(name: 'Affondi', detail: '3 × 12/lato · 60s rest'),
  ];

  @override
  Widget build(BuildContext context) {
    return GlowCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('LEG DAY', style: theme.textTheme.headlineSmall),
              Text('60 min', style: theme.textTheme.bodySmall?.copyWith(
                color: AppColors.accent,
                fontWeight: FontWeight.w600,
              )),
            ],
          ),
          const SizedBox(height: 12),
          ..._exercises.map((e) => _ExerciseRow(item: e, theme: theme)),
        ],
      ),
    );
  }
}

class _ExerciseRow extends StatelessWidget {
  const _ExerciseRow({required this.item, required this.theme});
  final _ExItem item;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 36,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: AppColors.accentGradient,
              ),
              borderRadius: BorderRadius.circular(999),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.name, style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600)),
                Text(item.detail, style: theme.textTheme.bodySmall),
              ],
            ),
          ),
          GestureDetector(
            onTap: () => context.go('/exercises/1'),
            child: const Icon(
              Icons.play_circle_outline,
              color: AppColors.accent,
              size: 28,
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 3,
          height: 14,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: AppColors.accentGradient,
            ),
            borderRadius: BorderRadius.circular(999),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          title,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.w700,
                letterSpacing: 1.5,
              ),
        ),
      ],
    );
  }
}

class _ExItem {
  const _ExItem({required this.name, required this.detail});
  final String name, detail;
}
