import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

/// Jauge circulaire (style compteur du logo) avec effet de profondeur.
class ConsumptionGauge extends StatelessWidget {
  const ConsumptionGauge({
    super.key,
    required this.value,
    required this.maxValue,
    required this.unit,
    required this.label,
    this.size = 200,
  });

  /// Valeur courante (ex : consommation L/100km).
  final double value;
  final double maxValue;
  final String unit;
  final String label;
  final double size;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final ratio = maxValue <= 0 ? 0.0 : (value / maxValue).clamp(0.0, 1.0);

    return SizedBox(
      width: size,
      height: size,
      child: TweenAnimationBuilder<double>(
        tween: Tween(begin: 0, end: ratio),
        duration: const Duration(milliseconds: 900),
        curve: Curves.easeOutCubic,
        builder: (context, animatedRatio, _) {
          return CustomPaint(
            painter: _GaugePainter(
              ratio: animatedRatio,
              trackColor: (theme.brightness == Brightness.dark
                      ? Colors.white
                      : AppColors.navyBlue)
                  .withValues(alpha: 0.08),
            ),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    value.toStringAsFixed(1),
                    style: theme.textTheme.displaySmall?.copyWith(
                      fontWeight: FontWeight.w800,
                      color: AppColors.emerald,
                    ),
                  ),
                  Text(
                    unit,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.textTheme.bodyMedium?.color
                          ?.withValues(alpha: 0.7),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    label,
                    textAlign: TextAlign.center,
                    style: theme.textTheme.labelSmall?.copyWith(
                      letterSpacing: 1,
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

class _GaugePainter extends CustomPainter {
  _GaugePainter({required this.ratio, required this.trackColor});

  final double ratio;
  final Color trackColor;

  // L'arc va de 135° à 405° (270° utiles), comme un compteur.
  static const double _startAngle = math.pi * 0.75;
  static const double _sweepAngle = math.pi * 1.5;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 14;
    final rect = Rect.fromCircle(center: center, radius: radius);

    // Piste de fond
    final trackPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 16
      ..strokeCap = StrokeCap.round
      ..color = trackColor;
    canvas.drawArc(rect, _startAngle, _sweepAngle, false, trackPaint);

    // Arc de progression dégradé
    final progressPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 16
      ..strokeCap = StrokeCap.round
      ..shader = const SweepGradient(
        startAngle: _startAngle,
        endAngle: _startAngle + _sweepAngle,
        colors: [AppColors.emerald, AppColors.warning, AppColors.orange],
        stops: [0.0, 0.6, 1.0],
        transform: GradientRotation(_startAngle),
      ).createShader(rect);
    canvas.drawArc(
        rect, _startAngle, _sweepAngle * ratio, false, progressPaint);

    // Aiguille
    final needleAngle = _startAngle + _sweepAngle * ratio;
    final needleEnd = Offset(
      center.dx + (radius - 6) * math.cos(needleAngle),
      center.dy + (radius - 6) * math.sin(needleAngle),
    );
    final needlePaint = Paint()
      ..color = AppColors.orange
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(center, needleEnd, needlePaint);
    canvas.drawCircle(center, 7, Paint()..color = AppColors.orange);
    canvas.drawCircle(
        center, 3, Paint()..color = Colors.white.withValues(alpha: 0.9));
  }

  @override
  bool shouldRepaint(covariant _GaugePainter oldDelegate) =>
      oldDelegate.ratio != ratio || oldDelegate.trackColor != trackColor;
}
