import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../app/theme/app_widgets.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  static const _coverUrl =
      'https://images.unsplash.com/photo-1534438327276-14e5300c3a48?w=900&h=400&fit=crop';
  static const _avatarUrl =
      'https://images.unsplash.com/photo-1568602471122-7832951cc4c5?w=200&h=200&fit=crop&crop=face';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // ── Hero banner ──────────────────────────────────────────────
            SliverToBoxAdapter(
              child: _HeroHeader(coverUrl: _coverUrl, avatarUrl: _avatarUrl)
                  .animate()
                  .fadeIn(duration: 600.ms),
            ),

            // ── Stats row ────────────────────────────────────────────────
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
                child: const _StatsRow(),
              )
                  .animate()
                  .fadeIn(duration: 500.ms, delay: 120.ms)
                  .slideY(begin: 0.08, end: 0, curve: Curves.easeOutCubic),
            ),

            // ── Achievement badges ────────────────────────────────────────
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 28, 0, 0),
                child: const _AchievementsSection(),
              )
                  .animate()
                  .fadeIn(duration: 500.ms, delay: 220.ms)
                  .slideY(begin: 0.08, end: 0, curve: Curves.easeOutCubic),
            ),

            // ── Workout history ───────────────────────────────────────────
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 28, 20, 0),
                child: const _WorkoutHistory(),
              )
                  .animate()
                  .fadeIn(duration: 500.ms, delay: 320.ms)
                  .slideY(begin: 0.08, end: 0, curve: Curves.easeOutCubic),
            ),

            // ── Account settings ──────────────────────────────────────────
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 28, 20, 0),
                child: const _AccountSettings(),
              )
                  .animate()
                  .fadeIn(duration: 500.ms, delay: 420.ms)
                  .slideY(begin: 0.08, end: 0, curve: Curves.easeOutCubic),
            ),

            // ── Version ───────────────────────────────────────────────────
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 28),
                child: Center(
                  child: Text(
                    'Versione 1.0.0 (Build 1)',
                    style: TextStyle(
                      fontFamily: AppTypography.fontFamily,
                      fontSize: 12,
                      color: AppColors.darkTextTertiary.withValues(alpha: 0.4),
                    ),
                  ),
                ),
              ).animate().fadeIn(duration: 400.ms, delay: 500.ms),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Hero Header — cover fullwidth + overlapping avatar con glow
// ─────────────────────────────────────────────────────────────────────────────
class _HeroHeader extends StatelessWidget {
  const _HeroHeader({required this.coverUrl, required this.avatarUrl});
  final String coverUrl;
  final String avatarUrl;

  @override
  Widget build(BuildContext context) {
    const coverH = 190.0;
    const avatarD = 100.0;
    const avatarR = avatarD / 2;

    return Column(
      children: [
        // ── Stack: cover + avatar che sfora in basso ─────────────────────
        SizedBox(
          height: coverH + avatarR, // spazio per il fuoristacco
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.topCenter,
            children: [
              // Cover image
              Positioned(
                top: 0, left: 0, right: 0,
                height: coverH,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    CachedNetworkImage(
                      imageUrl: coverUrl,
                      fit: BoxFit.cover,
                      placeholder: (_, __) =>
                          Container(color: AppColors.darkSurfaceHigh),
                      errorWidget: (_, __, ___) =>
                          Container(color: AppColors.darkSurfaceHigh),
                    ),
                    // Gradiente bottom-to-black
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withValues(alpha: 0.80),
                          ],
                          stops: const [0.35, 1.0],
                        ),
                      ),
                    ),
                    // Bottone impostazioni top-right
                    Positioned(
                      top: 8, right: 8,
                      child: Material(
                        color: Colors.black.withValues(alpha: 0.35),
                        shape: const CircleBorder(),
                        child: InkWell(
                          customBorder: const CircleBorder(),
                          onTap: () {},
                          child: const SizedBox(
                            width: 40, height: 40,
                            child: Icon(
                              Icons.settings_outlined,
                              color: Colors.white, size: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Avatar centrato, parte inferiore esce dallo Stack
              Positioned(
                bottom: 0,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    // Glow ring esterno
                    Container(
                      width: avatarD + 12,
                      height: avatarD + 12,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.accent.withValues(alpha: 0.35),
                            blurRadius: 24,
                            spreadRadius: 4,
                          ),
                        ],
                      ),
                    ),
                    // Avatar border + photo
                    Positioned(
                      left: 6, top: 6,
                      child: Container(
                        width: avatarD,
                        height: avatarD,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColors.accent, width: 3,
                          ),
                          color: AppColors.darkSurfaceHigh,
                        ),
                        child: ClipOval(
                          child: CachedNetworkImage(
                            imageUrl: avatarUrl,
                            fit: BoxFit.cover,
                            placeholder: (_, __) => Container(
                              color: AppColors.darkSurfaceHigh,
                              child: const Icon(
                                Icons.person,
                                color: AppColors.darkTextSecondary,
                                size: 44,
                              ),
                            ),
                            errorWidget: (_, __, ___) => Container(
                              color: AppColors.darkSurfaceHigh,
                              child: const Icon(
                                Icons.person,
                                color: AppColors.darkTextSecondary,
                                size: 44,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    // PRO badge bottom-right
                    Positioned(
                      bottom: 6, right: 2,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.accent,
                          borderRadius: BorderRadius.circular(999),
                          border: Border.all(color: Colors.black, width: 1.5),
                        ),
                        child: const Text(
                          'PRO',
                          style: TextStyle(
                            fontFamily: AppTypography.fontFamily,
                            fontSize: 10,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 0.8,
                            color: AppColors.textOnAccent,
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

        // ── Nome + titolo ─────────────────────────────────────────────────
        const SizedBox(height: 14),
        const Text(
          'Marco Rossi',
          style: TextStyle(
            fontFamily: AppTypography.fontFamily,
            fontSize: 26,
            fontWeight: FontWeight.w900,
            color: AppColors.darkTextPrimary,
            letterSpacing: -0.3,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          'HYBRIDCREW ELITE',
          style: TextStyle(
            fontFamily: AppTypography.fontFamily,
            fontSize: 12,
            fontWeight: FontWeight.w700,
            letterSpacing: 2.0,
            color: AppColors.darkTextSecondary.withValues(alpha: 0.45),
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Stats Row — 4 metriche con icone colorate
// ─────────────────────────────────────────────────────────────────────────────
class _StatsRow extends StatelessWidget {
  const _StatsRow();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _StatTile(value: '142', label: 'SESSIONI'),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _StatTile(value: '12', label: 'STREAK'),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _StatTile(value: '86h', label: 'ORE'),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _StatTile(value: 'Lv 2', label: 'LIVELLO'),
        ),
      ],
    );
  }
}

class _StatTile extends StatelessWidget {
  const _StatTile({
    required this.value,
    required this.label,
  });
  final String value, label;

  @override
  Widget build(BuildContext context) {
    return SurfaceCard(
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 10),
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              fontFamily: AppTypography.fontFamily,
              fontSize: value.length > 3 ? 20 : 26,
              fontWeight: FontWeight.w900,
              color: AppColors.darkTextPrimary,
              letterSpacing: -0.5,
              height: 1.0,
            ),
          ),
          const SizedBox(height: 6),
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

// ─────────────────────────────────────────────────────────────────────────────
// Achievement Badges — horizontal scrollable con scala entrata staggered
// ─────────────────────────────────────────────────────────────────────────────
class _AchievementsSection extends StatelessWidget {
  const _AchievementsSection();

  static const _badges = [
    _BadgeData(label: '12 giorni streak', emoji: '🔥'),
    _BadgeData(label: '100 sessioni', emoji: '💪'),
    _BadgeData(label: 'HIIT Master', emoji: '⚡'),
    _BadgeData(label: 'Maratoneta', emoji: '🏃'),
    _BadgeData(label: 'Powerlifter', emoji: '🏋️'),
    _BadgeData(label: 'Early Bird', emoji: '☀️'),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'TRAGUARDI',
                style: TextStyle(
                  fontFamily: AppTypography.fontFamily,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.5,
                  color: AppColors.darkTextSecondary.withValues(alpha: 0.55),
                ),
              ),
              Text(
                '6/12',
                style: const TextStyle(
                  fontFamily: AppTypography.fontFamily,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: AppColors.accent,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 48,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(right: 20),
            itemCount: _badges.length,
            separatorBuilder: (_, __) => const SizedBox(width: 8),
            itemBuilder: (_, i) {
              return _BadgeChip(data: _badges[i])
                  .animate(delay: (80 + i * 55).ms)
                  .fadeIn(duration: 400.ms)
                  .slideX(
                    begin: 0.08,
                    end: 0,
                    duration: 380.ms,
                    curve: Curves.easeOutCubic,
                  );
            },
          ),
        ),
      ],
    );
  }
}

class _BadgeChip extends StatelessWidget {
  const _BadgeChip({required this.data});
  final _BadgeData data;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.accent.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: AppColors.accent.withValues(alpha: 0.15),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(data.emoji, style: const TextStyle(fontSize: 16)),
          const SizedBox(width: 8),
          Text(
            data.label,
            style: const TextStyle(
              fontFamily: AppTypography.fontFamily,
              fontSize: 13,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.2,
              color: AppColors.darkTextPrimary,
            ),
          ),
        ],
      ),
    );
  }
}

class _BadgeData {
  const _BadgeData({
    required this.label,
    required this.emoji,
  });
  final String label;
  final String emoji;
}

// ─────────────────────────────────────────────────────────────────────────────
// Workout History — con thumbnail CachedNetworkImage + duration tag colorato
// ─────────────────────────────────────────────────────────────────────────────
class _WorkoutHistory extends StatelessWidget {
  const _WorkoutHistory();

  static const _items = [
    _HistoryData(
      title: 'Upper Body Power',
      subtitle: 'Oggi, 18:30',
      duration: '45 min',
      imageUrl:
          'https://images.unsplash.com/photo-1581009146145-b5ef050c2e1e?w=160&h=160&fit=crop',
    ),
    _HistoryData(
      title: 'HIIT Cardio',
      subtitle: 'Ieri, 07:15',
      duration: '30 min',
      imageUrl:
          'https://images.unsplash.com/photo-1434596922112-19c563067271?w=160&h=160&fit=crop',
    ),
    _HistoryData(
      title: 'Leg Day',
      subtitle: '12 Feb, 19:00',
      duration: '60 min',
      imageUrl:
          'https://images.unsplash.com/photo-1434608519344-49d77a699e1d?w=160&h=160&fit=crop',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'STORICO ALLENAMENTI',
              style: TextStyle(
                fontFamily: AppTypography.fontFamily,
                fontSize: 12,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.5,
                color: AppColors.darkTextSecondary.withValues(alpha: 0.55),
              ),
            ),
            const Text(
              'Vedi tutti',
              style: TextStyle(
                fontFamily: AppTypography.fontFamily,
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppColors.accent,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        ..._items.asMap().entries.map((e) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: _HistoryRow(data: e.value)
                .animate(delay: (60 + e.key * 70).ms)
                .fadeIn(duration: 380.ms)
                .slideX(begin: 0.04, end: 0, curve: Curves.easeOutCubic),
          );
        }),
      ],
    );
  }
}

class _HistoryRow extends StatelessWidget {
  const _HistoryRow({required this.data});
  final _HistoryData data;

  @override
  Widget build(BuildContext context) {
    return SurfaceCard(
      padding: const EdgeInsets.all(14),
      child: Row(
        children: [
          // Thumbnail
          Container(
            width: 58,
            height: 58,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              color: AppColors.darkSurfaceHigher,
            ),
            clipBehavior: Clip.antiAlias,
            child: CachedNetworkImage(
              imageUrl: data.imageUrl,
              fit: BoxFit.cover,
              placeholder: (_, __) =>
                  Container(color: AppColors.darkSurfaceHigher),
              errorWidget: (_, __, ___) =>
                  Container(color: AppColors.darkSurfaceHigher),
            ),
          ),
          const SizedBox(width: 14),
          // Testo
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
                const SizedBox(height: 4),
                Text(
                  data.subtitle,
                  style: TextStyle(
                    fontFamily: AppTypography.fontFamily,
                    fontSize: 13,
                    color: Colors.white.withValues(alpha: 0.4),
                  ),
                ),
              ],
            ),
          ),
          // Duration tag
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

class _HistoryData {
  const _HistoryData({
    required this.title,
    required this.subtitle,
    required this.duration,
    required this.imageUrl,
  });
  final String title, subtitle, duration, imageUrl;
}

// ─────────────────────────────────────────────────────────────────────────────
// Account Settings
// ─────────────────────────────────────────────────────────────────────────────
class _AccountSettings extends StatelessWidget {
  const _AccountSettings();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'ACCOUNT',
          style: TextStyle(
            fontFamily: AppTypography.fontFamily,
            fontSize: 12,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.5,
            color: AppColors.darkTextSecondary.withValues(alpha: 0.55),
          ),
        ),
        const SizedBox(height: 12),
        SurfaceCard(
          padding: EdgeInsets.zero,
          child: Column(
            children: [
              _SettingsRow(
                emoji: '👤',
                label: 'Modifica Profilo',
                onTap: () {},
              ),
              _RowDivider(),
              _SettingsRow(
                emoji: '🔔',
                label: 'Notifiche',
                onTap: () {},
              ),
              _RowDivider(),
              _SettingsRow(
                emoji: '⭐',
                label: 'Abbonamento',
                onTap: () {},
                trailing: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10, vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.accent.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    'PRO',
                    style: TextStyle(
                      fontFamily: AppTypography.fontFamily,
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                      color: AppColors.accent,
                    ),
                  ),
                ),
              ),
              _RowDivider(),
              _SettingsRow(
                emoji: '🚪',
                label: 'Esci',
                onTap: () {},
                isDestructive: true,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _SettingsRow extends StatelessWidget {
  const _SettingsRow({
    required this.emoji,
    required this.label,
    required this.onTap,
    this.trailing,
    this.isDestructive = false,
  });
  final String emoji;
  final String label;
  final VoidCallback onTap;
  final Widget? trailing;
  final bool isDestructive;

  @override
  Widget build(BuildContext context) {
    final color =
        isDestructive ? AppColors.error : AppColors.darkTextPrimary;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 17),
        child: Row(
          children: [
            Text(emoji, style: const TextStyle(fontSize: 20)),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontFamily: AppTypography.fontFamily,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: color,
                ),
              ),
            ),
            if (trailing != null) ...[trailing!, const SizedBox(width: 6)],
            if (!isDestructive)
              Icon(
                Icons.chevron_right_rounded,
                size: 20,
                color: Colors.white.withValues(alpha: 0.2),
              ),
          ],
        ),
      ),
    );
  }
}

class _RowDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Container(
        height: 1,
        margin: const EdgeInsets.symmetric(horizontal: 18),
        color: Colors.white.withValues(alpha: 0.04),
      );
}
