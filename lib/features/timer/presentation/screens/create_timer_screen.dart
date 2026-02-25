import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../app/theme/app_widgets.dart';

class CreateTimerScreen extends StatefulWidget {
  const CreateTimerScreen({super.key});

  @override
  State<CreateTimerScreen> createState() => _CreateTimerScreenState();
}

class _CreateTimerScreenState extends State<CreateTimerScreen> {
  final _nameController = TextEditingController();
  int _restSeconds = 30;
  final List<_TimerExercise> _exercises = [
    const _TimerExercise(name: 'Esercizio 1', durationSeconds: 45),
  ];

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => context.go('/timer'),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.darkSurfaceHigh,
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.05),
                        ),
                      ),
                      child: const Icon(
                        Icons.arrow_back,
                        color: AppColors.darkTextPrimary,
                        size: 20,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  const Text(
                    'CREATE TIMER',
                    style: TextStyle(
                      fontFamily: AppTypography.fontFamily,
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.5,
                      color: AppColors.darkTextPrimary,
                    ),
                  ),
                ],
              ),
            ),

            // Content
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                children: [
                  // Timer name field
                  const Text(
                    'Nome del timer',
                    style: TextStyle(
                      fontFamily: AppTypography.fontFamily,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: AppColors.darkTextSecondary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.darkSurfaceHigh,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.05),
                      ),
                    ),
                    child: TextField(
                      controller: _nameController,
                      style: const TextStyle(
                        fontFamily: AppTypography.fontFamily,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: AppColors.darkTextPrimary,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Es. Il mio HIIT',
                        hintStyle: TextStyle(
                          fontFamily: AppTypography.fontFamily,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: AppColors.darkTextSecondary.withValues(alpha: 0.5),
                        ),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                        border: InputBorder.none,
                      ),
                    ),
                  ).animate().fadeIn(duration: 400.ms),

                  const SizedBox(height: 24),

                  // Rest time between exercises
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Riposo tra esercizi',
                        style: TextStyle(
                          fontFamily: AppTypography.fontFamily,
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: AppColors.darkTextSecondary,
                        ),
                      ),
                      Row(
                        children: [
                          _StepperButton(
                            icon: Icons.remove,
                            onTap: () {
                              if (_restSeconds > 5) {
                                setState(() => _restSeconds -= 5);
                              }
                            },
                          ),
                          SizedBox(
                            width: 56,
                            child: Center(
                              child: Text(
                                '${_restSeconds}s',
                                style: const TextStyle(
                                  fontFamily: AppTypography.fontFamily,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.accent,
                                ),
                              ),
                            ),
                          ),
                          _StepperButton(
                            icon: Icons.add,
                            onTap: () {
                              setState(() => _restSeconds += 5);
                            },
                          ),
                        ],
                      ),
                    ],
                  ).animate().fadeIn(duration: 400.ms, delay: 100.ms),

                  const SizedBox(height: 24),

                  // Exercises section
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Esercizi',
                        style: TextStyle(
                          fontFamily: AppTypography.fontFamily,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: AppColors.darkTextPrimary,
                        ),
                      ),
                      Text(
                        '${_exercises.length} ${_exercises.length == 1 ? 'esercizio' : 'esercizi'}',
                        style: const TextStyle(
                          fontFamily: AppTypography.fontFamily,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: AppColors.darkTextSecondary,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  // Exercise list
                  ...List.generate(_exercises.length, (i) {
                    final ex = _exercises[i];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: _ExerciseRow(
                        index: i,
                        exercise: ex,
                        onDurationChanged: (newDuration) {
                          setState(() {
                            _exercises[i] = _TimerExercise(
                              name: ex.name,
                              durationSeconds: newDuration,
                            );
                          });
                        },
                        onNameChanged: (newName) {
                          setState(() {
                            _exercises[i] = _TimerExercise(
                              name: newName,
                              durationSeconds: ex.durationSeconds,
                            );
                          });
                        },
                        onRemove: _exercises.length > 1
                            ? () => setState(() => _exercises.removeAt(i))
                            : null,
                      ).animate().fadeIn(duration: 400.ms, delay: (200 + i * 80).ms),
                    );
                  }),

                  // Add exercise button
                  const SizedBox(height: 8),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _exercises.add(_TimerExercise(
                          name: 'Esercizio ${_exercises.length + 1}',
                          durationSeconds: 45,
                        ));
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: AppColors.accent.withValues(alpha: 0.3),
                          width: 1.5,
                          strokeAlign: BorderSide.strokeAlignInside,
                        ),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.add, color: AppColors.accent, size: 20),
                          SizedBox(width: 8),
                          Text(
                            'Aggiungi Esercizio',
                            style: TextStyle(
                              fontFamily: AppTypography.fontFamily,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: AppColors.accent,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Total duration summary
                  SurfaceCard(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Durata totale stimata',
                          style: TextStyle(
                            fontFamily: AppTypography.fontFamily,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: AppColors.darkTextSecondary,
                          ),
                        ),
                        Text(
                          _formattedTotalDuration,
                          style: const TextStyle(
                            fontFamily: AppTypography.fontFamily,
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: AppColors.accent,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),
                ],
              ),
            ),

            // Save button
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
              child: PrimaryButton(
                label: 'SALVA TIMER',
                icon: Icons.save,
                onPressed: () {
                  // TODO: save timer logic
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      backgroundColor: AppColors.darkSurfaceHigh,
                      content: Text(
                        'Timer salvato!',
                        style: TextStyle(
                          fontFamily: AppTypography.fontFamily,
                          color: AppColors.darkTextPrimary,
                        ),
                      ),
                    ),
                  );
                  context.go('/timer');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  String get _formattedTotalDuration {
    final exercisesTime = _exercises.fold<int>(0, (sum, ex) => sum + ex.durationSeconds);
    final restTime = (_exercises.length > 1) ? (_exercises.length - 1) * _restSeconds : 0;
    final totalSeconds = exercisesTime + restTime;
    final minutes = totalSeconds ~/ 60;
    final seconds = totalSeconds % 60;
    if (minutes > 0 && seconds > 0) return '${minutes}m ${seconds}s';
    if (minutes > 0) return '${minutes}m';
    return '${seconds}s';
  }
}

// ---------------------------------------------------------------------------
// Exercise row
// ---------------------------------------------------------------------------
class _ExerciseRow extends StatelessWidget {
  const _ExerciseRow({
    required this.index,
    required this.exercise,
    required this.onDurationChanged,
    required this.onNameChanged,
    this.onRemove,
  });

  final int index;
  final _TimerExercise exercise;
  final ValueChanged<int> onDurationChanged;
  final ValueChanged<String> onNameChanged;
  final VoidCallback? onRemove;

  @override
  Widget build(BuildContext context) {
    return SurfaceCard(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          // Index badge
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: AppColors.accent.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                '${index + 1}',
                style: const TextStyle(
                  fontFamily: AppTypography.fontFamily,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: AppColors.accent,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),

          // Name
          Expanded(
            child: GestureDetector(
              onTap: () => _editName(context),
              child: Text(
                exercise.name,
                style: const TextStyle(
                  fontFamily: AppTypography.fontFamily,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.darkTextPrimary,
                ),
              ),
            ),
          ),

          // Duration stepper
          _StepperButton(
            icon: Icons.remove,
            small: true,
            onTap: () {
              if (exercise.durationSeconds > 5) {
                onDurationChanged(exercise.durationSeconds - 5);
              }
            },
          ),
          SizedBox(
            width: 44,
            child: Center(
              child: Text(
                '${exercise.durationSeconds}s',
                style: const TextStyle(
                  fontFamily: AppTypography.fontFamily,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: AppColors.darkTextPrimary,
                ),
              ),
            ),
          ),
          _StepperButton(
            icon: Icons.add,
            small: true,
            onTap: () => onDurationChanged(exercise.durationSeconds + 5),
          ),

          // Remove button
          if (onRemove != null) ...[
            const SizedBox(width: 8),
            GestureDetector(
              onTap: onRemove,
              child: const Icon(
                Icons.close,
                size: 18,
                color: AppColors.darkTextSecondary,
              ),
            ),
          ],
        ],
      ),
    );
  }

  void _editName(BuildContext context) {
    final controller = TextEditingController(text: exercise.name);
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.darkSurface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text(
          'Nome esercizio',
          style: TextStyle(
            fontFamily: AppTypography.fontFamily,
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: AppColors.darkTextPrimary,
          ),
        ),
        content: TextField(
          controller: controller,
          autofocus: true,
          style: const TextStyle(
            fontFamily: AppTypography.fontFamily,
            fontSize: 16,
            color: AppColors.darkTextPrimary,
          ),
          decoration: const InputDecoration(
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: AppColors.darkBorder),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: AppColors.accent),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text(
              'Annulla',
              style: TextStyle(
                fontFamily: AppTypography.fontFamily,
                color: AppColors.darkTextSecondary,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              if (controller.text.trim().isNotEmpty) {
                onNameChanged(controller.text.trim());
              }
              Navigator.pop(ctx);
            },
            child: const Text(
              'Salva',
              style: TextStyle(
                fontFamily: AppTypography.fontFamily,
                fontWeight: FontWeight.w700,
                color: AppColors.accent,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Stepper button
// ---------------------------------------------------------------------------
class _StepperButton extends StatelessWidget {
  const _StepperButton({
    required this.icon,
    required this.onTap,
    this.small = false,
  });

  final IconData icon;
  final VoidCallback onTap;
  final bool small;

  @override
  Widget build(BuildContext context) {
    final size = small ? 28.0 : 36.0;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.darkSurfaceHigher,
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.05),
          ),
        ),
        child: Icon(
          icon,
          size: small ? 16 : 20,
          color: AppColors.darkTextPrimary,
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Model
// ---------------------------------------------------------------------------
class _TimerExercise {
  const _TimerExercise({required this.name, required this.durationSeconds});
  final String name;
  final int durationSeconds;
}
