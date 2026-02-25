import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_typography.dart';

/// SurfaceCard — Card con sfondo solido scuro, bordo sottile e angoli arrotondati.
class SurfaceCard extends StatelessWidget {
  const SurfaceCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(20),
    this.onTap,
    this.color,
    this.borderRadius = 16,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final VoidCallback? onTap;
  final Color? color;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: padding,
        decoration: BoxDecoration(
          color: color ?? AppColors.darkSurfaceHigh,
          borderRadius: BorderRadius.circular(borderRadius),
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.05),
            width: 1,
          ),
        ),
        child: child,
      ),
    );
  }
}

/// GlassCard — Alias per backward compatibility, ora usa SurfaceCard.
class GlassCard extends SurfaceCard {
  const GlassCard({
    super.key,
    required super.child,
    bool glowBorder = false,
    super.padding,
    super.onTap,
  });
}

/// GlowCard — Alias per backward compatibility.
class GlowCard extends SurfaceCard {
  const GlowCard({
    super.key,
    required super.child,
    bool glowBorder = false,
    super.padding,
    super.onTap,
  });
}

/// PrimaryButton — CTA bold uppercase, Ladder-inspired.
class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isLoading = false,
    this.expand = true,
    this.icon,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool expand;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: expand ? double.infinity : null,
      child: Material(
        color: AppColors.accent,
        borderRadius: BorderRadius.circular(14),
        child: InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: isLoading ? null : onPressed,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
            ),
            child: Center(
              child: isLoading
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.5,
                        color: AppColors.textOnAccent,
                      ),
                    )
                  : Row(
                      mainAxisSize: expand ? MainAxisSize.max : MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (icon != null) ...[
                          Icon(icon, color: AppColors.textOnAccent, size: 20),
                          const SizedBox(width: 8),
                        ],
                        Text(
                          label.toUpperCase(),
                          style: AppTypography.button,
                        ),
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }
}

/// GlowButton — Alias per backward compatibility, ora usa PrimaryButton.
class GlowButton extends PrimaryButton {
  const GlowButton({
    super.key,
    required super.label,
    required super.onPressed,
    super.isLoading,
    super.expand,
    super.icon,
  });
}

/// SecondaryButton — Bottone con sfondo scuro e bordo.
class SecondaryButton extends StatelessWidget {
  const SecondaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.expand = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool expand;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: expand ? double.infinity : null,
      child: Material(
        color: AppColors.darkSurfaceHigher,
        borderRadius: BorderRadius.circular(14),
        child: InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: onPressed,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: AppColors.darkBorderLight,
                width: 1,
              ),
            ),
            child: Center(
              child: Text(
                label.toUpperCase(),
                style: TextStyle(
                  fontFamily: AppTypography.fontFamily,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.8,
                  color: AppColors.darkTextPrimary,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// HChipBar — Horizontal scrollable chip bar (Ladder-style quick actions).
class HChipBar extends StatelessWidget {
  const HChipBar({
    super.key,
    required this.chips,
    this.selectedIndex,
    this.onSelected,
    this.padding = const EdgeInsets.symmetric(horizontal: 20),
  });

  final List<HChipItem> chips;
  final int? selectedIndex;
  final ValueChanged<int>? onSelected;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: padding,
        itemCount: chips.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final chip = chips[index];
          final isSelected = index == selectedIndex;
          return GestureDetector(
            onTap: () => onSelected?.call(index),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.accent : AppColors.darkSurfaceHigh,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isSelected
                      ? AppColors.accent
                      : Colors.white.withValues(alpha: 0.1),
                  width: 1,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (chip.icon != null) ...[
                    Icon(
                      chip.icon,
                      size: 16,
                      color: isSelected
                          ? AppColors.textOnAccent
                          : AppColors.darkTextSecondary,
                    ),
                    const SizedBox(width: 6),
                  ],
                  Text(
                    chip.label,
                    style: AppTypography.chip.copyWith(
                      color: isSelected
                          ? AppColors.textOnAccent
                          : AppColors.darkTextPrimary,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

/// Data class for HChipBar items.
class HChipItem {
  const HChipItem({required this.label, this.icon});
  final String label;
  final IconData? icon;
}

/// HeroImageCard — Card with full-bleed background image and text overlay.
class HeroImageCard extends StatelessWidget {
  const HeroImageCard({
    super.key,
    required this.imageUrl,
    required this.child,
    this.height = 220,
    this.borderRadius = 16,
    this.onTap,
    this.gradient,
  });

  final String imageUrl;
  final Widget child;
  final double height;
  final double borderRadius;
  final VoidCallback? onTap;
  final Gradient? gradient;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          image: DecorationImage(
            image: NetworkImage(imageUrl),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
            gradient: gradient ??
                LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withValues(alpha: 0.8),
                  ],
                  stops: const [0.3, 1.0],
                ),
          ),
          padding: const EdgeInsets.all(20),
          child: child,
        ),
      ),
    );
  }
}

/// ProgressBar — Barra progresso semplice con colore configurabile.
class ProgressBar extends StatelessWidget {
  const ProgressBar({
    super.key,
    required this.value,
    this.height = 4,
    this.color,
    this.backgroundColor,
  });

  final double value;
  final double height;
  final Color? color;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(999),
        color: backgroundColor ?? AppColors.darkSurfaceHigher,
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final barWidth = constraints.maxWidth * value.clamp(0.0, 1.0);
          return Align(
            alignment: Alignment.centerLeft,
            child: Container(
              width: barWidth,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(999),
                color: color ?? AppColors.accent,
              ),
            ),
          );
        },
      ),
    );
  }
}

/// GlowProgressBar — Alias per backward compatibility.
class GlowProgressBar extends ProgressBar {
  const GlowProgressBar({
    super.key,
    required super.value,
    super.height = 4,
    super.color,
  });
}

/// ScaffoldGradientBackground — Ora un semplice wrapper senza effetti.
class ScaffoldGradientBackground extends StatelessWidget {
  const ScaffoldGradientBackground({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return child;
  }
}
