import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../../../../../common/app_routes.dart';
import '../../../../../common/app_strings.dart';
import '../../../../../common/image_resources.dart';
import '../../../../../core/platform/utils/exetension.dart';
import '../../cubit/splash_cubit/splash_cubit.dart';
import '../../widgets/canvas_line_end_with_circle.dart';

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
      child: Scaffold(
        body: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              child: SvgPicture.asset(
                ImageResources.circleTopLeft,
                height: 20.h,
              ),
            ),
            Positioned(
              top: 11.h,
              left: 22.w,
              child: Text(
                AppStrings.moreFun,
                style: GoogleFonts.imprima(
                  fontSize: 10.sp,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
            ),
            Positioned(
              bottom: 20.h,
              right: 0,
              left: 0,
              child: Text(
                style: GoogleFonts.pacifico(
                  fontSize: 32.sp,
                  color: Theme.of(context).colorScheme.primary,
                ),
                AppStrings.appName,
                textAlign: TextAlign.center,
              ),
            ),
            Positioned(
              top: 8.h,
              right: 12.w,
              child: SvgPicture.asset(
                ImageResources.smallYellowCircle,
                height: 8.h,
              ),
            ),
            Positioned(
              top: 1.h,
              left: 10.w,
              child: SizedBox(
                height: 60.h,
                width: 1.w,
                child: CustomPaint(
                  foregroundPainter: LineEndWithCircle(
                    color: Theme.of(context).colorScheme.primary,
                    circleRadius: 7.w,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 16.h,
              right: 19.5.w,
              child: SizedBox(
                height: 40.h,
                width: 1.w,
                child: CustomPaint(
                  foregroundPainter: LineEndWithCircle(
                    color: const Color(0XFFFFDF87),
                    circleRadius: 5.w,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 37.5.h,
              left: 0,
              right: 0,
              child: SvgPicture.asset(
                width: 50.w,
                height: 50.w,
                context.isDarkMode
                    ? ImageResources.darkLogo
                    : ImageResources.lightLogo,
              ),
            ),
            Positioned(
              bottom: 5.h,
              right: 0,
              child: SvgPicture.asset(
                height: 13.w,
                ImageResources.onBoardingSmallRightLightBlueCircle,
              ),
            ),
            Positioned(
              bottom: 5.h,
              right: 0,
              left: 0,
              child: Text(
                style: GoogleFonts.actor(
                  fontSize: 12.sp,
                  color: Theme.of(context).colorScheme.onBackground,
                ),
                AppStrings.splashScreenSubTitle,
                textAlign: TextAlign.center,
              ),
            ),
          ],
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
