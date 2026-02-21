import 'dart:ui';
import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_typography.dart';

/// ScaffoldGradientBackground — Stack con orbs decorativi che danno al
/// BackdropFilter qualcosa da blurrare su sfondo #0A0A0A.
class ScaffoldGradientBackground extends StatelessWidget {
  const ScaffoldGradientBackground({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Orb top-left (accent)
        Positioned(
          top: -80,
          left: -80,
          child: Container(
            width: 300,
            height: 300,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  AppColors.accent.withValues(alpha: 0.12),
                  AppColors.accent.withValues(alpha: 0.0),
                ],
              ),
            ),
          ),
        ),
        // Orb bottom-right (accentAlt)
        Positioned(
          bottom: -100,
          right: -100,
          child: Container(
            width: 320,
            height: 320,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  AppColors.accentAlt.withValues(alpha: 0.07),
                  AppColors.accentAlt.withValues(alpha: 0.0),
                ],
              ),
            ),
          ),
        ),
        // Actual content
        child,
      ],
    );
  }
}

/// GlassCard — Card glassmorphism con BackdropFilter blur, bordo frosted e
/// ombra accent sottile.
class GlassCard extends StatelessWidget {
  const GlassCard({
    super.key,
    required this.child,
    this.glowBorder = false,
    this.padding = const EdgeInsets.all(16),
    this.onTap,
  });

  final Widget child;
  final bool glowBorder;
  final EdgeInsetsGeometry padding;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
          child: Container(
            padding: padding,
            decoration: BoxDecoration(
              color: AppColors.glassSurface,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: glowBorder
                    ? AppColors.accent.withValues(alpha: 0.3)
                    : AppColors.glassBorder,
                width: 0.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.accent.withValues(alpha: glowBorder ? 0.15 : 0.05),
                  blurRadius: glowBorder ? 20 : 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}

/// GlowCard — Alias di GlassCard per backward compatibility.
class GlowCard extends GlassCard {
  const GlowCard({
    super.key,
    required super.child,
    super.glowBorder,
    super.padding,
    super.onTap,
  });
}

/// GlowButton — CTA con gradiente lime, ombra glow e stato loading.
class GlowButton extends StatelessWidget {
  const GlowButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isLoading = false,
    this.expand = true,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool expand;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: expand ? double.infinity : null,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: const LinearGradient(colors: AppColors.accentGradient),
          boxShadow: [
            BoxShadow(
              color: AppColors.accent.withValues(alpha: 0.4),
              blurRadius: 16,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Material(
          color: AppColors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: isLoading ? null : onPressed,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Center(
                child: isLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: AppColors.textOnAccent,
                        ),
                      )
                    : Text(
                        label,
                        style: const TextStyle(
                          fontFamily: AppTypography.fontFamily,
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.5,
                          color: AppColors.textOnAccent,
                        ),
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// GlowProgressBar — Barra progresso con glow accent.
class GlowProgressBar extends StatelessWidget {
  const GlowProgressBar({
    super.key,
    required this.value,
    this.height = 6,
  });

  final double value;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(999),
        color: AppColors.darkSurfaceHigh,
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final barWidth = constraints.maxWidth * value.clamp(0.0, 1.0);
          return Stack(
            children: [
              Container(
                width: barWidth,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(999),
                  gradient: const LinearGradient(colors: AppColors.accentGradient),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.accent.withValues(alpha: 0.4),
                      blurRadius: 8,
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
