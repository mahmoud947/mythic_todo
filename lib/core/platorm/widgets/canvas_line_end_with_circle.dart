import 'package:flutter/material.dart';

class LineEndWithCircle extends CustomPainter {
  final Color color;
  final double circleRadius;

  LineEndWithCircle({required this.color, required this.circleRadius});
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1.2;

    canvas.drawLine(const Offset(0, 0), Offset(0, size.height), paint);
    canvas.drawCircle(Offset(0, size.height), circleRadius, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
