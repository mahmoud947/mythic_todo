import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../../common/app_colors.dart';
import '../../widgets/canvas_circle.dart';
import 'package:sizer/sizer.dart';

import '../../../../../common/app_routes.dart';
import '../../../../../common/app_strings.dart';
import '../../../../../common/image_resources.dart';
import '../../cubit/splash_cubit/splash_cubit.dart';
import '../../widgets/canvas_line_end_with_circle.dart';
import '../../widgets/over_lapping_circles.dart';
import '../../widgets/red_top_left_circle.dart';
import '../../widgets/small_yellow_circle.dart';
import '../../widgets/top_left_text.dart';
import '../../widgets/top_title.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashCubit, SplashState>(
      listener: (context, state) {
        if (state is NavigateToOnBoarding) {
          Navigator.of(context)
              .pushReplacementNamed(AppRoutes.onBoardingScreen);
        } else if (state is NavigateToHome) {
          Navigator.of(context).pushReplacementNamed(AppRoutes.signInScreen);
        }
      },
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: Theme.of(context).appBarTheme.systemOverlayStyle ??
            const SystemUiOverlayStyle(),
        child: SafeArea(
          child: Scaffold(
            body: Stack(
              children: [
                const RedTopLeftCircle(),
                const TopLeftText(),
                const TopTitle(title: AppStrings.appName),
                const SmallYellowCircle(),
                Positioned(
                  height: 11.h,
                  top: 25.h,
                  left: 50.w,
                  child: CustomPaint(
                    foregroundPainter: LineEndWithCircle(
                      color: Colors.red,
                      circleRadius: 6.w,
                    ),
                  ),
                ),
                Positioned(
                  top: 40.h,
                  left: 0,
                  right: 0,
                  child: SvgPicture.asset(
                    width: 50.w,
                    height: 50.w,
                    ImageResources.applicationLogo,
                  ),
                ),
                Positioned(
                  bottom: 12.h,
                  left: -15.w,
                  width: 50.w,
                  height: 50.w,
                  child: CustomPaint(
                    foregroundPainter: OverLappingCircles(
                      color: const Color(0XFFFFAFDF),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 25.h,
                  right: -15.w,
                  width: 50.w,
                  height: 50.w,
                  child: Transform.rotate(
                    angle: pi,
                    child: CustomPaint(
                      foregroundPainter: OverLappingCircles(
                        overLapping: 0.6,
                        color: const Color(0XFFD5CFF4),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 25.h,
                  width: 15.w,
                  height: 15.h,
                  right: -7.w,
                  child: CustomPaint(
                    foregroundPainter:
                        CanvasCircle(color: AppColors.lightPrimaryColor),
                  ),
                ),
                Positioned(
                  top: 35.h,
                  width: 15.w,
                  height: 15.h,
                  left: -7.w,
                  child: CustomPaint(
                    foregroundPainter: CanvasCircle(
                      color: AppColors.lightTurquoise,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 3.h,
                  left: 0,
                  right: 0,
                  child: Text(
                    AppStrings.splashScreenSubTitle,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class BlocTest extends StatelessWidget {
  final String text;
  const BlocTest({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Text(
        text,
        style: const TextStyle(fontSize: 44, color: Colors.black),
      ),
    );
  }
}
