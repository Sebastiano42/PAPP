import 'package:flutter/material.dart';

/// PAPP Design System — Color Palette
///
/// Palette: Nero · Bianco · Grigio · Giallo-Arancio (#FF9500)
/// Il giallo-arancio è l'UNICO accento cromatico dell'app.
abstract class AppColors {
  // ---------------------------------------------------------------------------
  // ACCENT — Giallo-Arancio (unico colore di brand)
  // ---------------------------------------------------------------------------
  static const Color accent = Color(0xFFFF9500);
  static const Color accentDark = Color(0xFFCC7700);  // pressed / hover light
  static const Color accentLight = Color(0xFFFFB84D); // pressed / hover dark
  static const Color accentTintLight = Color(0xFFFFF3E0); // sfondo tint su light
  static const Color accentTintDark = Color(0xFF2A1F00);  // sfondo tint su dark

  // ---------------------------------------------------------------------------
  // LIGHT THEME
  // ---------------------------------------------------------------------------
  static const Color lightBackground = Color(0xFFFFFFFF);
  static const Color lightSurface = Color(0xFFF2F2F2);
  static const Color lightSurfaceHigh = Color(0xFFE5E5E5);

  static const Color lightTextPrimary = Color(0xFF0A0A0A);
  static const Color lightTextSecondary = Color(0xFF4A4A4A);
  static const Color lightTextTertiary = Color(0xFF8A8A8A);
  static const Color lightTextDisabled = Color(0xFFB5B5B5);

  static const Color lightBorder = Color(0xFFD4D4D4);
  static const Color lightBorderEmphasis = Color(0xFF8A8A8A);

  // ---------------------------------------------------------------------------
  // DARK THEME
  // ---------------------------------------------------------------------------
  static const Color darkBackground = Color(0xFF0A0A0A);
  static const Color darkSurface = Color(0xFF141414);
  static const Color darkSurfaceHigh = Color(0xFF1F1F1F);

  static const Color darkTextPrimary = Color(0xFFFFFFFF);
  static const Color darkTextSecondary = Color(0xFFA3A3A3);
  static const Color darkTextTertiary = Color(0xFF6B6B6B);
  static const Color darkTextDisabled = Color(0xFF3D3D3D);

  static const Color darkBorder = Color(0xFF2A2A2A);
  static const Color darkBorderEmphasis = Color(0xFF4A4A4A);

  // ---------------------------------------------------------------------------
  // SHARED (non cambiano tra temi)
  // ---------------------------------------------------------------------------
  static const Color transparent = Colors.transparent;

  /// Testo che va SOPRA all'accent (#FF9500) — sempre nero per contrasto WCAG AA
  static const Color textOnAccent = Color(0xFF0A0A0A);
}
