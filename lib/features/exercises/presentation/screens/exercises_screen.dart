import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';

class ExercisesScreen extends StatefulWidget {
  const ExercisesScreen({super.key});

  @override
  State<ExercisesScreen> createState() => _ExercisesScreenState();
}

class _ExercisesScreenState extends State<ExercisesScreen> {
  String _selectedMuscle = 'Tutto';

  final _muscles = ['Tutto', 'Gambe', 'Schiena', 'Petto', 'Braccia', 'Core'];

  final _mockExercises = [
    _MockExercise(
      id: '1',
      name: 'Barbell Bench Press',
      muscles: 'Petto \u2022 Bilanciere',
      difficulty: 'Principiante',
      difficultyColor: AppColors.difficultyBeginner,
      imageUrl: 'https://images.unsplash.com/photo-1534368959876-26bf04f2c947?w=160&h=160&fit=crop',
    ),
    _MockExercise(
      id: '2',
      name: 'Barbell Squat',
      muscles: 'Gambe \u2022 Quadricipiti',
      difficulty: 'Intermedio',
      difficultyColor: AppColors.difficultyIntermediate,
      imageUrl: 'https://images.unsplash.com/photo-1566241142559-40e1dab266c6?w=160&h=160&fit=crop',
    ),
    _MockExercise(
      id: '3',
      name: 'Pull Up',
      muscles: 'Schiena \u2022 Dorsali',
      difficulty: 'Avanzato',
      difficultyColor: AppColors.difficultyAdvanced,
      imageUrl: 'https://images.unsplash.com/photo-1598971639058-fab3c3109a00?w=160&h=160&fit=crop',
    ),
    _MockExercise(
      id: '4',
      name: 'Dumbbell Curl',
      muscles: 'Braccia \u2022 Bicipiti',
      difficulty: 'Principiante',
      difficultyColor: AppColors.difficultyBeginner,
      imageUrl: 'https://images.unsplash.com/photo-1581009146145-b5ef050c2e1e?w=160&h=160&fit=crop',
    ),
    _MockExercise(
      id: '5',
      name: 'Plank',
      muscles: 'Core \u2022 Addominali',
      difficulty: 'Principiante',
      difficultyColor: AppColors.difficultyBeginner,
      imageUrl: 'https://images.unsplash.com/photo-1566241142559-40e1dab266c6?w=160&h=160&fit=crop',
    ),
    _MockExercise(
      id: '6',
      name: 'Deadlift',
      muscles: 'Gambe \u2022 Glutei & Schiena',
      difficulty: 'Avanzato',
      difficultyColor: AppColors.difficultyAdvanced,
      imageUrl: 'https://images.unsplash.com/photo-1517963879433-6ad2b056d712?w=160&h=160&fit=crop',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Esercizi',
                    style: TextStyle(
                      fontFamily: AppTypography.fontFamily,
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                      color: AppColors.darkTextPrimary,
                      letterSpacing: -0.5,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.tune,
                      color: AppColors.accent,
                      size: 28,
                    ),
                  ),
                ],
              ),
            ),

            // Search bar
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
              child: Container(
                height: 48,
                decoration: BoxDecoration(
                  color: AppColors.darkSurfaceHigh,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    const SizedBox(width: 12),
                    Icon(
                      Icons.search,
                      color: AppColors.darkTextSecondary.withValues(alpha: 0.6),
                      size: 22,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        style: const TextStyle(
                          fontFamily: AppTypography.fontFamily,
                          color: AppColors.darkTextPrimary,
                          fontSize: 16,
                        ),
                        decoration: InputDecoration(
                          hintText: 'Cerca esercizi',
                          hintStyle: TextStyle(
                            fontFamily: AppTypography.fontFamily,
                            color: AppColors.darkTextSecondary.withValues(alpha: 0.6),
                            fontSize: 16,
                          ),
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          contentPadding: EdgeInsets.zero,
                          isDense: true,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Filter chips
            const SizedBox(height: 12),
            SizedBox(
              height: 40,
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
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        color: selected
                            ? AppColors.accent
                            : AppColors.darkSurfaceHigh,
                        borderRadius: BorderRadius.circular(999),
                        border: selected
                            ? null
                            : Border.all(
                                color: Colors.white.withValues(alpha: 0.1),
                                width: 1,
                              ),
                      ),
                      child: Text(
                        _muscles[i],
                        style: TextStyle(
                          fontFamily: AppTypography.fontFamily,
                          fontSize: 14,
                          fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
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

            const SizedBox(height: 16),

            // Section header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'POPOLARI',
                    style: TextStyle(
                      fontFamily: AppTypography.fontFamily,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.5,
                      color: AppColors.darkTextSecondary.withValues(alpha: 0.6),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
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

            const SizedBox(height: 8),

            // Exercise list
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemCount: _mockExercises.length,
                itemBuilder: (context, i) => _ExerciseCard(
                  exercise: _mockExercises[i],
                  onTap: () => context.go('/exercises/${_mockExercises[i].id}'),
                ).animate().fadeIn(duration: 500.ms, delay: (i * 60).ms),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Exercise Card — con immagine reale
// ---------------------------------------------------------------------------
class _ExerciseCard extends StatelessWidget {
  const _ExerciseCard({required this.exercise, required this.onTap});
  final _MockExercise exercise;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.darkSurfaceHigh,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.05),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            // Thumbnail con immagine
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: AppColors.darkSurfaceHigher,
                borderRadius: BorderRadius.circular(12),
              ),
              clipBehavior: Clip.antiAlias,
              child: CachedNetworkImage(
                imageUrl: exercise.imageUrl,
                fit: BoxFit.cover,
                placeholder: (_, __) => Container(
                  color: AppColors.darkSurfaceHigher,
                  child: const Center(
                    child: SizedBox(
                      width: 20, height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2, color: AppColors.darkTextSecondary),
                    ),
                  ),
                ),
                errorWidget: (_, __, ___) => Container(
                  color: AppColors.darkSurfaceHigher,
                  child: const Icon(
                    Icons.fitness_center,
                    color: AppColors.darkTextSecondary,
                    size: 24,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),

            // Name + muscles + difficulty
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          exercise.name,
                          style: const TextStyle(
                            fontFamily: AppTypography.fontFamily,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: AppColors.darkTextPrimary,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 8),
                      // Difficulty badge
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: exercise.difficultyColor.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(
                            color: exercise.difficultyColor.withValues(alpha: 0.3),
                            width: 1,
                          ),
                        ),
                        child: Text(
                          exercise.difficulty,
                          style: TextStyle(
                            fontFamily: AppTypography.fontFamily,
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                            color: exercise.difficultyColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    exercise.muscles,
                    style: TextStyle(
                      fontFamily: AppTypography.fontFamily,
                      fontSize: 14,
                      color: AppColors.darkTextSecondary.withValues(alpha: 0.6),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),

            // Add button
            Icon(
              Icons.add_circle_outline,
              color: AppColors.darkTextSecondary.withValues(alpha: 0.5),
              size: 24,
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Mock model
// ---------------------------------------------------------------------------
class _MockExercise {
  const _MockExercise({
    required this.id,
    required this.name,
    required this.muscles,
    required this.difficulty,
    required this.difficultyColor,
    required this.imageUrl,
  });
  final String id, name, muscles, difficulty, imageUrl;
  final Color difficultyColor;
}
