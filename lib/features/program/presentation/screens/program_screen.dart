import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../app/router.dart';

/// Home screen — Ladder-inspired: avatar row, hero workout card, challenge bar
class ProgramScreen extends StatelessWidget {
  const ProgramScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            // ── Header: brand + notifica + avatar ──
            const _Header()
                .animate()
                .fadeIn(duration: 400.ms),

            // ── Avatar row — "Double Tap to send a cheer" ──
            const _AvatarRow()
                .animate()
                .fadeIn(duration: 500.ms, delay: 80.ms)
                .slideY(begin: 0.04, end: 0),

            const SizedBox(height: 20),

            // ── Hero Workout Card — big, immersive ──
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: const _HeroWorkoutCard(),
            )
                .animate()
                .fadeIn(duration: 600.ms, delay: 180.ms)
                .scale(
                  begin: const Offset(0.97, 0.97),
                  end: const Offset(1, 1),
                  duration: 500.ms,
                  curve: Curves.easeOut,
                ),

            const SizedBox(height: 16),

            // ── Challenge Progress Bar ──
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: const _ChallengeBar(),
            )
                .animate()
                .fadeIn(duration: 500.ms, delay: 350.ms)
                .slideY(begin: 0.04, end: 0),

            const SizedBox(height: 24),

            // ── Quick Stats Row ──
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: _QuickStatsRow(),
            )
                .animate()
                .fadeIn(duration: 500.ms, delay: 450.ms),

            const SizedBox(height: 24),

            // ── Upcoming Sessions Preview ──
            const _UpcomingSection()
                .animate()
                .fadeIn(duration: 500.ms, delay: 550.ms)
                .slideY(begin: 0.04, end: 0),

            const SizedBox(height: 24),

            // ── Recent Activity ──
            const _RecentActivity()
                .animate()
                .fadeIn(duration: 500.ms, delay: 650.ms)
                .slideY(begin: 0.04, end: 0),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Header — brand logo + notification + avatar
// ---------------------------------------------------------------------------
class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
      child: Row(
        children: [
          const Text(
            'H',
            style: TextStyle(
              fontFamily: AppTypography.fontFamily,
              fontSize: 26,
              fontWeight: FontWeight.w900,
              color: AppColors.accent,
            ),
          ),
          const SizedBox(width: 6),
          const Text(
            'HYBRIDCREW',
            style: TextStyle(
              fontFamily: AppTypography.fontFamily,
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: AppColors.darkTextPrimary,
              letterSpacing: 0.5,
            ),
          ),
          const Spacer(),
          // Notification bell
          GestureDetector(
            onTap: () {},
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.darkSurfaceHigh,
                border: Border.all(color: Colors.white.withValues(alpha: 0.06)),
              ),
              child: Stack(
                children: [
                  const Center(
                    child: Icon(Icons.notifications_outlined, color: AppColors.darkTextSecondary, size: 22),
                  ),
                  Positioned(
                    top: 9, right: 10,
                    child: Container(
                      width: 7, height: 7,
                      decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColors.accent),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 10),
          // Avatar
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColors.accent.withValues(alpha: 0.4),
                width: 2,
              ),
            ),
            child: ClipOval(
              child: CachedNetworkImage(
                imageUrl: 'https://images.unsplash.com/photo-1568602471122-7832951cc4c5?w=100&h=100&fit=crop&crop=face',
                fit: BoxFit.cover,
                placeholder: (_, __) => Container(
                  color: AppColors.darkSurfaceHigh,
                  child: const Icon(Icons.person, color: AppColors.darkTextSecondary, size: 20),
                ),
                errorWidget: (_, __, ___) => Container(
                  color: AppColors.darkSurfaceHigh,
                  child: const Icon(Icons.person, color: AppColors.darkTextSecondary, size: 20),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Avatar Row — horizontal team avatars like Ladder
// ---------------------------------------------------------------------------
class _AvatarRow extends StatelessWidget {
  const _AvatarRow();

  static const _teamAvatars = [
    'https://images.unsplash.com/photo-1568602471122-7832951cc4c5?w=80&h=80&fit=crop&crop=face',
    'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=80&h=80&fit=crop&crop=face',
    'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=80&h=80&fit=crop&crop=face',
    'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=80&h=80&fit=crop&crop=face',
    'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=80&h=80&fit=crop&crop=face',
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 4, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Avatars row
          SizedBox(
            height: 56,
            child: Row(
              children: [
                // Team avatars
                ...List.generate(_teamAvatars.length, (i) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: i == 0
                              ? AppColors.accent
                              : Colors.white.withValues(alpha: 0.1),
                          width: 2,
                        ),
                      ),
                      child: ClipOval(
                        child: CachedNetworkImage(
                          imageUrl: _teamAvatars[i],
                          fit: BoxFit.cover,
                          placeholder: (_, __) => Container(color: AppColors.darkSurfaceHigh),
                          errorWidget: (_, __, ___) => Container(
                            color: AppColors.darkSurfaceHigh,
                            child: const Icon(Icons.person, size: 20, color: AppColors.darkTextSecondary),
                          ),
                        ),
                      ),
                    ).animate(delay: (100 + i * 60).ms)
                        .fadeIn(duration: 300.ms)
                        .slideX(begin: 0.1, end: 0),
                  );
                }),
                // "+" button
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.darkSurfaceHigh,
                    border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
                  ),
                  child: Icon(
                    Icons.add,
                    color: Colors.white.withValues(alpha: 0.3),
                    size: 22,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Il tuo team  \u2022  Tocca per inviare un saluto',
            style: TextStyle(
              fontFamily: AppTypography.fontFamily,
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Colors.white.withValues(alpha: 0.35),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Hero Workout Card — Ladder style: big image, bold title, dual CTAs
// ---------------------------------------------------------------------------
class _HeroWorkoutCard extends StatelessWidget {
  const _HeroWorkoutCard();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.go('/sessions/1'),
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: AppColors.darkSurfaceHigh,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero image
            SizedBox(
              height: 320,
              width: double.infinity,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  CachedNetworkImage(
                    imageUrl: 'https://images.unsplash.com/photo-1534438327276-14e5300c3a48?w=800&h=600&fit=crop',
                    fit: BoxFit.cover,
                    placeholder: (_, __) => Container(color: AppColors.darkSurfaceHigh),
                    errorWidget: (_, __, ___) => Container(
                      color: AppColors.darkSurfaceHigh,
                      child: const Center(child: Icon(Icons.fitness_center, color: AppColors.darkTextSecondary, size: 48)),
                    ),
                  ),
                  // Gradient
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withValues(alpha: 0.1),
                          Colors.black.withValues(alpha: 0.85),
                        ],
                        stops: const [0.3, 1.0],
                      ),
                    ),
                  ),
                  // Top badges
                  Positioned(
                    top: 16,
                    left: 16,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.5),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
                      ),
                      child: const Text(
                        'Vitality',
                        style: TextStyle(
                          fontFamily: AppTypography.fontFamily,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 16,
                    right: 16,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: AppColors.accent,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text(
                        'Match #1',
                        style: TextStyle(
                          fontFamily: AppTypography.fontFamily,
                          fontSize: 12,
                          fontWeight: FontWeight.w800,
                          color: AppColors.textOnAccent,
                        ),
                      ),
                    ),
                  ),
                  // Bottom text overlay
                  Positioned(
                    bottom: 20,
                    left: 20,
                    right: 20,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'WELCOME\nWORKOUT',
                          style: TextStyle(
                            fontFamily: AppTypography.fontFamily,
                            fontSize: 34,
                            fontWeight: FontWeight.w900,
                            color: Colors.white,
                            height: 1.0,
                            letterSpacing: 0.5,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Elevate your physique and life with\nminimal equipment Strength Training',
                          style: TextStyle(
                            fontFamily: AppTypography.fontFamily,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Colors.white.withValues(alpha: 0.65),
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Dual CTA buttons
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
              child: Row(
                children: [
                  Expanded(
                    child: _OutlineButton(
                      label: 'SET REMINDER',
                      onTap: () {},
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      decoration: BoxDecoration(
                        color: AppColors.accent,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Center(
                        child: Text(
                          'PREVIEW',
                          style: TextStyle(
                            fontFamily: AppTypography.fontFamily,
                            fontSize: 14,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 0.5,
                            color: AppColors.textOnAccent,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OutlineButton extends StatelessWidget {
  const _OutlineButton({required this.label, required this.onTap});
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: AppColors.darkSurfaceHigher,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
        ),
        child: Center(
          child: Text(
            label,
            style: const TextStyle(
              fontFamily: AppTypography.fontFamily,
              fontSize: 14,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.5,
              color: AppColors.darkTextPrimary,
            ),
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Challenge Bar — progress challenge like Ladder
// ---------------------------------------------------------------------------
class _ChallengeBar extends StatelessWidget {
  const _ChallengeBar();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.darkSurfaceHigh,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white.withValues(alpha: 0.06)),
        ),
        child: Row(
          children: [
            // Progress ring mini
            SizedBox(
              width: 42,
              height: 42,
              child: Stack(
                children: [
                  CircularProgressIndicator(
                    value: 0.10,
                    strokeWidth: 4,
                    backgroundColor: AppColors.darkSurfaceHigher,
                    valueColor: const AlwaysStoppedAnimation<Color>(AppColors.accent),
                    strokeCap: StrokeCap.round,
                  ),
                  Center(
                    child: Text(
                      '10%',
                      style: TextStyle(
                        fontFamily: AppTypography.fontFamily,
                        fontSize: 10,
                        fontWeight: FontWeight.w800,
                        color: AppColors.accent,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Get Started Challenge',
                    style: TextStyle(
                      fontFamily: AppTypography.fontFamily,
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: AppColors.darkTextPrimary,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    'Completa il piano per sbloccare il programma',
                    style: TextStyle(
                      fontFamily: AppTypography.fontFamily,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Colors.white.withValues(alpha: 0.4),
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: Colors.white.withValues(alpha: 0.25),
              size: 22,
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Quick Stats Row — 3 stat tiles
// ---------------------------------------------------------------------------
class _QuickStatsRow extends StatelessWidget {
  const _QuickStatsRow();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _QuickStatTile(
            value: '3',
            label: 'SESSIONI',
            icon: Icons.fitness_center,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _QuickStatTile(
            value: '1.8k',
            label: 'KCAL',
            icon: Icons.local_fire_department_outlined,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _QuickStatTile(
            value: '4h',
            label: 'TEMPO',
            icon: Icons.schedule,
          ),
        ),
      ],
    );
  }
}

class _QuickStatTile extends StatelessWidget {
  const _QuickStatTile({
    required this.value,
    required this.label,
    required this.icon,
  });
  final String value, label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.darkSurfaceHigh,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
      ),
      child: Column(
        children: [
          Icon(icon, size: 20, color: AppColors.accent),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontFamily: AppTypography.fontFamily,
              fontSize: 24,
              fontWeight: FontWeight.w900,
              color: AppColors.darkTextPrimary,
              height: 1.0,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontFamily: AppTypography.fontFamily,
              fontSize: 10,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.0,
              color: Colors.white.withValues(alpha: 0.35),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Upcoming Sessions — horizontal preview cards
// ---------------------------------------------------------------------------
class _UpcomingSection extends StatelessWidget {
  const _UpcomingSection();

  static const _items = [
    _UpcomingData(
      title: 'Upper Body Blast',
      time: '18:00',
      coach: 'Coach Marco',
      imageUrl: 'https://images.unsplash.com/photo-1581009146145-b5ef050c2e1e?w=300&h=200&fit=crop',
    ),
    _UpcomingData(
      title: 'HIIT Cardio',
      time: '19:30',
      coach: 'Coach Sara',
      imageUrl: 'https://images.unsplash.com/photo-1534258936925-c58bed479fcb?w=300&h=200&fit=crop',
    ),
    _UpcomingData(
      title: 'Endurance Run',
      time: '07:00',
      coach: 'Coach Luca',
      imageUrl: 'https://images.unsplash.com/photo-1571019614242-c5c5dee9f50b?w=300&h=200&fit=crop',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'PROSSIME SESSIONI',
                style: TextStyle(
                  fontFamily: AppTypography.fontFamily,
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.5,
                  color: AppColors.darkTextPrimary,
                ),
              ),
              GestureDetector(
                onTap: () => context.go(AppRoutes.sessions),
                child: const Text(
                  'Vedi tutte',
                  style: TextStyle(
                    fontFamily: AppTypography.fontFamily,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppColors.accent,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 180,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemCount: _items.length,
            itemBuilder: (context, i) {
              final item = _items[i];
              return _UpcomingCard(data: item)
                  .animate(delay: (i * 80).ms)
                  .fadeIn(duration: 400.ms)
                  .slideX(begin: 0.06, end: 0);
            },
          ),
        ),
      ],
    );
  }
}

class _UpcomingCard extends StatelessWidget {
  const _UpcomingCard({required this.data});
  final _UpcomingData data;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.go('/sessions/1'),
      child: Container(
        width: 220,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: AppColors.darkSurfaceHigh,
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            CachedNetworkImage(
              imageUrl: data.imageUrl,
              fit: BoxFit.cover,
              placeholder: (_, __) => Container(color: AppColors.darkSurfaceHigh),
              errorWidget: (_, __, ___) => Container(color: AppColors.darkSurfaceHigh),
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withValues(alpha: 0.05),
                    Colors.black.withValues(alpha: 0.8),
                  ],
                  stops: const [0.3, 1.0],
                ),
              ),
            ),
            Positioned(
              top: 12,
              right: 12,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.accent,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  data.time,
                  style: const TextStyle(
                    fontFamily: AppTypography.fontFamily,
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                    color: AppColors.textOnAccent,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 14,
              left: 14,
              right: 14,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data.title.toUpperCase(),
                    style: const TextStyle(
                      fontFamily: AppTypography.fontFamily,
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                      height: 1.1,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    data.coach,
                    style: TextStyle(
                      fontFamily: AppTypography.fontFamily,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Colors.white.withValues(alpha: 0.55),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _UpcomingData {
  const _UpcomingData({
    required this.title,
    required this.time,
    required this.coach,
    required this.imageUrl,
  });
  final String title, time, coach, imageUrl;
}

// ---------------------------------------------------------------------------
// Recent Activity — last 3 workouts
// ---------------------------------------------------------------------------
class _RecentActivity extends StatelessWidget {
  const _RecentActivity();

  static const _items = [
    _ActivityData(
      title: 'Upper Body Power',
      subtitle: 'Oggi, 18:30',
      duration: '45 min',
      imageUrl: 'https://images.unsplash.com/photo-1581009146145-b5ef050c2e1e?w=160&h=160&fit=crop',
    ),
    _ActivityData(
      title: 'HIIT Cardio',
      subtitle: 'Ieri, 07:15',
      duration: '30 min',
      imageUrl: 'https://images.unsplash.com/photo-1434596922112-19c563067271?w=160&h=160&fit=crop',
    ),
    _ActivityData(
      title: 'Leg Day',
      subtitle: '12 Feb, 19:00',
      duration: '60 min',
      imageUrl: 'https://images.unsplash.com/photo-1434608519344-49d77a699e1d?w=160&h=160&fit=crop',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'ATTIVITÀ RECENTE',
                style: TextStyle(
                  fontFamily: AppTypography.fontFamily,
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.5,
                  color: AppColors.darkTextPrimary,
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: const Text(
                  'Vedi tutte',
                  style: TextStyle(
                    fontFamily: AppTypography.fontFamily,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppColors.accent,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ..._items.asMap().entries.map((entry) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: _ActivityRow(data: entry.value)
                  .animate(delay: (entry.key * 60).ms)
                  .fadeIn(duration: 350.ms)
                  .slideX(begin: 0.03, end: 0),
            );
          }),
        ],
      ),
    );
  }
}

class _ActivityRow extends StatelessWidget {
  const _ActivityRow({required this.data});
  final _ActivityData data;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.darkSurfaceHigh,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.white.withValues(alpha: 0.04)),
      ),
      child: Row(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: AppColors.darkSurfaceHigher,
              borderRadius: BorderRadius.circular(10),
            ),
            clipBehavior: Clip.antiAlias,
            child: CachedNetworkImage(
              imageUrl: data.imageUrl,
              fit: BoxFit.cover,
              placeholder: (_, __) => Container(color: AppColors.darkSurfaceHigher),
              errorWidget: (_, __, ___) => const Icon(Icons.fitness_center, color: AppColors.darkTextSecondary, size: 22),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.title,
                  style: const TextStyle(
                    fontFamily: AppTypography.fontFamily,
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: AppColors.darkTextPrimary,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  data.subtitle,
                  style: TextStyle(
                    fontFamily: AppTypography.fontFamily,
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    color: Colors.white.withValues(alpha: 0.4),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.accent.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              data.duration,
              style: const TextStyle(
                fontFamily: AppTypography.fontFamily,
                fontSize: 13,
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

class _ActivityData {
  const _ActivityData({
    required this.title,
    required this.subtitle,
    required this.duration,
    required this.imageUrl,
  });
  final String title, subtitle, duration, imageUrl;
}
