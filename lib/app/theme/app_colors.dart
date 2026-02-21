import 'package:flutter/material.dart';

/// PAPP Design System — Color Palette
///
/// Dark Premium + Lime Green Accent #83F52C
/// Glassmorphism tokens per effetti frosted glass
abstract class AppColors {
  // ---------------------------------------------------------------------------
  // ACCENT — Lime Green (colore di brand)
  // ---------------------------------------------------------------------------
  static const Color accent = Color(0xFF83F52C);
  static const Color accentAlt = Color(0xFFC8FF3E); // lime chiaro per gradienti
  static const List<Color> accentGradient = [accent, accentAlt];
  static const Color accentDark = Color(0xFF66C420);  // pressed / hover
  static const Color accentLight = Color(0xFFB4F87A); // highlight
  static const Color accentTintDark = Color(0xFF1A2800);  // sfondo tint su dark

  // ---------------------------------------------------------------------------
  // GLASSMORPHISM
  // ---------------------------------------------------------------------------
  static const Color glassSurface = Color(0x14FFFFFF);       // white 8%
  static const Color glassSurfaceHigh = Color(0x1FFFFFFF);   // white 12%
  static const Color glassBorder = Color(0x33FFFFFF);        // white 20%
  static const Color glassBorderSubtle = Color(0x1AFFFFFF);  // white 10%

  // ---------------------------------------------------------------------------
  // DARK THEME (unico tema)
  // ---------------------------------------------------------------------------
  static const Color darkBackground = Color(0xFF0A0A0A);
  static const Color darkSurface = Color(0xFF141414);
  static const Color darkSurfaceHigh = Color(0xFF1E1E1E);
  static const Color darkSurfaceHigher = Color(0xFF252525);

  static const Color darkTextPrimary = Color(0xFFFFFFFF);
  static const Color darkTextSecondary = Color(0xFFA0A0A0);
  static const Color darkTextTertiary = Color(0xFF606060);
  static const Color darkTextDisabled = Color(0xFF3D3D3D);

  static const Color darkBorder = Color(0xFF2A2A2A);
  static const Color darkBorderEmphasis = Color(0xFF4A4A4A);

  // ---------------------------------------------------------------------------
  // SEMANTIC
  // ---------------------------------------------------------------------------
  static const Color error = Color(0xFFFF4D4D);
  static const Color warning = Color(0xFFFFB800);

  // ---------------------------------------------------------------------------
  // SHARED
  // ---------------------------------------------------------------------------
  static const Color transparent = Colors.transparent;

  /// Testo che va SOPRA all'accent — nero per contrasto
  static const Color textOnAccent = Color(0xFF0A0A0A);
}
