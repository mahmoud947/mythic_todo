import 'dart:math';

import 'package:flutter/material.dart';

class OverLappingCircles extends CustomPainter {
  OverLappingCircles({required this.color, this.overLapping});
  final Color color;
  final double? overLapping;
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    final firstCircleRect = Rect.fromCenter(
      center: Offset(size.height / 2, size.width / 2),
      height: size.height,
      width: size.width,
    );

    final secondCircleRect = Rect.fromCenter(
      center: Offset(
          (size.height / 2) * 0.7, (size.width / 2) * (overLapping ?? 1.4)),
      height: size.height,
      width: size.width,
    );
    canvas.drawArc(
      firstCircleRect,
      pi / 2,
      pi,
      false,
      paint,
    );
    canvas.drawArc(
      secondCircleRect,
      (pi / 2) * 3,
      pi,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
