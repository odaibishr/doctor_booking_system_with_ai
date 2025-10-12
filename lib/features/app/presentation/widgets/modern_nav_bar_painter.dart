import 'dart:math';

import 'package:doctor_booking_system_with_ai/core/utils/constant.dart';
import 'package:flutter/material.dart';

class ModernNavBarPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final height = size.height;
    final width = size.width;

    final mainPaint = Paint()
      ..color = const Color(0xFF364989)
      ..style = PaintingStyle.fill;

    final shadowPaint = Paint()
      ..color = Colors.black.withValues(alpha: 0.25)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 20)
      ..style = PaintingStyle.fill;

    final path = Path();
    final borderRadius = 30.0;
    final notchRadius = 25.0;
    final fabWidth = 70.0;

    path.moveTo(borderRadius, height);

    path.quadraticBezierTo(0, height, 0, height - borderRadius);

    path.lineTo(0, borderRadius);
    path.quadraticBezierTo(0, 0, borderRadius, 0);

    path.lineTo(width / 2 - fabWidth / 2 - 10, 0);

    path.quadraticBezierTo(
      width / 2 - fabWidth / 2,
      0,
      width / 2 - fabWidth / 2,
      10,
    );

    path.arcTo(
      Rect.fromCircle(center: Offset(width / 2, 15), radius: notchRadius),
      -pi,
      pi,
      false,
    );

    path.quadraticBezierTo(
      width / 2 + fabWidth / 2,
      10,
      width / 2 + fabWidth / 2,
      0,
    );
    path.quadraticBezierTo(
      width / 2 + fabWidth / 2 + 10,
      0,
      width / 2 + fabWidth / 2 + 15,
      0,
    );

    path.lineTo(width - borderRadius, 0);
    path.quadraticBezierTo(width, 0, width, borderRadius);

    path.lineTo(width, height - borderRadius);
    path.quadraticBezierTo(width, height, width - borderRadius, height);

    path.lineTo(borderRadius, height);
    path.close();

    final shadowPath = Path()..addPath(path, Offset(0, 3));
    canvas.drawPath(shadowPath, shadowPaint);

    canvas.drawPath(path, mainPaint);

    final borderPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.2)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 2);

    canvas.drawPath(path, borderPaint);

    final innerHighlightPath = Path()
      ..moveTo(20, 2)
      ..lineTo(width / 2 - fabWidth / 2 - 5, 2)
      ..moveTo(width / 2 + fabWidth / 2 + 5, 2)
      ..lineTo(width - 20, 2);

    final innerHighlightPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 1);

    canvas.drawPath(innerHighlightPath, innerHighlightPaint);

    drawNotchDetails(canvas, width, height);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
