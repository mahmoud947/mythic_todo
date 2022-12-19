import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'canvas_circle.dart';

class RedTopLeftCircle extends StatelessWidget {
  const RedTopLeftCircle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: -20.w,
      left: -20.w,
      width: 60.w,
      height: 60.w,
      child: CustomPaint(
        foregroundPainter: CanvasCircle(
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }
}
