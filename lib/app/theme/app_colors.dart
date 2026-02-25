import 'package:flutter/material.dart';

/// HybridCrew Design System — Color Palette
///
/// Dark Premium + Yellow-Lime Accent #E2F163
/// Inspired by Ladder — bold, dark, high-contrast
abstract class AppColors {
  // ---------------------------------------------------------------------------
  // ACCENT — Yellow-Lime (colore di brand)
  // ---------------------------------------------------------------------------
  static const Color accent = Color(0xFFE2F163);
  static const Color accentDark = Color(0xFFC4D44E);  // pressed / hover
  static const Color accentLight = Color(0xFFEBF78C); // highlight

  // ---------------------------------------------------------------------------
  // DARK THEME (unico tema)
  // ---------------------------------------------------------------------------
  static const Color darkBackground = Color(0xFF000000);
  static const Color darkSurface = Color(0xFF111111);
  static const Color darkSurfaceHigh = Color(0xFF1A1A1A);
  static const Color darkSurfaceHigher = Color(0xFF2A2A2A);

  static const Color darkTextPrimary = Color(0xFFFFFFFF);
  static const Color darkTextSecondary = Color(0xFF8A8A8A);
  static const Color darkTextTertiary = Color(0xFF606060);
  static const Color darkTextDisabled = Color(0xFF3D3D3D);

  static const Color darkBorder = Color(0xFF222222);
  static const Color darkBorderLight = Color(0xFF2A2A2A);

  // ---------------------------------------------------------------------------
  // SEMANTIC / BADGE COLORS
  // ---------------------------------------------------------------------------
  static const Color error = Color(0xFFFF3B30);
  static const Color warning = Color(0xFFFFB800);
  static const Color success = Color(0xFF34C759);

  // Badge colors per tipo sessione / Hyrox
  static const Color badgeRace = Color(0xFFFFD60A);       // Gara ufficiale — giallo Hyrox
  static const Color badgeSimulation = Color(0xFFE2F163); // Simulazione — accent lime
  static const Color badgeStations = Color(0xFF0A84FF);   // Lavoro stazioni — blu
  static const Color badgeEndurance = Color(0xFFFF3B30);  // Endurance — rosso

  // Legacy aliases
  static const Color badgeHiit = Color(0xFFFF3B30);
  static const Color badgeForza = Color(0xFFE2F163);
  static const Color badgeYoga = Color(0xFF34C759);

  // Difficulty badge colors
  static const Color difficultyBeginner = Color(0xFF34C759);
  static const Color difficultyIntermediate = Color(0xFFE2F163);
  static const Color difficultyAdvanced = Color(0xFFFF3B30);

  // ---------------------------------------------------------------------------
  // SHARED
  // ---------------------------------------------------------------------------
  static const Color transparent = Colors.transparent;

  /// Testo che va SOPRA all'accent — nero per contrasto
  static const Color textOnAccent = Color(0xFF000000);
}
