import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_widgets.dart';

class ExerciseDetailScreen extends StatelessWidget {
  const ExerciseDetailScreen({super.key, required this.exerciseId});
  final String exerciseId;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('SQUAT'),
      ),
      body: ScaffoldGradientBackground(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Zona animazione Rive (placeholder)
              Container(
                width: double.infinity,
                height: 280,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      AppColors.darkSurfaceHigh,
                      AppColors.darkBackground,
                    ],
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.accessibility_new,
                      size: 80,
                      color: AppColors.accent,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'ANIMAZIONE RIVE',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppColors.darkTextTertiary,
                        letterSpacing: 1.5,
                      ),
                    ),
                    Text(
                      '(da integrare)',
                      style: theme.textTheme.bodySmall,
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Nome + Categoria
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text('Squat', style: theme.textTheme.headlineLarge),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: AppColors.glassSurface,
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(
                              color: AppColors.accent.withValues(alpha: 0.4),
                            ),
                          ),
                          child: const Text(
                            'FORZA',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              color: AppColors.accent,
                            ),
                          ),
                        ),
                      ],
                    ).animate().fadeIn(duration: 500.ms).slideY(begin: 0.1, end: 0),
                    const SizedBox(height: 16),

                    // Difficoltà
                    _Section(
                      title: 'DIFFICOLTÀ',
                      child: Row(
                        children: [
                          ...List.generate(3, (i) {
                            final active = i < 2;
                            return Container(
                              width: 28,
                              height: 8,
                              margin: const EdgeInsets.only(right: 6),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(999),
                                gradient: active
                                    ? const LinearGradient(colors: AppColors.accentGradient)
                                    : null,
                                color: active ? null : AppColors.darkSurfaceHigh,
                                boxShadow: active
                                    ? [
                                        BoxShadow(
                                          color: AppColors.accent.withValues(alpha: 0.3),
                                          blurRadius: 6,
                                        ),
                                      ]
                                    : null,
                              ),
                            );
                          }),
                          const SizedBox(width: 8),
                          Text('Intermedio', style: theme.textTheme.bodyMedium),
                        ],
                      ),
                    ).animate().fadeIn(duration: 500.ms, delay: 100.ms).slideY(begin: 0.1, end: 0),

                    const SizedBox(height: 16),

                    // Muscoli
                    _Section(
                      title: 'MUSCOLI COINVOLTI',
                      child: Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: ['Quadricipiti', 'Glutei', 'Femorali', 'Core']
                            .map((m) => _MuscleChip(label: m))
                            .toList(),
                      ),
                    ).animate().fadeIn(duration: 500.ms, delay: 200.ms).slideY(begin: 0.1, end: 0),

                    const SizedBox(height: 16),

                    // Attrezzatura
                    _Section(
                      title: 'ATTREZZATURA',
                      child: Text('Corpo libero / Bilanciere',
                          style: theme.textTheme.bodyLarge),
                    ).animate().fadeIn(duration: 500.ms, delay: 300.ms),

                    const SizedBox(height: 16),

                    // Istruzioni
                    _Section(
                      title: 'COME ESEGUIRE',
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _Step(number: 1, text: 'Posiziona i piedi alla larghezza delle spalle, punte leggermente verso l\'esterno.'),
                          _Step(number: 2, text: 'Mantieni il petto alto, la schiena dritta e il core attivo.'),
                          _Step(number: 3, text: 'Scendi piegando le ginocchia finché le cosce non sono parallele al suolo.'),
                          _Step(number: 4, text: 'Risali spingendo con i talloni, mantenendo le ginocchia allineate con i piedi.'),
                        ],
                      ),
                    ).animate().fadeIn(duration: 500.ms, delay: 400.ms).slideY(begin: 0.1, end: 0),

                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Section extends StatelessWidget {
  const _Section({required this.title, required this.child});
  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.w700,
                letterSpacing: 1.2,
              ),
        ),
        const SizedBox(height: 8),
        child,
      ],
    );
  }
}

class _MuscleChip extends StatelessWidget {
  const _MuscleChip({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.glassSurface,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: AppColors.glassBorderSubtle, width: 0.5),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontFamily: 'Inter',
          fontSize: 13,
          fontWeight: FontWeight.w500,
          color: AppColors.darkTextPrimary,
        ),
      ),
    );
  }
}

class _Step extends StatelessWidget {
  const _Step({required this.number, required this.text});
  final int number;
  final String text;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 24,
            height: 24,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              gradient: const LinearGradient(colors: AppColors.accentGradient),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppColors.accent.withValues(alpha: 0.3),
                  blurRadius: 8,
                ),
              ],
            ),
            child: Text(
              '$number',
              style: const TextStyle(
                fontFamily: 'Inter',
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: AppColors.textOnAccent,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(child: Text(text, style: theme.textTheme.bodyLarge)),
        ],
      ),
    );
  }
}
