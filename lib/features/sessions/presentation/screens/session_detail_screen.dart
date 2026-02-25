import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';

class SessionDetailScreen extends StatelessWidget {
  const SessionDetailScreen({super.key, required this.sessionId});
  final String sessionId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Main content
          SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 100),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Hero Image with video-style controls ──
                const _HeroSection()
                    .animate()
                    .fadeIn(duration: 500.ms),

                // ── Title + Equipment chip ──
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'WELCOME\nWORKOUT',
                        style: TextStyle(
                          fontFamily: AppTypography.fontFamily,
                          fontSize: 32,
                          fontWeight: FontWeight.w900,
                          color: AppColors.darkTextPrimary,
                          height: 1.05,
                          letterSpacing: 0.5,
                        ),
                      ),
                      const SizedBox(height: 14),
                      // Equipment chip
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                        decoration: BoxDecoration(
                          color: AppColors.darkSurfaceHigh,
                          borderRadius: BorderRadius.circular(999),
                          border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
                        ),
                        child: const Text(
                          'Dumbbells',
                          style: TextStyle(
                            fontFamily: AppTypography.fontFamily,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: AppColors.darkTextPrimary,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
                    .animate()
                    .fadeIn(duration: 400.ms, delay: 100.ms)
                    .slideY(begin: 0.05, end: 0),

                const SizedBox(height: 24),

                // ── Action Row: Save, Schedule, Share, Download ──
                const _ActionRow()
                    .animate()
                    .fadeIn(duration: 400.ms, delay: 200.ms),

                const SizedBox(height: 28),

                // ── Divider ──
                Container(
                  height: 1,
                  margin: const EdgeInsets.symmetric(horizontal: 24),
                  color: Colors.white.withValues(alpha: 0.06),
                ),

                const SizedBox(height: 24),

                // ── Stats: Total Time + Active Time ──
                const _StatsRow()
                    .animate()
                    .fadeIn(duration: 400.ms, delay: 300.ms)
                    .slideY(begin: 0.04, end: 0),

                const SizedBox(height: 28),

                // ── Divider ──
                Container(
                  height: 1,
                  margin: const EdgeInsets.symmetric(horizontal: 24),
                  color: Colors.white.withValues(alpha: 0.06),
                ),

                const SizedBox(height: 24),

                // ── Coach Section ──
                const _CoachSection()
                    .animate()
                    .fadeIn(duration: 400.ms, delay: 400.ms)
                    .slideY(begin: 0.04, end: 0),

                const SizedBox(height: 24),

                // ── Workout Exercises Preview ──
                const _ExercisesPreview()
                    .animate()
                    .fadeIn(duration: 400.ms, delay: 500.ms)
                    .slideY(begin: 0.04, end: 0),
              ],
            ),
          ),

          // ── Top bar: X close + settings ──
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top + 8,
                left: 16,
                right: 16,
                bottom: 8,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _CircleButton(
                    icon: Icons.close,
                    onTap: () => Navigator.of(context).pop(),
                  ),
                  _CircleButton(
                    icon: Icons.settings_outlined,
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ),

          // ── Sticky CTA bottom ──
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColors.darkBackground.withValues(alpha: 0.0),
                    AppColors.darkBackground.withValues(alpha: 0.9),
                    AppColors.darkBackground,
                  ],
                  stops: const [0.0, 0.4, 1.0],
                ),
              ),
              child: GestureDetector(
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: AppColors.accent,
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      content: const Row(
                        children: [
                          Icon(Icons.check_circle, color: AppColors.textOnAccent, size: 20),
                          SizedBox(width: 10),
                          Text(
                            'Workout avviato!',
                            style: TextStyle(
                              fontFamily: AppTypography.fontFamily,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textOnAccent,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  decoration: BoxDecoration(
                    color: AppColors.accent,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const Center(
                    child: Text(
                      'START WORKOUT',
                      style: TextStyle(
                        fontFamily: AppTypography.fontFamily,
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.8,
                        color: AppColors.textOnAccent,
                      ),
                    ),
                  ),
                ),
              ),
            )
                .animate()
                .fadeIn(duration: 500.ms, delay: 600.ms)
                .slideY(begin: 0.2, end: 0),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Circle Button (X / Settings)
// ---------------------------------------------------------------------------
class _CircleButton extends StatelessWidget {
  const _CircleButton({required this.icon, required this.onTap});
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 42,
        height: 42,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.black.withValues(alpha: 0.4),
          border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
        ),
        child: Icon(icon, color: Colors.white, size: 20),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Hero Section — image with play/replay/unmute controls overlay
// ---------------------------------------------------------------------------
class _HeroSection extends StatelessWidget {
  const _HeroSection();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 380,
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Background image
          CachedNetworkImage(
            imageUrl: 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=800&h=600&fit=crop&crop=face',
            fit: BoxFit.cover,
            placeholder: (_, __) => Container(color: AppColors.darkSurfaceHigh),
            errorWidget: (_, __, ___) => Container(
              color: AppColors.darkSurfaceHigh,
              child: const Icon(Icons.fitness_center, size: 60, color: AppColors.darkTextSecondary),
            ),
          ),
          // Gradient bottom
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withValues(alpha: 0.1),
                  Colors.black.withValues(alpha: 0.6),
                  AppColors.darkBackground,
                ],
                stops: const [0.2, 0.7, 1.0],
              ),
            ),
          ),
          // Play controls — centered
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _PlayControl(
                  icon: Icons.replay,
                  label: 'Replay',
                  onTap: () {},
                ),
                const SizedBox(width: 28),
                // Big play button
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: 72,
                    height: 72,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withValues(alpha: 0.2),
                      border: Border.all(color: Colors.white.withValues(alpha: 0.3), width: 2),
                    ),
                    child: const Icon(
                      Icons.play_arrow,
                      size: 36,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(width: 28),
                _PlayControl(
                  icon: Icons.volume_off,
                  label: 'Unmute',
                  onTap: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PlayControl extends StatelessWidget {
  const _PlayControl({
    required this.icon,
    required this.label,
    required this.onTap,
  });
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withValues(alpha: 0.15),
              border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
            ),
            child: Icon(icon, size: 22, color: Colors.white),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            style: TextStyle(
              fontFamily: AppTypography.fontFamily,
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Colors.white.withValues(alpha: 0.6),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Action Row — Save, Schedule, Share, Download
// ---------------------------------------------------------------------------
class _ActionRow extends StatelessWidget {
  const _ActionRow();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _ActionItem(icon: Icons.favorite_border, label: 'Save', onTap: () {}),
          _ActionItem(icon: Icons.calendar_today_outlined, label: 'Schedule', onTap: () {}),
          _ActionItem(icon: Icons.ios_share_outlined, label: 'Share', onTap: () {}),
          _ActionItem(icon: Icons.download_outlined, label: 'Download', onTap: () {}),
        ],
      ),
    );
  }
}

class _ActionItem extends StatelessWidget {
  const _ActionItem({
    required this.icon,
    required this.label,
    required this.onTap,
  });
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 26,
            color: Colors.white.withValues(alpha: 0.6),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            style: TextStyle(
              fontFamily: AppTypography.fontFamily,
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Colors.white.withValues(alpha: 0.5),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Stats Row — Total Time + Active Time
// ---------------------------------------------------------------------------
class _StatsRow extends StatelessWidget {
  const _StatsRow();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                Text(
                  '32 min',
                  style: TextStyle(
                    fontFamily: AppTypography.fontFamily,
                    fontSize: 28,
                    fontWeight: FontWeight.w900,
                    color: AppColors.accent,
                    height: 1.0,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Total Workout Time',
                  style: TextStyle(
                    fontFamily: AppTypography.fontFamily,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Colors.white.withValues(alpha: 0.45),
                  ),
                ),
              ],
            ),
          ),
          // Vertical divider
          Container(
            width: 1,
            height: 50,
            color: Colors.white.withValues(alpha: 0.08),
          ),
          Expanded(
            child: Column(
              children: [
                Text(
                  '18 min',
                  style: TextStyle(
                    fontFamily: AppTypography.fontFamily,
                    fontSize: 28,
                    fontWeight: FontWeight.w900,
                    color: AppColors.accent,
                    height: 1.0,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Active Workout Time',
                  style: TextStyle(
                    fontFamily: AppTypography.fontFamily,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Colors.white.withValues(alpha: 0.45),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Coach Section
// ---------------------------------------------------------------------------
class _CoachSection extends StatelessWidget {
  const _CoachSection();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.darkSurfaceHigh,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
        ),
        child: Row(
          children: [
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.darkSurfaceHigher,
                border: Border.all(color: AppColors.accent.withValues(alpha: 0.3), width: 2),
              ),
              clipBehavior: Clip.antiAlias,
              child: CachedNetworkImage(
                imageUrl: 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=120&h=120&fit=crop&crop=face',
                fit: BoxFit.cover,
                placeholder: (_, __) => const Icon(Icons.person, color: AppColors.darkTextSecondary, size: 24),
                errorWidget: (_, __, ___) => const Icon(Icons.person, color: AppColors.darkTextSecondary, size: 24),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'IL TUO COACH',
                    style: TextStyle(
                      fontFamily: AppTypography.fontFamily,
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.2,
                      color: Colors.white.withValues(alpha: 0.35),
                    ),
                  ),
                  const SizedBox(height: 3),
                  const Text(
                    'Coach Maia',
                    style: TextStyle(
                      fontFamily: AppTypography.fontFamily,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: AppColors.darkTextPrimary,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      const Icon(Icons.star, size: 13, color: AppColors.warning),
                      const SizedBox(width: 4),
                      Text(
                        '4.9  \u2022  Pilates x Strength',
                        style: TextStyle(
                          fontFamily: AppTypography.fontFamily,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Colors.white.withValues(alpha: 0.4),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.accent.withValues(alpha: 0.15),
              ),
              child: const Icon(Icons.chat_bubble_outline, size: 17, color: AppColors.accent),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Exercises Preview
// ---------------------------------------------------------------------------
class _ExercisesPreview extends StatelessWidget {
  const _ExercisesPreview();

  static const _exercises = [
    _ExData(name: 'Dumbbell Bench Press', sets: '4 x 12', imageUrl: 'https://images.unsplash.com/photo-1534368959876-26bf04f2c947?w=120&h=120&fit=crop'),
    _ExData(name: 'Lateral Raise', sets: '3 x 15', imageUrl: 'https://images.unsplash.com/photo-1581009146145-b5ef050c2e1e?w=120&h=120&fit=crop'),
    _ExData(name: 'Skull Crushers', sets: '3 x 12', imageUrl: 'https://images.unsplash.com/photo-1517963879433-6ad2b056d712?w=120&h=120&fit=crop'),
    _ExData(name: 'Bicep Curls', sets: '3 x 15', imageUrl: 'https://images.unsplash.com/photo-1534258936925-c58bed479fcb?w=120&h=120&fit=crop'),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'ESERCIZI',
                style: TextStyle(
                  fontFamily: AppTypography.fontFamily,
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.5,
                  color: AppColors.darkTextPrimary,
                ),
              ),
              Text(
                '${_exercises.length} esercizi',
                style: TextStyle(
                  fontFamily: AppTypography.fontFamily,
                  fontSize: 12,
                  color: Colors.white.withValues(alpha: 0.35),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ...List.generate(_exercises.length, (i) {
            final ex = _exercises[i];
            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.darkSurfaceHigh,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: Colors.white.withValues(alpha: 0.04)),
                ),
                child: Row(
                  children: [
                    // Number
                    Container(
                      width: 32,
                      height: 32,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.accent.withValues(alpha: 0.15),
                      ),
                      child: Text(
                        '${i + 1}',
                        style: const TextStyle(
                          fontFamily: AppTypography.fontFamily,
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                          color: AppColors.accent,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    // Thumbnail
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: AppColors.darkSurfaceHigher,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: CachedNetworkImage(
                        imageUrl: ex.imageUrl,
                        fit: BoxFit.cover,
                        placeholder: (_, __) => Container(color: AppColors.darkSurfaceHigher),
                        errorWidget: (_, __, ___) => const Icon(Icons.fitness_center, size: 20, color: AppColors.darkTextSecondary),
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            ex.name,
                            style: const TextStyle(
                              fontFamily: AppTypography.fontFamily,
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: AppColors.darkTextPrimary,
                            ),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            ex.sets,
                            style: TextStyle(
                              fontFamily: AppTypography.fontFamily,
                              fontSize: 13,
                              color: Colors.white.withValues(alpha: 0.4),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      Icons.chevron_right,
                      color: Colors.white.withValues(alpha: 0.2),
                      size: 22,
                    ),
                  ],
                ),
              )
                  .animate(delay: (i * 60).ms)
                  .fadeIn(duration: 300.ms)
                  .slideX(begin: 0.03, end: 0),
            );
          }),
        ],
      ),
    );
  }
}

class _ExData {
  const _ExData({required this.name, required this.sets, required this.imageUrl});
  final String name, sets, imageUrl;
}
