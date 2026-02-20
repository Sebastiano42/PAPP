import 'package:supabase_flutter/supabase_flutter.dart';

/// Accesso rapido al client Supabase globale.
/// Usare `supabase` ovunque nel codice invece di `Supabase.instance.client`.
SupabaseClient get supabase => Supabase.instance.client;
