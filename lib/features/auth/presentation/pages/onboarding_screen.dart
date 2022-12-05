import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mythic_todo/common/app_strings.dart';
import 'package:mythic_todo/common/image_resources.dart';
import 'package:mythic_todo/core/platorm/utils/exetension.dart';
import 'package:mythic_todo/core/platorm/widgets/canvas_line_end_with_circle.dart';
import 'package:mythic_todo/core/platorm/widgets/custome_elevated_button.dart';
import 'package:sizer/sizer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../common/app_fonts.dart';
import '../../../../common/app_routes.dart';
import '../../../../core/util/extension.dart';
import '../cubit/on_boarding_cubit/on_boarding_cubit.dart';

class OnBoardingScreen extends StatelessWidget {
  OnBoardingScreen({Key? key}) : super(key: key);
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: Theme.of(context).appBarTheme.systemOverlayStyle ??
          const SystemUiOverlayStyle(),
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              PageView.builder(
                controller: _pageController,
                itemCount:
                    BlocProvider.of<OnBoardingCubit>(context).getItemCount(),
                onPageChanged: (index) {
                  BlocProvider.of<OnBoardingCubit>(context)
                      .onPageChanged(index);
                },
                itemBuilder: (_, index) {
                  return OnBoardingPage(
                    pageController: _pageController,
                  );
                },
              ),
              Positioned(
                right: 0,
                left: 0,
                bottom: 2.h,
                child: Center(
                  child: SmoothPageIndicator(
                    controller: _pageController,
                    count: BlocProvider.of<OnBoardingCubit>(context)
                        .getItemCount(),
                    effect: WormEffect(
                      dotHeight: 3.w,
                      dotWidth: 3.w,
                      activeDotColor: Theme.of(context).colorScheme.primary,
                      spacing: 16,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({Key? key, required this.pageController})
      : super(key: key);
  final PageController pageController;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OnBoardingCubit, OnBoardingState>(
        listenWhen: (previous, current) => current is OnBoardingInitial,
        listener: (context, state) {
          if (state is FinishOnBoarding) {
            pageController.dispose();
            Navigator.of(context).pushReplacementNamed(AppRoutes.authScreen);
          }
        },
        builder: (context, state) {
          if (state is OnBoardingInitial) {
            return Stack(
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
                  top: 8.h,
                  right: 12.w,
                  child: SvgPicture.asset(
                    ImageResources.smallYellowCircle,
                    height: 8.h,
                  ),
                ),
                Positioned(
                  top: 20.h,
                  left: 0,
                  right: 0,
                  child: Text(
                    state.onBoardingObject.title,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.pacifico(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 28.sp,
                    ),
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
                    state.onBoardingObject.logo,
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
                  bottom: 15.h,
                  right: 0,
                  left: 0,
                  child: Text(
                    state.onBoardingObject.subTitle,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inika(
                      fontSize: 16.sp,
                      color: Theme.of(context).colorScheme.onBackground,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 5.h,
                  right: 0,
                  left: 0,
                  child: CustomElevatedButton(
                    text: state.onBoardingObject.btnText,
                    onClick: () async {
                      pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.ease,
                      );
                    },
                  ),
                ),
              ],
            );
          } else {
            return Container();
          }
        });
  }
}

class HalfCircle extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final piant = Paint()..color = Colors.red;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
