import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';

class SessionsScreen extends StatefulWidget {
  const SessionsScreen({super.key});

  @override
  State<SessionsScreen> createState() => _SessionsScreenState();
}

class _SessionsScreenState extends State<SessionsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedTab = 0;

  // Mode: 0 = Sessioni, 1 = Esercizi
  int _mode = 0;

  final _tabs = ['Prossime', 'Settimana', 'Storico'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
    _tabController.addListener(() {
      setState(() => _selectedTab = _tabController.index);
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _mode == 0 ? 'SESSIONS' : 'EXERCISES',
                    style: const TextStyle(
                      fontFamily: AppTypography.fontFamily,
                      fontSize: 28,
                      fontWeight: FontWeight.w900,
                      color: AppColors.darkTextPrimary,
                      letterSpacing: 0.5,
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.darkSurfaceHigh,
                          border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
                        ),
                        child: Icon(
                          _mode == 0 ? Icons.filter_list_rounded : Icons.tune,
                          color: AppColors.darkTextSecondary,
                          size: 20,
                        ),
                      ),
                      if (_mode == 0) ...[
                        const SizedBox(width: 8),
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.darkSurfaceHigh,
                            border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
                          ),
                          child: const Icon(Icons.calendar_month_rounded, color: AppColors.darkTextSecondary, size: 20),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Mode Switcher
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Container(
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                  color: AppColors.darkSurface,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
                ),
                child: Row(
                  children: [
                    _ModeSwitchButton(
                      label: 'Sessioni',
                      icon: Icons.calendar_month_outlined,
                      isSelected: _mode == 0,
                      onTap: () => setState(() => _mode = 0),
                    ),
                    _ModeSwitchButton(
                      label: 'Esercizi',
                      icon: Icons.fitness_center_outlined,
                      isSelected: _mode == 1,
                      onTap: () => setState(() => _mode = 1),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 12),

            // Content
            Expanded(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 250),
                switchInCurve: Curves.easeOut,
                switchOutCurve: Curves.easeIn,
                child: _mode == 0
                    ? _SessionsContent(
                        key: const ValueKey('sessions'),
                        tabController: _tabController,
                        selectedTab: _selectedTab,
                        tabs: _tabs,
                      )
                    : const _ExercisesContent(
                        key: ValueKey('exercises'),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Mode Switch Button
// ---------------------------------------------------------------------------
class _ModeSwitchButton extends StatelessWidget {
  const _ModeSwitchButton({
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.darkSurfaceHigh : AppColors.transparent,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 16,
                color: isSelected ? AppColors.accent : AppColors.darkTextSecondary,
              ),
              const SizedBox(width: 6),
              Text(
                label.toUpperCase(),
                style: TextStyle(
                  fontFamily: AppTypography.fontFamily,
                  fontSize: 13,
                  fontWeight: isSelected ? FontWeight.w800 : FontWeight.w600,
                  letterSpacing: 0.8,
                  color: isSelected ? AppColors.darkTextPrimary : AppColors.darkTextSecondary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// SESSIONS CONTENT
// ---------------------------------------------------------------------------
class _SessionsContent extends StatelessWidget {
  const _SessionsContent({
    super.key,
    required this.tabController,
    required this.selectedTab,
    required this.tabs,
  });

  final TabController tabController;
  final int selectedTab;
  final List<String> tabs;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Segmented tab control
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: AppColors.darkSurfaceHigh,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
            ),
            child: Row(
              children: List.generate(tabs.length, (i) {
                final selected = selectedTab == i;
                return Expanded(
                  child: GestureDetector(
                    onTap: () => tabController.animateTo(i),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: selected ? AppColors.accent : AppColors.transparent,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          tabs[i].toUpperCase(),
                          style: TextStyle(
                            fontFamily: AppTypography.fontFamily,
                            fontSize: 13,
                            fontWeight: selected ? FontWeight.w800 : FontWeight.w600,
                            letterSpacing: 0.5,
                            color: selected
                                ? AppColors.textOnAccent
                                : AppColors.darkTextSecondary,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
        ),

        const SizedBox(height: 4),

        Expanded(
          child: TabBarView(
            controller: tabController,
            children: [
              _SessionList(filter: 'upcoming'),
              _SessionList(filter: 'week'),
              _SessionList(filter: 'history'),
            ],
          ),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// EXERCISES CONTENT
// ---------------------------------------------------------------------------
class _ExercisesContent extends StatefulWidget {
  const _ExercisesContent({super.key});

  @override
  State<_ExercisesContent> createState() => _ExercisesContentState();
}

class _ExercisesContentState extends State<_ExercisesContent> {
  String _selectedMuscle = 'Tutto';

  final _muscles = ['Tutto', 'Gambe', 'Schiena', 'Petto', 'Braccia', 'Core'];

  final _mockExercises = [
    _MockExercise(id: '1', name: 'Barbell Bench Press', muscles: 'Petto \u2022 Bilanciere', difficulty: 'Principiante', difficultyColor: AppColors.difficultyBeginner, imageUrl: 'https://images.unsplash.com/photo-1534368959876-26bf04f2c947?w=160&h=160&fit=crop'),
    _MockExercise(id: '2', name: 'Barbell Squat', muscles: 'Gambe \u2022 Quadricipiti', difficulty: 'Intermedio', difficultyColor: AppColors.difficultyIntermediate, imageUrl: 'https://images.unsplash.com/photo-1566241142559-40e1dab266c6?w=160&h=160&fit=crop'),
    _MockExercise(id: '3', name: 'Pull Up', muscles: 'Schiena \u2022 Dorsali', difficulty: 'Avanzato', difficultyColor: AppColors.difficultyAdvanced, imageUrl: 'https://images.unsplash.com/photo-1598971639058-fab3c3109a00?w=160&h=160&fit=crop'),
    _MockExercise(id: '4', name: 'Dumbbell Curl', muscles: 'Braccia \u2022 Bicipiti', difficulty: 'Principiante', difficultyColor: AppColors.difficultyBeginner, imageUrl: 'https://images.unsplash.com/photo-1581009146145-b5ef050c2e1e?w=160&h=160&fit=crop'),
    _MockExercise(id: '5', name: 'Plank', muscles: 'Core \u2022 Addominali', difficulty: 'Principiante', difficultyColor: AppColors.difficultyBeginner, imageUrl: 'https://images.unsplash.com/photo-1566241142559-40e1dab266c6?w=160&h=160&fit=crop'),
    _MockExercise(id: '6', name: 'Deadlift', muscles: 'Gambe \u2022 Glutei & Schiena', difficulty: 'Avanzato', difficultyColor: AppColors.difficultyAdvanced, imageUrl: 'https://images.unsplash.com/photo-1517963879433-6ad2b056d712?w=160&h=160&fit=crop'),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Search bar
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 4, 24, 0),
          child: Container(
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.darkSurfaceHigh,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                const SizedBox(width: 12),
                Icon(Icons.search, color: AppColors.darkTextSecondary.withValues(alpha: 0.6), size: 22),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    style: const TextStyle(fontFamily: AppTypography.fontFamily, color: AppColors.darkTextPrimary, fontSize: 16),
                    decoration: InputDecoration(
                      hintText: 'Cerca esercizi',
                      hintStyle: TextStyle(fontFamily: AppTypography.fontFamily, color: AppColors.darkTextSecondary.withValues(alpha: 0.6), fontSize: 16),
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
            padding: const EdgeInsets.symmetric(horizontal: 24),
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
                    color: selected ? AppColors.accent : AppColors.darkSurfaceHigh,
                    borderRadius: BorderRadius.circular(999),
                    border: selected ? null : Border.all(color: Colors.white.withValues(alpha: 0.1), width: 1),
                  ),
                  child: Text(
                    _muscles[i],
                    style: TextStyle(
                      fontFamily: AppTypography.fontFamily,
                      fontSize: 14,
                      fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
                      color: selected ? AppColors.textOnAccent : AppColors.darkTextSecondary,
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
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('POPOLARI', style: TextStyle(fontFamily: AppTypography.fontFamily, fontSize: 12, fontWeight: FontWeight.w600, letterSpacing: 1.5, color: AppColors.darkTextSecondary.withValues(alpha: 0.6))),
              GestureDetector(
                onTap: () {},
                child: const Text('Vedi tutti', style: TextStyle(fontFamily: AppTypography.fontFamily, fontSize: 12, fontWeight: FontWeight.w500, color: AppColors.accent)),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        // Exercise list
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemCount: _mockExercises.length,
            itemBuilder: (context, i) => _ExerciseCard(
              exercise: _mockExercises[i],
              onTap: () => context.go('/exercises/${_mockExercises[i].id}'),
            ).animate().fadeIn(duration: 500.ms, delay: (i * 60).ms),
          ),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Exercise Card
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
          border: Border.all(color: Colors.white.withValues(alpha: 0.05), width: 1),
        ),
        child: Row(
          children: [
            Container(
              width: 64, height: 64,
              decoration: BoxDecoration(color: AppColors.darkSurfaceHigher, borderRadius: BorderRadius.circular(12)),
              clipBehavior: Clip.antiAlias,
              child: CachedNetworkImage(
                imageUrl: exercise.imageUrl,
                fit: BoxFit.cover,
                placeholder: (_, __) => Container(color: AppColors.darkSurfaceHigher, child: const Center(child: SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2, color: AppColors.darkTextSecondary)))),
                errorWidget: (_, __, ___) => Container(color: AppColors.darkSurfaceHigher, child: const Icon(Icons.fitness_center, color: AppColors.darkTextSecondary, size: 24)),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(child: Text(exercise.name, style: const TextStyle(fontFamily: AppTypography.fontFamily, fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.darkTextPrimary), overflow: TextOverflow.ellipsis)),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: exercise.difficultyColor.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(color: exercise.difficultyColor.withValues(alpha: 0.3), width: 1),
                        ),
                        child: Text(exercise.difficulty, style: TextStyle(fontFamily: AppTypography.fontFamily, fontSize: 11, fontWeight: FontWeight.w500, color: exercise.difficultyColor)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(exercise.muscles, style: TextStyle(fontFamily: AppTypography.fontFamily, fontSize: 14, color: AppColors.darkTextSecondary.withValues(alpha: 0.6))),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Icon(Icons.add_circle_outline, color: AppColors.darkTextSecondary.withValues(alpha: 0.5), size: 24),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Session List — Ladder-style full-image cards
// ---------------------------------------------------------------------------
class _SessionList extends StatelessWidget {
  const _SessionList({required this.filter});
  final String filter;

  @override
  Widget build(BuildContext context) {
    final mockSessions = [
      _MockSession(
        id: '1',
        title: 'DEFINE',
        subtitle: 'Build a toned, lean body with\nPilates x Strength',
        coach: 'Coach Maia',
        coachImageUrl: 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=400&h=500&fit=crop&crop=face',
        duration: '60 min',
        time: '18:00',
        booked: 12,
        capacity: 16,
        type: 'STATIONS',
      ),
      _MockSession(
        id: '2',
        title: 'POWER',
        subtitle: 'Explosive strength training for\nmaximum gains',
        coach: 'Coach Marco',
        coachImageUrl: 'https://images.unsplash.com/photo-1568602471122-7832951cc4c5?w=400&h=500&fit=crop&crop=face',
        duration: '75 min',
        time: '19:30',
        booked: 8,
        capacity: 20,
        type: 'SIMULATION',
      ),
      _MockSession(
        id: '3',
        title: 'ENDURE',
        subtitle: 'Push your cardio limits with\nHIIT & running drills',
        coach: 'Coach Sara',
        coachImageUrl: 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=400&h=500&fit=crop&crop=face',
        duration: '90 min',
        time: '07:00',
        booked: 6,
        capacity: 16,
        type: 'ENDURANCE',
      ),
      _MockSession(
        id: '4',
        title: 'COMPETE',
        subtitle: 'Simulazione gara completa\ncon tempi e classifica',
        coach: 'Coach Luca',
        coachImageUrl: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=400&h=500&fit=crop&crop=face',
        duration: '120 min',
        time: '09:00',
        booked: 16,
        capacity: 16,
        type: 'RACE',
      ),
    ];

    return ListView(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
      children: mockSessions.asMap().entries.map((entry) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: _SessionCard(session: entry.value)
              .animate()
              .fadeIn(duration: 500.ms, delay: (entry.key * 100).ms)
              .slideY(begin: 0.05, end: 0),
        );
      }).toList(),
    );
  }
}

// ---------------------------------------------------------------------------
// Session Card — Ladder "Find a Team" style: full coach image, centered text
// ---------------------------------------------------------------------------
class _SessionCard extends StatelessWidget {
  const _SessionCard({required this.session});
  final _MockSession session;

  Color get _badgeColor {
    switch (session.type) {
      case 'RACE': return AppColors.badgeRace;
      case 'SIMULATION': return AppColors.badgeSimulation;
      case 'STATIONS': return AppColors.badgeStations;
      case 'ENDURANCE': return AppColors.badgeEndurance;
      default: return AppColors.accent;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isFull = session.booked >= session.capacity;

    return GestureDetector(
      onTap: isFull ? null : () => context.go('/sessions/${session.id}'),
      child: Opacity(
        opacity: isFull ? 0.55 : 1.0,
        child: Container(
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: AppColors.darkSurfaceHigh,
          ),
          child: Column(
            children: [
              // ── Full Coach Image with overlay text ──
              SizedBox(
                height: 360,
                width: double.infinity,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    // Coach photo
                    CachedNetworkImage(
                      imageUrl: session.coachImageUrl,
                      fit: BoxFit.cover,
                      placeholder: (_, __) => Container(color: AppColors.darkSurfaceHigher),
                      errorWidget: (_, __, ___) => Container(
                        color: AppColors.darkSurfaceHigher,
                        child: const Icon(Icons.person, size: 60, color: AppColors.darkTextSecondary),
                      ),
                    ),
                    // Gradient overlay — stronger at bottom
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.black.withValues(alpha: 0.05),
                            Colors.black.withValues(alpha: 0.3),
                            Colors.black.withValues(alpha: 0.85),
                          ],
                          stops: const [0.0, 0.5, 1.0],
                        ),
                      ),
                    ),
                    // Top-left: time badge
                    Positioned(
                      top: 16,
                      left: 16,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.4),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.schedule, size: 14, color: Colors.white.withValues(alpha: 0.7)),
                            const SizedBox(width: 4),
                            Text(
                              '${session.time} \u2022 ${session.duration}',
                              style: TextStyle(
                                fontFamily: AppTypography.fontFamily,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Colors.white.withValues(alpha: 0.8),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Top-right: availability
                    Positioned(
                      top: 16,
                      right: 16,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: _badgeColor.withValues(alpha: 0.9),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          '${session.booked}/${session.capacity}',
                          style: TextStyle(
                            fontFamily: AppTypography.fontFamily,
                            fontSize: 12,
                            fontWeight: FontWeight.w800,
                            color: session.type == 'RACE' || session.type == 'SIMULATION'
                                ? Colors.black
                                : Colors.white,
                          ),
                        ),
                      ),
                    ),
                    // Center-bottom text
                    Positioned(
                      bottom: 20,
                      left: 0,
                      right: 0,
                      child: Column(
                        children: [
                          Text(
                            session.coach,
                            style: TextStyle(
                              fontFamily: AppTypography.fontFamily,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.white.withValues(alpha: 0.7),
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            session.title,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontFamily: AppTypography.fontFamily,
                              fontSize: 42,
                              fontWeight: FontWeight.w900,
                              color: Colors.white,
                              height: 1.0,
                              letterSpacing: 1.0,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            session.subtitle,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: AppTypography.fontFamily,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Colors.white.withValues(alpha: 0.6),
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // ── Dual CTA Buttons ──
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        decoration: BoxDecoration(
                          color: AppColors.darkSurfaceHigher,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
                        ),
                        child: const Center(
                          child: Text(
                            'SCOPRI DI PIÙ',
                            style: TextStyle(
                              fontFamily: AppTypography.fontFamily,
                              fontSize: 14,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 0.5,
                              color: AppColors.darkTextPrimary,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: GestureDetector(
                        onTap: isFull ? null : () => context.go('/sessions/${session.id}'),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          decoration: BoxDecoration(
                            color: isFull ? AppColors.darkSurfaceHigher : AppColors.accent,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Center(
                            child: Text(
                              isFull ? 'COMPLETO' : 'PRENOTA',
                              style: TextStyle(
                                fontFamily: AppTypography.fontFamily,
                                fontSize: 14,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 0.5,
                                color: isFull ? AppColors.darkTextSecondary : AppColors.textOnAccent,
                              ),
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
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Mock models
// ---------------------------------------------------------------------------
class _MockSession {
  const _MockSession({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.coach,
    required this.coachImageUrl,
    required this.duration,
    required this.time,
    required this.booked,
    required this.capacity,
    required this.type,
  });
  final String id, title, subtitle, coach, coachImageUrl, duration, time, type;
  final int booked, capacity;
}

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
