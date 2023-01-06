import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../../../../../../common/image_resources.dart';
import '../../../../../../core/platform/widgets/custom_elevated_button.dart';
import '../../../cubit/on_boarding_cubit/on_boarding_cubit.dart';
import '../../../widgets/canvas_line_end_with_circle.dart';
import '../../../widgets/red_top_left_circle.dart';
import '../../../widgets/small_yellow_circle.dart';
import '../../../widgets/top_left_text.dart';
import '../../../widgets/top_title.dart';

class OnBoardingView extends StatelessWidget {
  const OnBoardingView({Key? key, required this.pageController})
      : super(key: key);
  final PageController pageController;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnBoardingCubit, OnBoardingState>(
      builder: (_, state) {
        if (state is OnBoardingInitial) {
          return Stack(
            children: [
              const RedTopLeftCircle(),
              const TopLeftText(),
              const SmallYellowCircle(),
              TopTitle(title: state.onBoardingObject.title),
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
                top: 12.h,
                right: 18.5.w,
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
                    fontSize: 14.sp,
                    color: Theme.of(context).colorScheme.onBackground,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Positioned(
                bottom: 6.h,
                right: 0,
                left: 0,
                child: CustomElevatedButton(
                  text: state.onBoardingObject.btnText,
                  onClick: () async {
                    pageController.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.ease,
                    );
                    context.read<OnBoardingCubit>().getNextPage();
                  },
                ),
              ),
            ],
          );
        } else {
          return Container();
        }
      },
    );
  }
}
