import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../app/theme/app_widgets.dart';

// ─────────────────────────────────────────────────────────────────────────────
// Progress Screen — stats.webp inspired: big ring, daily bar chart, overview
// ─────────────────────────────────────────────────────────────────────────────
class ProgressScreen extends StatefulWidget {
  const ProgressScreen({super.key});

  @override
  State<ProgressScreen> createState() => _ProgressScreenState();
}

class _ProgressScreenState extends State<ProgressScreen> {
  int _selectedPeriod = 0; // 0=Settimana, 1=Mese, 2=Anno

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            // Header
            _Header(
              selectedPeriod: _selectedPeriod,
              onPeriodChanged: (i) => setState(() => _selectedPeriod = i),
            ).animate().fadeIn(duration: 400.ms),

            // ── Big Ring — "TODAY MOVEs" ──
            const _TodayRingSection()
                .animate()
                .fadeIn(duration: 700.ms, delay: 80.ms)
                .scale(
                  begin: const Offset(0.92, 0.92),
                  end: const Offset(1, 1),
                  duration: 600.ms,
                  curve: Curves.easeOutBack,
                ),

            const SizedBox(height: 20),

            // ── Stats under ring: To Next Level / From Yesterday ──
            const _SubStats()
                .animate()
                .fadeIn(duration: 500.ms, delay: 200.ms),

            const SizedBox(height: 28),

            // ── Daily Activity Bar Chart ──
            const _DailyBarChart()
                .animate()
                .fadeIn(duration: 500.ms, delay: 300.ms)
                .slideY(begin: 0.04, end: 0),

            const SizedBox(height: 28),

            // ── Overview Card: Moves + Length ──
            const _OverviewCard()
                .animate()
                .fadeIn(duration: 500.ms, delay: 400.ms)
                .slideY(begin: 0.04, end: 0),

            const SizedBox(height: 28),

            // ── Monthly Ring + Average Activity ──
            const _MonthlySection()
                .animate()
                .fadeIn(duration: 600.ms, delay: 500.ms)
                .scale(
                  begin: const Offset(0.95, 0.95),
                  end: const Offset(1, 1),
                  duration: 500.ms,
                  curve: Curves.easeOutBack,
                ),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Header
// ─────────────────────────────────────────────────────────────────────────────
class _Header extends StatelessWidget {
  const _Header({required this.selectedPeriod, required this.onPeriodChanged});
  final int selectedPeriod;
  final ValueChanged<int> onPeriodChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 16, 24, 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'PROGRESSI',
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
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.darkSurfaceHigh,
                  border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
                ),
                child: const Icon(Icons.tune, color: AppColors.darkTextSecondary, size: 20),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: HChipBar(
            chips: const [
              HChipItem(label: 'Settimana'),
              HChipItem(label: 'Mese'),
              HChipItem(label: 'Anno'),
            ],
            selectedIndex: selectedPeriod,
            onSelected: onPeriodChanged,
            padding: const EdgeInsets.symmetric(horizontal: 24),
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Today Ring Section — big animated ring with "TODAY MOVEs" and number
// ─────────────────────────────────────────────────────────────────────────────
class _TodayRingSection extends StatefulWidget {
  const _TodayRingSection();

  @override
  State<_TodayRingSection> createState() => _TodayRingSectionState();
}

class _TodayRingSectionState extends State<_TodayRingSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _anim;

  static const int _todayMoves = 856;
  static const int _goalMoves = 1000;
  static const double _target = _todayMoves / _goalMoves;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 1800));
    _anim = CurvedAnimation(parent: _ctrl, curve: Curves.easeOutCubic);
    Future.delayed(500.ms, () {
      if (mounted) _ctrl.forward();
    });
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Small avatar on top
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.accent.withValues(alpha: 0.4), width: 2),
            color: AppColors.darkSurfaceHigh,
          ),
          child: ClipOval(
            child: Image.network(
              'https://images.unsplash.com/photo-1568602471122-7832951cc4c5?w=100&h=100&fit=crop&crop=face',
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => const Icon(Icons.person, color: AppColors.darkTextSecondary, size: 22),
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          '600',
          style: TextStyle(
            fontFamily: AppTypography.fontFamily,
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: Colors.white.withValues(alpha: 0.35),
          ),
        ),
        const SizedBox(height: 12),

        // Big ring
        AnimatedBuilder(
          animation: _anim,
          builder: (_, __) {
            final progress = _target * _anim.value;
            final moves = (_todayMoves * _anim.value).round();
            return SizedBox(
              width: 220,
              height: 220,
              child: CustomPaint(
                painter: _BigRingPainter(
                  progress: progress,
                  accentColor: AppColors.accent,
                  trackColor: AppColors.darkSurfaceHigher,
                ),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'TODAY MOVEs',
                        style: TextStyle(
                          fontFamily: AppTypography.fontFamily,
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1.5,
                          color: Colors.white.withValues(alpha: 0.4),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        '$moves',
                        style: const TextStyle(
                          fontFamily: AppTypography.fontFamily,
                          fontSize: 56,
                          fontWeight: FontWeight.w900,
                          color: AppColors.darkTextPrimary,
                          height: 1.0,
                          letterSpacing: -1,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

class _BigRingPainter extends CustomPainter {
  const _BigRingPainter({
    required this.progress,
    required this.accentColor,
    required this.trackColor,
  });
  final double progress;
  final Color accentColor;
  final Color trackColor;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - 24) / 2;
    const sw = 12.0;
    const startAngle = -pi / 2;
    final sweep = 2 * pi * progress;

    // Track
    canvas.drawCircle(
      center,
      radius,
      Paint()
        ..color = trackColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = sw
        ..strokeCap = StrokeCap.round,
    );

    if (progress <= 0) return;

    // Glow
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweep,
      false,
      Paint()
        ..color = accentColor.withValues(alpha: 0.25)
        ..style = PaintingStyle.stroke
        ..strokeWidth = sw + 8
        ..strokeCap = StrokeCap.round
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8),
    );

    // Main arc
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweep,
      false,
      Paint()
        ..color = accentColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = sw
        ..strokeCap = StrokeCap.round,
    );

    // Tip dot
    if (progress > 0.02) {
      final tipAngle = startAngle + sweep;
      final tipX = center.dx + radius * cos(tipAngle);
      final tipY = center.dy + radius * sin(tipAngle);
      canvas.drawCircle(
        Offset(tipX, tipY),
        4,
        Paint()..color = Colors.white..style = PaintingStyle.fill,
      );
    }
  }

  @override
  bool shouldRepaint(_BigRingPainter o) => o.progress != progress;
}

// ─────────────────────────────────────────────────────────────────────────────
// Sub Stats — To Next Level / From Yesterday
// ─────────────────────────────────────────────────────────────────────────────
class _SubStats extends StatelessWidget {
  const _SubStats();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 48),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              const Text(
                '144',
                style: TextStyle(
                  fontFamily: AppTypography.fontFamily,
                  fontSize: 28,
                  fontWeight: FontWeight.w900,
                  color: AppColors.darkTextPrimary,
                  height: 1.0,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'To Next Level',
                style: TextStyle(
                  fontFamily: AppTypography.fontFamily,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Colors.white.withValues(alpha: 0.4),
                ),
              ),
            ],
          ),
          Column(
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    '+64',
                    style: TextStyle(
                      fontFamily: AppTypography.fontFamily,
                      fontSize: 28,
                      fontWeight: FontWeight.w900,
                      color: AppColors.accent,
                      height: 1.0,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                'From Yesterday',
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
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Daily Bar Chart — "DAILY MOVEs" with vertical bars
// ─────────────────────────────────────────────────────────────────────────────
class _DailyBarChart extends StatelessWidget {
  const _DailyBarChart();

  // Mock daily data (Mon-Sun, values 0-100%)
  static const _values = [0.6, 0.8, 0.45, 0.9, 0.3, 0.7, 0.55, 0.4, 0.85, 0.6, 0.75, 0.5, 0.65, 0.9];

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
                'DAILY MOVEs',
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
                  'SEE ALL',
                  style: TextStyle(
                    fontFamily: AppTypography.fontFamily,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppColors.accent,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          SurfaceCard(
            padding: const EdgeInsets.fromLTRB(12, 16, 12, 12),
            child: SizedBox(
              height: 80,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: List.generate(_values.length, (i) {
                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 2),
                      child: _AnimatedBar(
                        value: _values[i],
                        delay: Duration(milliseconds: 400 + i * 40),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AnimatedBar extends StatelessWidget {
  const _AnimatedBar({required this.value, required this.delay});
  final double value;
  final Duration delay;

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: value.clamp(0.05, 1.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: AppColors.accent.withValues(alpha: 0.7 + value * 0.3),
        ),
      ),
    )
        .animate(delay: delay)
        .scaleY(begin: 0, end: 1, alignment: Alignment.bottomCenter, duration: 500.ms, curve: Curves.easeOutCubic)
        .fadeIn(duration: 300.ms);
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Overview Card — MOVES total + LENGTH
// ─────────────────────────────────────────────────────────────────────────────
class _OverviewCard extends StatelessWidget {
  const _OverviewCard();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'OVERVIEW',
            style: TextStyle(
              fontFamily: AppTypography.fontFamily,
              fontSize: 13,
              fontWeight: FontWeight.w800,
              letterSpacing: 1.5,
              color: AppColors.darkTextPrimary,
            ),
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              // MOVES
              Expanded(
                child: SurfaceCard(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'MOVES',
                        style: TextStyle(
                          fontFamily: AppTypography.fontFamily,
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1.5,
                          color: Colors.white.withValues(alpha: 0.4),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          // Dot indicator
                          Container(
                            width: 8,
                            height: 8,
                            margin: const EdgeInsets.only(bottom: 6, right: 8),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.accent,
                            ),
                          ),
                          const Text(
                            '15.678',
                            style: TextStyle(
                              fontFamily: AppTypography.fontFamily,
                              fontSize: 30,
                              fontWeight: FontWeight.w900,
                              color: AppColors.darkTextPrimary,
                              height: 1.0,
                              letterSpacing: -0.5,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Average Activity',
                        style: TextStyle(
                          fontFamily: AppTypography.fontFamily,
                          fontSize: 12,
                          color: Colors.white.withValues(alpha: 0.35),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 12),
              // LENGTH
              Expanded(
                child: SurfaceCard(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'LENGHT',
                        style: TextStyle(
                          fontFamily: AppTypography.fontFamily,
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1.5,
                          color: Colors.white.withValues(alpha: 0.4),
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        '46:30:12',
                        style: TextStyle(
                          fontFamily: AppTypography.fontFamily,
                          fontSize: 30,
                          fontWeight: FontWeight.w900,
                          color: AppColors.darkTextPrimary,
                          height: 1.0,
                          letterSpacing: -0.5,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Average Activity',
                        style: TextStyle(
                          fontFamily: AppTypography.fontFamily,
                          fontSize: 12,
                          color: Colors.white.withValues(alpha: 0.35),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Monthly Section — secondary donut ring + labels
// ─────────────────────────────────────────────────────────────────────────────
class _MonthlySection extends StatefulWidget {
  const _MonthlySection();

  @override
  State<_MonthlySection> createState() => _MonthlySectionState();
}

class _MonthlySectionState extends State<_MonthlySection>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _anim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 1200));
    _anim = CurvedAnimation(parent: _ctrl, curve: Curves.easeOutCubic);
    Future.delayed(800.ms, () {
      if (mounted) _ctrl.forward();
    });
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: SurfaceCard(
        padding: const EdgeInsets.all(24),
        child: Row(
          children: [
            // Donut ring
            AnimatedBuilder(
              animation: _anim,
              builder: (_, __) => SizedBox(
                width: 120,
                height: 120,
                child: CustomPaint(
                  painter: _DonutRingPainter(
                    monthProgress: 0.65 * _anim.value,
                    totalProgress: 0.42 * _anim.value,
                    monthColor: AppColors.accent,
                    totalColor: AppColors.badgeStations,
                    trackColor: AppColors.darkSurfaceHigher,
                  ),
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'MONTH',
                          style: TextStyle(
                            fontFamily: AppTypography.fontFamily,
                            fontSize: 9,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1,
                            color: Colors.white.withValues(alpha: 0.35),
                          ),
                        ),
                        Text(
                          'TOTAL',
                          style: TextStyle(
                            fontFamily: AppTypography.fontFamily,
                            fontSize: 9,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1,
                            color: Colors.white.withValues(alpha: 0.25),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 24),
            // Legend
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _LegendRow(
                    color: AppColors.accent,
                    label: 'Questo mese',
                    value: '65%',
                  ),
                  const SizedBox(height: 14),
                  _LegendRow(
                    color: AppColors.badgeStations,
                    label: 'Media totale',
                    value: '42%',
                  ),
                  const SizedBox(height: 18),
                  Text(
                    'Attività in aumento del 23% rispetto\nal mese scorso',
                    style: TextStyle(
                      fontFamily: AppTypography.fontFamily,
                      fontSize: 12,
                      color: Colors.white.withValues(alpha: 0.35),
                      height: 1.4,
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

class _LegendRow extends StatelessWidget {
  const _LegendRow({required this.color, required this.label, required this.value});
  final Color color;
  final String label, value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(shape: BoxShape.circle, color: color),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            label,
            style: const TextStyle(
              fontFamily: AppTypography.fontFamily,
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.darkTextPrimary,
            ),
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontFamily: AppTypography.fontFamily,
            fontSize: 14,
            fontWeight: FontWeight.w800,
            color: color,
          ),
        ),
      ],
    );
  }
}

class _DonutRingPainter extends CustomPainter {
  const _DonutRingPainter({
    required this.monthProgress,
    required this.totalProgress,
    required this.monthColor,
    required this.totalColor,
    required this.trackColor,
  });
  final double monthProgress, totalProgress;
  final Color monthColor, totalColor, trackColor;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    const sw = 10.0;
    final outerR = (size.width - 20) / 2;
    final innerR = outerR - sw - 6;
    const startAngle = -pi / 2;

    // Outer track + arc (month)
    _drawRing(canvas, center, outerR, sw, startAngle, monthProgress, monthColor, trackColor);
    // Inner track + arc (total)
    _drawRing(canvas, center, innerR, sw, startAngle, totalProgress, totalColor, trackColor);
  }

  void _drawRing(Canvas canvas, Offset center, double radius, double sw,
      double startAngle, double progress, Color color, Color track) {
    canvas.drawCircle(
      center,
      radius,
      Paint()
        ..color = track
        ..style = PaintingStyle.stroke
        ..strokeWidth = sw
        ..strokeCap = StrokeCap.round,
    );
    if (progress <= 0) return;

    final sweep = 2 * pi * progress;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweep,
      false,
      Paint()
        ..color = color.withValues(alpha: 0.2)
        ..style = PaintingStyle.stroke
        ..strokeWidth = sw + 4
        ..strokeCap = StrokeCap.round
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4),
    );
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweep,
      false,
      Paint()
        ..color = color
        ..style = PaintingStyle.stroke
        ..strokeWidth = sw
        ..strokeCap = StrokeCap.round,
    );
  }

  @override
  bool shouldRepaint(_DonutRingPainter o) =>
      o.monthProgress != monthProgress || o.totalProgress != totalProgress;
}
