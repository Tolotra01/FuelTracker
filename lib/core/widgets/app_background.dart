import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

/// Fond dégradé avec halos colorés flous — donne la profondeur "3D"
/// derrière les cartes en verre.
class AppBackground extends StatelessWidget {
  const AppBackground({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Stack(
      children: [
        // Base
        Positioned.fill(
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: isDark
                    ? const [AppColors.navyBlue, AppColors.navyDeep]
                    : const [AppColors.lightGray, Color(0xFFE9EDF3)],
              ),
            ),
          ),
        ),
        // Halo émeraude
        _Blob(
          top: -120,
          left: -80,
          size: 320,
          color: AppColors.emerald.withValues(alpha: isDark ? 0.30 : 0.22),
        ),
        // Halo orange
        _Blob(
          top: 180,
          right: -110,
          size: 300,
          color: AppColors.orange.withValues(alpha: isDark ? 0.22 : 0.16),
        ),
        _Blob(
          bottom: -100,
          left: -60,
          size: 260,
          color: AppColors.info.withValues(alpha: isDark ? 0.18 : 0.12),
        ),
        child,
      ],
    );
  }
}

class _Blob extends StatelessWidget {
  const _Blob({
    this.top,
    this.bottom,
    this.left,
    this.right,
    required this.size,
    required this.color,
  });

  final double? top;
  final double? bottom;
  final double? left;
  final double? right;
  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      bottom: bottom,
      left: left,
      right: right,
      child: IgnorePointer(
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              colors: [color, color.withValues(alpha: 0)],
            ),
          ),
        ),
      ),
    );
  }
}
