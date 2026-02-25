import 'package:flutter/material.dart';
import 'app_colors.dart';

/// HybridCrew Design System — Typography
///
/// Font: Inter (Google Fonts)
/// Ladder-inspired: bold headlines, uppercase CTAs, high contrast
abstract class AppTypography {
  static const String fontFamily = 'Inter';

  // ---------------------------------------------------------------------------
  // TEXT STYLES — Bold, impactful, Ladder-inspired
  // ---------------------------------------------------------------------------

  /// Hero display — massive bold accent (workout titles, hero text)
  static const TextStyle displayXL = TextStyle(
    fontFamily: fontFamily,
    fontSize: 36,
    fontWeight: FontWeight.w900,
    letterSpacing: -0.5,
    height: 1.1,
    color: AppColors.darkTextPrimary,
  );

  /// Section title — large bold white
  static const TextStyle heading1 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 28,
    fontWeight: FontWeight.w800,
    letterSpacing: -0.5,
    height: 1.15,
    color: AppColors.darkTextPrimary,
  );

  /// Card/subsection title — bold
  static const TextStyle heading2 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 22,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.3,
    color: AppColors.darkTextPrimary,
  );

  /// Small heading — semibold
  static const TextStyle heading3 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 18,
    fontWeight: FontWeight.w700,
    color: AppColors.darkTextPrimary,
  );

  /// Body text — regular readable
  static const TextStyle bodyLarge = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.darkTextPrimary,
  );

  /// Secondary body text
  static const TextStyle bodySmall = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.darkTextSecondary,
  );

  /// Small labels and captions
  static const TextStyle caption = TextStyle(
    fontFamily: fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: AppColors.darkTextTertiary,
  );

  /// CTA button text — UPPERCASE, bold, tracked
  static const TextStyle button = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w800,
    letterSpacing: 1.0,
    color: AppColors.textOnAccent,
  );

  /// Stat number — large accent-colored
  static const TextStyle statNumber = TextStyle(
    fontFamily: fontFamily,
    fontSize: 32,
    fontWeight: FontWeight.w900,
    color: AppColors.accent,
  );

  /// Stat label — small, secondary
  static const TextStyle statLabel = TextStyle(
    fontFamily: fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: AppColors.darkTextSecondary,
  );

  /// Chip text — compact pill labels
  static const TextStyle chip = TextStyle(
    fontFamily: fontFamily,
    fontSize: 13,
    fontWeight: FontWeight.w600,
    color: AppColors.darkTextPrimary,
  );

  /// Uppercase helper for workout names / CTA
  static const TextStyle workoutTitle = TextStyle(
    fontFamily: fontFamily,
    fontSize: 28,
    fontWeight: FontWeight.w900,
    letterSpacing: 0.5,
    height: 1.1,
    color: AppColors.darkTextPrimary,
  );

  // ---------------------------------------------------------------------------
  // TEXT THEME — usato da ThemeData
  // ---------------------------------------------------------------------------

  static TextTheme get darkTextTheme => const TextTheme(
        displayLarge: displayXL,
        headlineLarge: heading1,
        headlineMedium: heading2,
        headlineSmall: heading3,
        bodyLarge: bodyLarge,
        bodyMedium: bodySmall,
        bodySmall: caption,
        labelLarge: button,
      );
}
