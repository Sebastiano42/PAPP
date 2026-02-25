import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../app/theme/app_widgets.dart';

class ActiveTimerScreen extends StatefulWidget {
  const ActiveTimerScreen({super.key});

  @override
  State<ActiveTimerScreen> createState() => _ActiveTimerScreenState();
}

class _ActiveTimerScreenState extends State<ActiveTimerScreen> {
  Timer? _timer;
  bool _isPaused = false;
  int _currentExerciseIndex = 0;
  int _currentSet = 1;
  int _secondsRemaining = 0;
  bool _isResting = false;

  // Workout data
  static const _exercises = [
    _WorkoutExercise(name: 'Jumping Jacks', muscle: 'Full Body', durationSec: 45, sets: 2, reps: 20, imageUrl: 'https://images.unsplash.com/photo-1601422407692-ec4eeec1d9b3?w=400&h=300&fit=crop'),
    _WorkoutExercise(name: 'Push-Up', muscle: 'Pettorali', durationSec: 40, sets: 3, reps: 12, imageUrl: 'https://images.unsplash.com/photo-1598971639058-fab3c3109a00?w=400&h=300&fit=crop'),
    _WorkoutExercise(name: 'Squat Jump', muscle: 'Gambe', durationSec: 45, sets: 3, reps: 15, imageUrl: 'https://images.unsplash.com/photo-1566241142559-40e1dab266c6?w=400&h=300&fit=crop'),
    _WorkoutExercise(name: 'Plank', muscle: 'Core', durationSec: 30, sets: 2, reps: 0, imageUrl: 'https://images.unsplash.com/photo-1571019614242-c5c5dee9f50b?w=400&h=300&fit=crop'),
    _WorkoutExercise(name: 'Burpees', muscle: 'Full Body', durationSec: 40, sets: 2, reps: 10, imageUrl: 'https://images.unsplash.com/photo-1434608519344-49d77a699e1d?w=400&h=300&fit=crop'),
    _WorkoutExercise(name: 'Mountain Climbers', muscle: 'Core', durationSec: 35, sets: 3, reps: 20, imageUrl: 'https://images.unsplash.com/photo-1517963879433-6ad2b056d712?w=400&h=300&fit=crop'),
    _WorkoutExercise(name: 'Lunges', muscle: 'Gambe', durationSec: 40, sets: 2, reps: 12, imageUrl: 'https://images.unsplash.com/photo-1534368959876-26bf04f2c947?w=400&h=300&fit=crop'),
    _WorkoutExercise(name: 'Shoulder Tap', muscle: 'Spalle', durationSec: 30, sets: 2, reps: 16, imageUrl: 'https://images.unsplash.com/photo-1581009146145-b5ef050c2e1e?w=400&h=300&fit=crop'),
  ];
  static const _restBetweenSets = 15;
  static const _restBetweenExercises = 30;

  _WorkoutExercise get _currentExercise => _exercises[_currentExerciseIndex];

  int get _totalSetsForCurrent => _currentExercise.sets;

  double get _sessionProgress {
    // Total phases: each exercise has N sets + rest phases between them
    int completedPhases = 0;
    int totalPhases = 0;
    for (int i = 0; i < _exercises.length; i++) {
      final ex = _exercises[i];
      totalPhases += ex.sets; // each set is a phase
      if (i < _currentExerciseIndex) {
        completedPhases += ex.sets;
      }
    }
    if (_currentExerciseIndex < _exercises.length) {
      completedPhases += _currentSet - 1;
    }
    return totalPhases > 0 ? completedPhases / totalPhases : 0;
  }

  @override
  void initState() {
    super.initState();
    _secondsRemaining = _currentExercise.durationSec;
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (_isPaused) return;
      if (_secondsRemaining > 0) {
        setState(() => _secondsRemaining--);
      } else {
        _onPhaseComplete();
      }
    });
  }

  void _onPhaseComplete() {
    if (_isResting) {
      // Rest finished — start next work phase
      setState(() {
        _isResting = false;
        _secondsRemaining = _currentExercise.durationSec;
      });
      return;
    }

    // Work phase finished
    if (_currentSet < _totalSetsForCurrent) {
      // More sets remaining — rest between sets
      setState(() {
        _currentSet++;
        _isResting = true;
        _secondsRemaining = _restBetweenSets;
      });
    } else if (_currentExerciseIndex < _exercises.length - 1) {
      // Next exercise — rest between exercises
      setState(() {
        _currentExerciseIndex++;
        _currentSet = 1;
        _isResting = true;
        _secondsRemaining = _restBetweenExercises;
      });
    } else {
      // Workout complete!
      _timer?.cancel();
      _showCompleteDialog();
    }
  }

  void _skipToNext() {
    if (_isResting) {
      // Skip rest
      setState(() {
        _isResting = false;
        _secondsRemaining = _currentExercise.durationSec;
      });
    } else if (_currentSet < _totalSetsForCurrent) {
      setState(() {
        _currentSet++;
        _isResting = true;
        _secondsRemaining = _restBetweenSets;
      });
    } else if (_currentExerciseIndex < _exercises.length - 1) {
      setState(() {
        _currentExerciseIndex++;
        _currentSet = 1;
        _secondsRemaining = _exercises[_currentExerciseIndex].durationSec;
        _isResting = false;
      });
    }
  }

  String get _timerDisplay {
    final m = (_secondsRemaining ~/ 60).toString().padLeft(2, '0');
    final s = (_secondsRemaining % 60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  @override
  Widget build(BuildContext context) {
    final exercise = _currentExercise;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Top bar with back button + session progress
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => _showStopDialog(context),
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
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Sessione in corso',
                              style: TextStyle(
                                fontFamily: AppTypography.fontFamily,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: AppColors.darkTextSecondary,
                              ),
                            ),
                            Text(
                              '${(_sessionProgress * 100).toInt()}%',
                              style: const TextStyle(
                                fontFamily: AppTypography.fontFamily,
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: AppColors.accent,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        ProgressBar(value: _sessionProgress),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const Spacer(flex: 1),

            // Status badge
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
              decoration: BoxDecoration(
                color: _isResting
                    ? AppColors.warning.withValues(alpha: 0.15)
                    : _isPaused
                        ? AppColors.darkSurfaceHigher
                        : AppColors.success.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(999),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _isResting
                          ? AppColors.warning
                          : _isPaused
                              ? AppColors.darkTextSecondary
                              : AppColors.success,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    _isResting ? 'RIPOSO' : _isPaused ? 'PAUSA' : 'ATTIVO',
                    style: TextStyle(
                      fontFamily: AppTypography.fontFamily,
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.0,
                      color: _isResting
                          ? AppColors.warning
                          : _isPaused
                              ? AppColors.darkTextSecondary
                              : AppColors.success,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Timer display
            Text(
              _timerDisplay,
              style: const TextStyle(
                fontFamily: AppTypography.fontFamily,
                fontSize: 80,
                fontWeight: FontWeight.w900,
                color: AppColors.accent,
                letterSpacing: -2,
                height: 1.0,
              ),
            ),

            const SizedBox(height: 8),

            // Exercise name
            Text(
              _isResting ? 'Riposo' : exercise.name,
              style: const TextStyle(
                fontFamily: AppTypography.fontFamily,
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: AppColors.darkTextPrimary,
              ),
            ),

            const SizedBox(height: 4),

            // Exercise counter
            Text(
              _isResting
                  ? 'Prossimo: ${_currentSet < _totalSetsForCurrent ? exercise.name : (_currentExerciseIndex < _exercises.length - 1 ? _exercises[_currentExerciseIndex + 1].name : 'Fine!')}'
                  : 'Esercizio ${_currentExerciseIndex + 1} di ${_exercises.length}',
              style: const TextStyle(
                fontFamily: AppTypography.fontFamily,
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: AppColors.darkTextSecondary,
              ),
            ),

            const SizedBox(height: 24),

            // Exercise image + muscle tag
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Container(
                height: 160,
                decoration: BoxDecoration(
                  color: AppColors.darkSurfaceHigh,
                  borderRadius: BorderRadius.circular(20),
                ),
                clipBehavior: Clip.antiAlias,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    CachedNetworkImage(
                      imageUrl: exercise.imageUrl,
                      fit: BoxFit.cover,
                      placeholder: (_, __) => Container(color: AppColors.darkSurfaceHigh),
                      errorWidget: (_, __, ___) => Container(
                        color: AppColors.darkSurfaceHigh,
                        child: Icon(
                          Icons.accessibility_new,
                          size: 80,
                          color: AppColors.darkTextSecondary.withValues(alpha: 0.2),
                        ),
                      ),
                    ),
                    // Dark overlay for readability
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.black.withValues(alpha: 0.1),
                            Colors.black.withValues(alpha: 0.6),
                          ],
                        ),
                      ),
                    ),
                    // Muscle tag
                    Positioned(
                      bottom: 12,
                      right: 12,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColors.accent.withValues(alpha: 0.85),
                          borderRadius: BorderRadius.circular(999),
                        ),
                        child: Text(
                          exercise.muscle,
                          style: const TextStyle(
                            fontFamily: AppTypography.fontFamily,
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textOnAccent,
                          ),
                        ),
                      ),
                    ),
                    // 3D icon overlay
                    Positioned(
                      top: 12,
                      right: 12,
                      child: Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.black.withValues(alpha: 0.4),
                        ),
                        child: const Icon(Icons.threed_rotation, size: 16, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // SET + REPS cards
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Row(
                children: [
                  Expanded(
                    child: SurfaceCard(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: Column(
                        children: [
                          const Text(
                            'SET',
                            style: TextStyle(
                              fontFamily: AppTypography.fontFamily,
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1.0,
                              color: AppColors.darkTextSecondary,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '$_currentSet DI $_totalSetsForCurrent',
                            style: const TextStyle(
                              fontFamily: AppTypography.fontFamily,
                              fontSize: 22,
                              fontWeight: FontWeight.w800,
                              color: AppColors.darkTextPrimary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: SurfaceCard(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: Column(
                        children: [
                          const Text(
                            'RIPETIZIONI',
                            style: TextStyle(
                              fontFamily: AppTypography.fontFamily,
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1.0,
                              color: AppColors.darkTextSecondary,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            exercise.reps > 0 ? '${exercise.reps}' : 'HOLD',
                            style: const TextStyle(
                              fontFamily: AppTypography.fontFamily,
                              fontSize: 22,
                              fontWeight: FontWeight.w800,
                              color: AppColors.darkTextPrimary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const Spacer(flex: 2),

            // Main control: wide pill PAUSE/PLAY button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: GestureDetector(
                onTap: () => setState(() => _isPaused = !_isPaused),
                child: Container(
                  width: double.infinity,
                  height: 60,
                  decoration: BoxDecoration(
                    color: AppColors.accent,
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        _isPaused ? Icons.play_arrow : Icons.pause,
                        color: AppColors.textOnAccent,
                        size: 28,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        _isPaused ? 'RIPRENDI' : 'PAUSA',
                        style: const TextStyle(
                          fontFamily: AppTypography.fontFamily,
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 1.0,
                          color: AppColors.textOnAccent,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Secondary controls: SKIP + STOP
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 60),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _SecondaryControl(
                    icon: Icons.skip_next,
                    label: 'SALTA',
                    onTap: _skipToNext,
                  ),
                  _SecondaryControl(
                    icon: Icons.stop,
                    label: 'STOP',
                    onTap: () => _showStopDialog(context),
                    isDestructive: true,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  void _showCompleteDialog() {
    _timer?.cancel();
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.darkSurface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Row(
          children: [
            Icon(Icons.emoji_events, color: AppColors.accent, size: 28),
            SizedBox(width: 12),
            Text(
              'Allenamento completato!',
              style: TextStyle(
                fontFamily: AppTypography.fontFamily,
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: AppColors.darkTextPrimary,
              ),
            ),
          ],
        ),
        content: Text(
          'Hai completato tutti ${_exercises.length} esercizi. Ottimo lavoro!',
          style: const TextStyle(
            fontFamily: AppTypography.fontFamily,
            fontSize: 14,
            color: AppColors.darkTextSecondary,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              context.go('/timer');
            },
            child: const Text(
              'Torna al Timer',
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

  void _showStopDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.darkSurface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text(
          'Terminare allenamento?',
          style: TextStyle(
            fontFamily: AppTypography.fontFamily,
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: AppColors.darkTextPrimary,
          ),
        ),
        content: const Text(
          'Il progresso corrente non verrà salvato.',
          style: TextStyle(
            fontFamily: AppTypography.fontFamily,
            fontSize: 14,
            color: AppColors.darkTextSecondary,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text(
              'Continua',
              style: TextStyle(
                fontFamily: AppTypography.fontFamily,
                fontWeight: FontWeight.w600,
                color: AppColors.darkTextSecondary,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              context.go('/timer');
            },
            child: const Text(
              'Termina',
              style: TextStyle(
                fontFamily: AppTypography.fontFamily,
                fontWeight: FontWeight.w700,
                color: AppColors.error,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Secondary control button
// ---------------------------------------------------------------------------
class _SecondaryControl extends StatelessWidget {
  const _SecondaryControl({
    required this.icon,
    required this.label,
    required this.onTap,
    this.isDestructive = false,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool isDestructive;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Column(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.darkSurfaceHigh,
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.05),
              ),
            ),
            child: Icon(
              icon,
              color: isDestructive
                  ? AppColors.error
                  : AppColors.darkTextPrimary,
              size: 22,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            style: TextStyle(
              fontFamily: AppTypography.fontFamily,
              fontSize: 10,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
              color: isDestructive
                  ? AppColors.error
                  : AppColors.darkTextSecondary,
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Workout exercise model
// ---------------------------------------------------------------------------
class _WorkoutExercise {
  const _WorkoutExercise({
    required this.name,
    required this.muscle,
    required this.durationSec,
    required this.sets,
    required this.reps,
    required this.imageUrl,
  });
  final String name;
  final String muscle;
  final int durationSec;
  final int sets;
  final int reps;
  final String imageUrl;
}
