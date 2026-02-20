import 'package:flutter/material.dart';
import 'app_colors.dart';

/// PAPP Design System — Typography
///
/// Font: Inter (Google Fonts)
/// I titoli principali vanno in MAIUSCOLO per tono atletico.
abstract class AppTypography {
  static const String fontFamily = 'Inter';

  // ---------------------------------------------------------------------------
  // TEXT STYLES — Light Theme (testo scuro su sfondo chiaro)
  // ---------------------------------------------------------------------------

  static const TextStyle displayXL = TextStyle(
    fontFamily: fontFamily,
    fontSize: 40,
    fontWeight: FontWeight.w900,
    letterSpacing: -1.0,
    color: AppColors.lightTextPrimary,
  );

  static const TextStyle heading1 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 28,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.5,
    color: AppColors.lightTextPrimary,
  );

  static const TextStyle heading2 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 22,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.3,
    color: AppColors.lightTextPrimary,
  );

  static const TextStyle heading3 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColors.lightTextPrimary,
  );

  static const TextStyle bodyLarge = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.lightTextPrimary,
  );

  static const TextStyle bodySmall = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.lightTextSecondary,
  );

  static const TextStyle caption = TextStyle(
    fontFamily: fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.lightTextTertiary,
  );

  static const TextStyle button = TextStyle(
    fontFamily: fontFamily,
    fontSize: 15,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.5,
    color: AppColors.textOnAccent,
  );

  // ---------------------------------------------------------------------------
  // TEXT THEME — usato da ThemeData
  // ---------------------------------------------------------------------------

  static TextTheme get lightTextTheme => const TextTheme(
        displayLarge: displayXL,
        headlineLarge: heading1,
        headlineMedium: heading2,
        headlineSmall: heading3,
        bodyLarge: bodyLarge,
        bodyMedium: bodySmall,
        bodySmall: caption,
        labelLarge: button,
      );

  static TextTheme get darkTextTheme => TextTheme(
        displayLarge: displayXL.copyWith(color: AppColors.darkTextPrimary),
        headlineLarge: heading1.copyWith(color: AppColors.darkTextPrimary),
        headlineMedium: heading2.copyWith(color: AppColors.darkTextPrimary),
        headlineSmall: heading3.copyWith(color: AppColors.darkTextPrimary),
        bodyLarge: bodyLarge.copyWith(color: AppColors.darkTextPrimary),
        bodyMedium: bodySmall.copyWith(color: AppColors.darkTextSecondary),
        bodySmall: caption.copyWith(color: AppColors.darkTextTertiary),
        labelLarge: button,
      );
}
