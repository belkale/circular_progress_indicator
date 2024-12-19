import 'package:flutter/material.dart';
import 'dart:math';

class CircularProgressGradient extends StatelessWidget {
  final double progress;
  final double size;
  final double strokeWidth;
  final Color color;
  final Color backgroundColor;
  final Widget overlayWidget;

  const CircularProgressGradient({super.key,
    required this.progress,
    required this.color,
    required this.overlayWidget,
    this.size = 80,
    this.strokeWidth = 15,
    this.backgroundColor = const Color(0xFF656565)
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
        alignment: Alignment.center,
      children: [
        SizedBox(
          width: size,
          height: size,
          child: CustomPaint(
            painter: GradientPainter(
              progress: progress,
              strokeWidth: strokeWidth,
              color: color,
              backgroundColor: backgroundColor,
            ),
          ),
        ),
        overlayWidget
      ]
    );
  }
}

class GradientPainter extends CustomPainter {
  final double progress;
  final double strokeWidth;
  final Color color;
  final Color backgroundColor;

  GradientPainter({
    required this.progress,
    required this.strokeWidth,
    required this.color,
    required this.backgroundColor,
  });

  /// Function to generate a lighter and darker shade of a given color
  /// Function to generate a lighter and darker shade of a given color
  Color generateShadowColor(Color baseColor, {double darknessFactor = 0.4}) {
    // Convert the base color to HSL
    final HSLColor hslColor = HSLColor.fromColor(baseColor);

    // Generate darker color
    final HSLColor darkerHSL = hslColor.withLightness((hslColor.lightness - darknessFactor).clamp(0.0, 1.0));
    final Color darkerColor = darkerHSL.toColor();

    return darkerColor;
  }

  int countDots(double progress) {
    return progress.floor();
  }
  @override
  void paint(Canvas canvas, Size size) {
    double value = progress;
    double rotation = 0.0;
    if (progress > 1.0) {
      value = 1.0;
      rotation = progress - value;
    }

    final double radius = (size.width - strokeWidth) / 2;
    final Offset center = Offset(size.width / 2, size.height / 2);

    final double delta = 2*pi*rotation;
    final double startAngle = -pi / 2;
    final double sweepAngle = 2 * pi * value;
    final double endAngle = sweepAngle + startAngle;
    final shadowColor = generateShadowColor(color);

    final Paint backgroundPaint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;
    canvas.drawCircle(center, radius, backgroundPaint);

    final Rect gradientRect = Rect.fromCircle(center: center, radius: radius);

    // Draw progress arc
    if (value > 0.0001) {
      final SweepGradient gradient = SweepGradient(
          startAngle: -pi/2,
          endAngle: endAngle,
          colors: [shadowColor, color],
          transform: GradientRotation(- pi/2 + delta)
      );

      final Paint progressPaint = Paint()
        ..color = color
        ..shader = gradient.createShader(gradientRect)
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.butt;
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        sweepAngle,
        false,
        progressPaint,
      );
    }

    // Draw end cap
    if (progress >= 1.0) {
      final Paint endCapPaint = Paint()
        ..color = color
        ..style = PaintingStyle.fill;

      final double endAngle = -pi/2 + delta;
      final Offset endCapCenter = Offset(
        center.dx + radius * cos(endAngle),
        center.dy + radius * sin(endAngle),
      );

      // canvas.drawCircle(endCapCenter, strokeWidth / 2, endCapPaint);
      // Semi-circle radius and start angle
      final double semiCircleRadius = strokeWidth / 2;
      final double semiCircleStartAngle = endAngle;

      // Draw the semi-circle
      canvas.drawArc(
        Rect.fromCircle(center: endCapCenter, radius: semiCircleRadius),
        semiCircleStartAngle,
        pi,
        true,
        endCapPaint,
      );
      for(int i = 0; i < countDots(progress); i++) {
        final Paint dotPaint = Paint()
          ..color = Colors.black
          ..style = PaintingStyle.fill;
        final Offset dotCenter = Offset(
          center.dx + radius * cos(endAngle - 0.2*i),
          center.dy + radius * sin(endAngle - 0.2*i),
        );
        canvas.drawCircle(dotCenter, strokeWidth / 2 - 5, dotPaint);
      }

    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true; // Repaint when progress changes
  }
}