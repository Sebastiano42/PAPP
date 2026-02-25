import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../features/auth/presentation/screens/login_screen.dart';
import '../features/auth/presentation/screens/register_screen.dart';
import '../features/sessions/presentation/screens/sessions_screen.dart';
import '../features/sessions/presentation/screens/session_detail_screen.dart';
import '../features/exercises/presentation/screens/exercise_detail_screen.dart';
import '../features/profile/presentation/screens/profile_screen.dart';
import '../features/program/presentation/screens/program_screen.dart';
import '../features/progress/presentation/screens/progress_screen.dart';
import '../features/timer/presentation/screens/timer_home_screen.dart';
import '../features/timer/presentation/screens/active_timer_screen.dart';
import '../features/timer/presentation/screens/create_timer_screen.dart';
import 'shell/main_shell.dart';

// Route names — usare sempre le costanti per evitare typo
abstract class AppRoutes {
  static const login = '/login';
  static const register = '/register';
  static const home = '/';
  static const sessions = '/sessions';
  static const sessionDetail = '/sessions/:id';
  static const exercises = '/exercises';
  static const exerciseDetail = '/exercises/:id';
  static const profile = '/profile';
  static const program = '/program';
  static const progress = '/progress';
  static const timer = '/timer';
  static const activeTimer = '/timer/active';
  static const createTimer = '/timer/create';
}

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: AppRoutes.home,
    debugLogDiagnostics: true,
    redirect: (context, state) {
      // TODO: aggiungere redirect logic basato su auth state
      // if (!isAuthenticated) return AppRoutes.login;
      return null;
    },
    routes: [
      // Auth routes (senza shell)
      GoRoute(
        path: AppRoutes.login,
        name: 'login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: AppRoutes.register,
        name: 'register',
        builder: (context, state) => const RegisterScreen(),
      ),

      // Active timer — fullscreen, fuori dalla shell (senza bottom nav)
      GoRoute(
        path: AppRoutes.activeTimer,
        name: 'active-timer',
        builder: (context, state) => const ActiveTimerScreen(),
      ),

      // App routes (con bottom navigation shell)
      ShellRoute(
        builder: (context, state, child) => MainShell(child: child),
        routes: [
          GoRoute(
            path: AppRoutes.home,
            name: 'home',
            builder: (context, state) => const ProgramScreen(),
          ),
          GoRoute(
            path: AppRoutes.sessions,
            name: 'sessions',
            builder: (context, state) => const SessionsScreen(),
            routes: [
              GoRoute(
                path: ':id',
                name: 'session-detail',
                builder: (context, state) => SessionDetailScreen(
                  sessionId: state.pathParameters['id']!,
                ),
              ),
            ],
          ),
          GoRoute(
            path: AppRoutes.timer,
            name: 'timer',
            builder: (context, state) => const TimerHomeScreen(),
          ),
          GoRoute(
            path: AppRoutes.createTimer,
            name: 'create-timer',
            builder: (context, state) => const CreateTimerScreen(),
          ),
          GoRoute(
            path: AppRoutes.exerciseDetail,
            name: 'exercise-detail',
            builder: (context, state) => ExerciseDetailScreen(
              exerciseId: state.pathParameters['id']!,
            ),
          ),
          GoRoute(
            path: AppRoutes.progress,
            name: 'progress',
            builder: (context, state) => const ProgressScreen(),
          ),
          GoRoute(
            path: AppRoutes.profile,
            name: 'profile',
            builder: (context, state) => const ProfileScreen(),
          ),
        ],
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Text('Pagina non trovata: ${state.error}'),
      ),
    ),
  );
});
