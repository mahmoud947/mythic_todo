import 'package:flutter/material.dart';
import '../../../../common/app_colors.dart';
import 'canvas_circle.dart';
import 'package:sizer/sizer.dart';

class SmallYellowCircle extends StatelessWidget {
  const SmallYellowCircle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: 8.h,
        right: 12.w,
        height: 15.w,
        width: 15.w,
        child: CustomPaint(
          foregroundPainter: CanvasCircle(color: AppColors.lightYellow),
        ));
  }
}
