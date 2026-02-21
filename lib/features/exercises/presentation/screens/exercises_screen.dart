import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_widgets.dart';

class ExercisesScreen extends StatefulWidget {
  const ExercisesScreen({super.key});

  @override
  State<ExercisesScreen> createState() => _ExercisesScreenState();
}

class _ExercisesScreenState extends State<ExercisesScreen> {
  String _selectedMuscle = 'TUTTI';

  final _muscles = ['TUTTI', 'PETTO', 'SCHIENA', 'GAMBE', 'SPALLE', 'BRACCIA', 'CORE'];

  final _mockExercises = [
    _MockExercise(id: '1', name: 'Squat', muscles: ['Quadricipiti', 'Glutei'], difficulty: 2, category: 'FORZA'),
    _MockExercise(id: '2', name: 'Push-Up', muscles: ['Petto', 'Tricipiti'], difficulty: 1, category: 'CORPO LIBERO'),
    _MockExercise(id: '3', name: 'Deadlift', muscles: ['Schiena', 'Glutei', 'Femorali'], difficulty: 3, category: 'FORZA'),
    _MockExercise(id: '4', name: 'Pull-Up', muscles: ['Dorsali', 'Bicipiti'], difficulty: 3, category: 'CORPO LIBERO'),
    _MockExercise(id: '5', name: 'Plank', muscles: ['Core', 'Spalle'], difficulty: 1, category: 'CORE'),
    _MockExercise(id: '6', name: 'Burpee', muscles: ['Full Body'], difficulty: 2, category: 'CARDIO'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ESERCIZI'),
      ),
      body: ScaffoldGradientBackground(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Filtri muscoli
            SizedBox(
              height: 48,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemCount: _muscles.length,
                itemBuilder: (context, i) {
                  final selected = _selectedMuscle == _muscles[i];
                  return GestureDetector(
                    onTap: () => setState(() => _selectedMuscle = _muscles[i]),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      decoration: BoxDecoration(
                        gradient: selected
                            ? const LinearGradient(colors: AppColors.accentGradient)
                            : null,
                        color: selected ? null : AppColors.glassSurface,
                        borderRadius: BorderRadius.circular(999),
                        border: selected
                            ? null
                            : Border.all(color: AppColors.glassBorderSubtle, width: 0.5),
                        boxShadow: selected
                            ? [
                                BoxShadow(
                                  color: AppColors.accent.withValues(alpha: 0.3),
                                  blurRadius: 12,
                                ),
                              ]
                            : null,
                      ),
                      child: Text(
                        _muscles[i],
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: selected
                              ? AppColors.textOnAccent
                              : AppColors.darkTextSecondary,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 8),

            // Lista esercizi
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.all(16),
                separatorBuilder: (_, __) => const SizedBox(height: 16),
                itemCount: _mockExercises.length,
                itemBuilder: (context, i) => _ExerciseCard(
                  exercise: _mockExercises[i],
                  onTap: () => context.go('/exercises/${_mockExercises[i].id}'),
                ).animate().fadeIn(duration: 500.ms, delay: (i * 80).ms).slideY(begin: 0.1, end: 0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ExerciseCard extends StatelessWidget {
  const _ExerciseCard({required this.exercise, required this.onTap});
  final _MockExercise exercise;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GlowCard(
      onTap: onTap,
      child: Row(
        children: [
          // Placeholder animazione (sarà Rive)
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppColors.accent.withValues(alpha: 0.15),
                  AppColors.accentAlt.withValues(alpha: 0.08),
                ],
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.fitness_center, color: AppColors.accent),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(exercise.name, style: theme.textTheme.headlineSmall),
                const SizedBox(height: 4),
                Text(
                  exercise.muscles.join(' · '),
                  style: theme.textTheme.bodySmall,
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    _CategoryChip(label: exercise.category),
                    const SizedBox(width: 8),
                    _DifficultyDots(level: exercise.difficulty),
                  ],
                ),
              ],
            ),
          ),
          const Icon(
            Icons.arrow_forward_ios,
            size: 14,
            color: AppColors.darkTextTertiary,
          ),
        ],
      ),
    );
  }
}

class _CategoryChip extends StatelessWidget {
  const _CategoryChip({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: AppColors.glassSurface,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: AppColors.accent.withValues(alpha: 0.4),
        ),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontFamily: 'Inter',
          fontSize: 10,
          fontWeight: FontWeight.w700,
          color: AppColors.accent,
          letterSpacing: 0.3,
        ),
      ),
    );
  }
}

class _DifficultyDots extends StatelessWidget {
  const _DifficultyDots({required this.level});
  final int level; // 1-3

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(3, (i) {
        final active = i < level;
        return Container(
          width: 6,
          height: 6,
          margin: const EdgeInsets.only(right: 3),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: active
                ? AppColors.accent
                : AppColors.darkSurfaceHigh,
            boxShadow: active
                ? [
                    BoxShadow(
                      color: AppColors.accent.withValues(alpha: 0.4),
                      blurRadius: 4,
                    ),
                  ]
                : null,
          ),
        );
      }),
    );
  }
}

class _MockExercise {
  const _MockExercise({
    required this.id,
    required this.name,
    required this.muscles,
    required this.difficulty,
    required this.category,
  });
  final String id, name, category;
  final List<String> muscles;
  final int difficulty;
}
