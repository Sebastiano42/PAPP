import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../app/theme/app_widgets.dart';
import '../../../../app/router.dart';

class TimerHomeScreen extends StatelessWidget {
  const TimerHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'TIMER',
                    style: TextStyle(
                      fontFamily: AppTypography.fontFamily,
                      fontSize: 28,
                      fontWeight: FontWeight.w900,
                      color: AppColors.darkTextPrimary,
                      letterSpacing: 0.5,
                    ),
                  ),
                  Container(
                    width: 40,
                    height: 40,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.darkSurfaceHigh,
                    ),
                    child: const Icon(
                      Icons.timer_outlined,
                      color: AppColors.accent,
                      size: 22,
                    ),
                  ),
                ],
              ),
            ),

            // Allenamenti Preimpostati section
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'PRESET WORKOUTS',
                    style: TextStyle(
                      fontFamily: AppTypography.fontFamily,
                      fontSize: 13,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1.5,
                      color: AppColors.darkTextPrimary,
                    ),
                  ),
                  Text(
                    '${_presetWorkouts.length} workout',
                    style: const TextStyle(
                      fontFamily: AppTypography.fontFamily,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: AppColors.darkTextSecondary,
                    ),
                  ),
                ],
              ),
            ),

            // Preset workout cards
            ...List.generate(_presetWorkouts.length, (i) {
              final workout = _presetWorkouts[i];
              return Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
                child: _PresetWorkoutCard(workout: workout)
                    .animate()
                    .fadeIn(duration: 500.ms, delay: (i * 100).ms)
                    .slideY(begin: 0.05, end: 0),
              );
            }),

            const SizedBox(height: 16),

            // I Miei Timer section
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'MY TIMERS',
                    style: TextStyle(
                      fontFamily: AppTypography.fontFamily,
                      fontSize: 13,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1.5,
                      color: AppColors.darkTextPrimary,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => context.go(AppRoutes.createTimer),
                    child: const Text(
                      'Vedi tutti',
                      style: TextStyle(
                        fontFamily: AppTypography.fontFamily,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: AppColors.accent,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Empty state + create button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SurfaceCard(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    Icon(
                      Icons.add_alarm,
                      color: AppColors.darkTextSecondary.withValues(alpha: 0.4),
                      size: 48,
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Nessun timer personalizzato',
                      style: TextStyle(
                        fontFamily: AppTypography.fontFamily,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppColors.darkTextSecondary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Crea un timer su misura per il tuo allenamento',
                      style: TextStyle(
                        fontFamily: AppTypography.fontFamily,
                        fontSize: 12,
                        color: AppColors.darkTextSecondary.withValues(alpha: 0.6),
                      ),
                    ),
                    const SizedBox(height: 20),
                    PrimaryButton(
                      label: '+ CREA TIMER',
                      icon: Icons.add,
                      onPressed: () => context.go(AppRoutes.createTimer),
                      expand: false,
                    ),
                  ],
                ),
              )
                  .animate()
                  .fadeIn(duration: 500.ms, delay: 400.ms),
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Preset Workout Card
// ---------------------------------------------------------------------------
class _PresetWorkoutCard extends StatelessWidget {
  const _PresetWorkoutCard({required this.workout});
  final _PresetWorkout workout;

  Color get _difficultyColor {
    switch (workout.difficulty) {
      case 'Alta':
        return AppColors.difficultyAdvanced;
      case 'Media':
        return AppColors.difficultyIntermediate;
      default:
        return AppColors.difficultyBeginner;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SurfaceCard(
      padding: const EdgeInsets.all(20),
      onTap: () => context.go(AppRoutes.activeTimer),
      child: Row(
        children: [
          // Icon container
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: AppColors.accent.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(
              workout.icon,
              color: AppColors.accent,
              size: 28,
            ),
          ),
          const SizedBox(width: 16),

          // Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  workout.name,
                  style: const TextStyle(
                    fontFamily: AppTypography.fontFamily,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: AppColors.darkTextPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text(
                      workout.duration,
                      style: const TextStyle(
                        fontFamily: AppTypography.fontFamily,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: AppColors.darkTextSecondary,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      width: 3,
                      height: 3,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.darkTextSecondary,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      workout.exercises,
                      style: const TextStyle(
                        fontFamily: AppTypography.fontFamily,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: AppColors.darkTextSecondary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Difficulty badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: _difficultyColor.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(999),
            ),
            child: Text(
              workout.difficulty,
              style: TextStyle(
                fontFamily: AppTypography.fontFamily,
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: _difficultyColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Mock data
// ---------------------------------------------------------------------------
const _presetWorkouts = [
  _PresetWorkout(
    name: 'HIIT Express',
    duration: '20 min',
    exercises: '8 esercizi',
    difficulty: 'Alta',
    icon: Icons.local_fire_department,
  ),
  _PresetWorkout(
    name: 'Tabata Classic',
    duration: '4 min',
    exercises: '8 round',
    difficulty: 'Media',
    icon: Icons.flash_on,
  ),
  _PresetWorkout(
    name: 'Full Body Burn',
    duration: '30 min',
    exercises: '12 esercizi',
    difficulty: 'Alta',
    icon: Icons.fitness_center,
  ),
  _PresetWorkout(
    name: 'Core Blast',
    duration: '15 min',
    exercises: '6 esercizi',
    difficulty: 'Media',
    icon: Icons.sports_martial_arts,
  ),
];

class _PresetWorkout {
  const _PresetWorkout({
    required this.name,
    required this.duration,
    required this.exercises,
    required this.difficulty,
    required this.icon,
  });
  final String name, duration, exercises, difficulty;
  final IconData icon;
}
