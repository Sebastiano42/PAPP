import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app_colors.dart';
import 'app_typography.dart';

/// HybridCrew Design System — Theme
///
/// Dark-only, Ladder-inspired. Bold, high-contrast, yellow-lime accent #E2F163.
abstract class AppTheme {
  // ---------------------------------------------------------------------------
  // DARK THEME (unico)
  // ---------------------------------------------------------------------------
  static ThemeData get dark => ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        fontFamily: AppTypography.fontFamily,
        textTheme: AppTypography.darkTextTheme,

        colorScheme: const ColorScheme.dark(
          primary: AppColors.accent,
          onPrimary: AppColors.textOnAccent,
          secondary: AppColors.accentLight,
          onSecondary: AppColors.textOnAccent,
          surface: AppColors.darkBackground,
          onSurface: AppColors.darkTextPrimary,
          surfaceContainerHighest: AppColors.darkSurface,
          outline: AppColors.darkBorder,
          error: AppColors.error,
          onError: AppColors.darkBackground,
        ),

        scaffoldBackgroundColor: AppColors.darkBackground,

        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.darkBackground,
          foregroundColor: AppColors.darkTextPrimary,
          elevation: 0,
          scrolledUnderElevation: 0,
          centerTitle: false,
          titleTextStyle: TextStyle(
            fontFamily: AppTypography.fontFamily,
            fontSize: 28,
            fontWeight: FontWeight.w800,
            color: AppColors.darkTextPrimary,
            letterSpacing: -0.5,
          ),
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: AppColors.transparent,
            statusBarIconBrightness: Brightness.light,
          ),
        ),

        navigationBarTheme: NavigationBarThemeData(
          backgroundColor: AppColors.darkBackground,
          indicatorColor: AppColors.transparent,
          iconTheme: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return const IconThemeData(color: AppColors.accent, size: 26);
            }
            return IconThemeData(
              color: AppColors.darkTextSecondary.withValues(alpha: 0.4),
              size: 26,
            );
          }),
          labelTextStyle: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return const TextStyle(
                fontFamily: AppTypography.fontFamily,
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: AppColors.accent,
              );
            }
            return TextStyle(
              fontFamily: AppTypography.fontFamily,
              fontSize: 10,
              fontWeight: FontWeight.w500,
              color: AppColors.darkTextSecondary.withValues(alpha: 0.4),
            );
          }),
          elevation: 0,
          surfaceTintColor: AppColors.transparent,
        ),

        cardTheme: CardTheme(
          color: AppColors.darkSurfaceHigh,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          margin: EdgeInsets.zero,
        ),

        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.accent,
            foregroundColor: AppColors.textOnAccent,
            elevation: 0,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            textStyle: const TextStyle(
              fontFamily: AppTypography.fontFamily,
              fontSize: 16,
              fontWeight: FontWeight.w800,
              letterSpacing: 1.0,
            ),
          ),
        ),

        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: AppColors.darkTextPrimary,
            side: const BorderSide(color: AppColors.darkBorder),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            textStyle: const TextStyle(
              fontFamily: AppTypography.fontFamily,
              fontSize: 15,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),

        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: AppColors.accent,
            textStyle: const TextStyle(
              fontFamily: AppTypography.fontFamily,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),

        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: AppColors.darkSurface,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: AppColors.darkBorder),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: AppColors.darkBorder),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: AppColors.accent, width: 1.5),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: AppColors.error),
          ),
          hintStyle: const TextStyle(
            fontFamily: AppTypography.fontFamily,
            color: AppColors.darkTextSecondary,
          ),
          labelStyle: const TextStyle(
            fontFamily: AppTypography.fontFamily,
            color: AppColors.darkTextSecondary,
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        ),

        dividerTheme: const DividerThemeData(
          color: AppColors.darkBorder,
          thickness: 1,
          space: 1,
        ),

        progressIndicatorTheme: const ProgressIndicatorThemeData(
          color: AppColors.accent,
          linearTrackColor: AppColors.darkSurfaceHigher,
        ),
      );
}
