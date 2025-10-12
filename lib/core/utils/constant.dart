import 'package:flutter/material.dart';

void drawNotchDetails(Canvas canvas, double width, double height) {
  final centerX = width / 2;

  final effectsPaint = Paint()
    ..color = Colors.white.withValues(alpha: 0.1)
    ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8);
  canvas.drawCircle(Offset(centerX - 40, 8), 6, effectsPaint);

  canvas.drawCircle(Offset(centerX + 40, 8), 6, effectsPaint);

  final linePaint = Paint()
    ..shader = LinearGradient(
      colors: [
        Colors.transparent,
        Colors.white.withValues(alpha: 0.1),
        Colors.transparent,
      ],
    ).createShader(Rect.fromLTRB(centerX - 50, 0, centerX + 50, 5))
    ..style = PaintingStyle.stroke
    ..strokeWidth = 2
    ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 1);

  final linePath = Path()
    ..moveTo(centerX - 45, 25)
    ..quadraticBezierTo(centerX, 30, centerX + 45, 25);

  canvas.drawPath(linePath, linePaint);
}
