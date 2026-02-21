import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_widgets.dart';

class SessionsScreen extends StatefulWidget {
  const SessionsScreen({super.key});

  @override
  State<SessionsScreen> createState() => _SessionsScreenState();
}

class _SessionsScreenState extends State<SessionsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedTab = 0;

  final _tabs = ['OGGI', 'SETTIMANA', 'MESE'];

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
      appBar: AppBar(
        title: const Text('SESSIONI'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: List.generate(_tabs.length, (i) {
                final selected = _selectedTab == i;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: GestureDetector(
                    onTap: () => _tabController.animateTo(i),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        gradient: selected
                            ? const LinearGradient(colors: AppColors.accentGradient)
                            : null,
                        color: selected ? null : AppColors.glassSurface,
                        borderRadius: BorderRadius.circular(999),
                        border: selected
                            ? null
                            : Border.all(color: AppColors.glassBorderSubtle, width: 0.5),
                        boxShadow: selected
                            ? [
                                BoxShadow(
                                  color: AppColors.accent.withValues(alpha: 0.3),
                                  blurRadius: 12,
                                ),
                              ]
                            : null,
                      ),
                      child: Text(
                        _tabs[i],
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: selected
                              ? AppColors.textOnAccent
                              : AppColors.darkTextSecondary,
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _SessionList(filter: 'today'),
          _SessionList(filter: 'week'),
          _SessionList(filter: 'month'),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Lista sessioni (placeholder — dati mock)
// ---------------------------------------------------------------------------

class _SessionList extends StatelessWidget {
  const _SessionList({required this.filter});
  final String filter;

  @override
  Widget build(BuildContext context) {
    final mockSessions = [
      _MockSession(
        id: '1',
        title: 'HIIT MORNING BLAST',
        coach: 'Sara Rossi',
        time: '09:00 – 10:00',
        room: 'Sala 1',
        booked: 8,
        capacity: 15,
        type: 'HIIT',
      ),
      _MockSession(
        id: '2',
        title: 'YOGA FLOW',
        coach: 'Luca Bianchi',
        time: '18:30 – 19:30',
        room: 'Sala Specchi',
        booked: 15,
        capacity: 15,
        type: 'YOGA',
      ),
      _MockSession(
        id: '3',
        title: 'FORZA & CONDIZIONAMENTO',
        coach: 'Marco Ferrari',
        time: '20:00 – 21:00',
        room: 'Sala Pesi',
        booked: 5,
        capacity: 12,
        type: 'FORZA',
      ),
    ];

    return ScaffoldGradientBackground(
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _DateLabel(label: 'LUN 20 FEB'),
          const SizedBox(height: 8),
          ...mockSessions.asMap().entries.map((entry) => Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: SessionCard(session: entry.value)
                    .animate()
                    .fadeIn(duration: 500.ms, delay: (entry.key * 100).ms)
                    .slideY(begin: 0.1, end: 0),
              )),
          const SizedBox(height: 96),
        ],
      ),
    );
  }
}

class _DateLabel extends StatelessWidget {
  const _DateLabel({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: Theme.of(context).textTheme.bodySmall?.copyWith(
            fontWeight: FontWeight.w600,
            letterSpacing: 1.2,
          ),
    );
  }
}

// ---------------------------------------------------------------------------
// Session Card
// ---------------------------------------------------------------------------

class SessionCard extends StatelessWidget {
  const SessionCard({super.key, required this.session});
  final _MockSession session;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isFull = session.booked >= session.capacity;
    final fillRatio = session.booked / session.capacity;

    return GlowCard(
      onTap: () => context.go('/sessions/${session.id}'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              Expanded(
                child: Text(
                  session.title,
                  style: theme.textTheme.headlineSmall,
                ),
              ),
              _TypeBadge(type: session.type),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            'Coach: ${session.coach}',
            style: theme.textTheme.bodyMedium,
          ),
          const SizedBox(height: 12),

          // Details
          Row(
            children: [
              const Icon(Icons.schedule_outlined, size: 14, color: AppColors.accent),
              const SizedBox(width: 4),
              Text(session.time, style: theme.textTheme.bodySmall),
              const SizedBox(width: 16),
              const Icon(Icons.location_on_outlined, size: 14, color: AppColors.accent),
              const SizedBox(width: 4),
              Text(session.room, style: theme.textTheme.bodySmall),
            ],
          ),
          const SizedBox(height: 12),

          // Progress bar
          GlowProgressBar(
            value: fillRatio,
          ),
          const SizedBox(height: 6),
          Text(
            isFull
                ? 'COMPLETO'
                : '${session.booked}/${session.capacity} posti',
            style: theme.textTheme.bodySmall?.copyWith(
              color: isFull
                  ? AppColors.darkTextDisabled
                  : fillRatio > 0.7
                      ? AppColors.accent
                      : null,
              fontWeight: FontWeight.w600,
            ),
          ),

          if (!isFull) ...[
            const SizedBox(height: 12),
            Align(
              alignment: Alignment.centerRight,
              child: GlowButton(
                label: 'PRENOTA',
                expand: false,
                onPressed: () => context.go('/sessions/${session.id}'),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _TypeBadge extends StatelessWidget {
  const _TypeBadge({required this.type});
  final String type;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.glassSurface,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: AppColors.accent.withValues(alpha: 0.4),
        ),
      ),
      child: Text(
        type,
        style: const TextStyle(
          fontFamily: 'Inter',
          fontSize: 11,
          fontWeight: FontWeight.w700,
          color: AppColors.accent,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Mock model
// ---------------------------------------------------------------------------
class _MockSession {
  const _MockSession({
    required this.id,
    required this.title,
    required this.coach,
    required this.time,
    required this.room,
    required this.booked,
    required this.capacity,
    required this.type,
  });
  final String id, title, coach, time, room, type;
  final int booked, capacity;
}
