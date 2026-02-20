import 'package:flutter/material.dart';
import '../../../../app/theme/app_colors.dart';

class ExerciseDetailScreen extends StatelessWidget {
  const ExerciseDetailScreen({super.key, required this.exerciseId});
  final String exerciseId;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('SQUAT'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Zona animazione Rive (placeholder)
            Container(
              width: double.infinity,
              height: 280,
              color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
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
                      color: isDark
                          ? AppColors.darkTextTertiary
                          : AppColors.lightTextTertiary,
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
                          color: isDark
                              ? AppColors.accentTintDark
                              : AppColors.accentTintLight,
                          borderRadius: BorderRadius.circular(4),
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
                  ),
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
                              color: active
                                  ? AppColors.accent
                                  : isDark
                                      ? AppColors.darkSurfaceHigh
                                      : AppColors.lightSurfaceHigh,
                            ),
                          );
                        }),
                        const SizedBox(width: 8),
                        Text('Intermedio', style: theme.textTheme.bodyMedium),
                      ],
                    ),
                  ),

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
                  ),

                  const SizedBox(height: 16),

                  // Attrezzatura
                  _Section(
                    title: 'ATTREZZATURA',
                    child: Text('Corpo libero / Bilanciere',
                        style: theme.textTheme.bodyLarge),
                  ),

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
                  ),

                  const SizedBox(height: 24),
                ],
              ),
            ),
          ],
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
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkSurfaceHigh : AppColors.lightSurfaceHigh,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(
          color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontFamily: 'Inter',
          fontSize: 13,
          fontWeight: FontWeight.w500,
          color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
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
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 24,
            height: 24,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              color: AppColors.accent,
              shape: BoxShape.circle,
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
