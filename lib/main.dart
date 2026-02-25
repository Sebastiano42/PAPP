import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:supabase_flutter/supabase_flutter.dart'; // TODO: riabilitare quando Supabase è configurato
import 'app/router.dart';
import 'app/theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // TODO: riabilitare quando Supabase è configurato
  // await Supabase.initialize(
  //   url: const String.fromEnvironment('SUPABASE_URL'),
  //   anonKey: const String.fromEnvironment('SUPABASE_ANON_KEY'),
  // );

  runApp(
    const ProviderScope(
      child: HybridCrewApp(),
    ),
  );
}

class HybridCrewApp extends ConsumerWidget {
  const HybridCrewApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      title: 'HybridCrew',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.dark,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.dark,
      routerConfig: router,
    );
  }
}
