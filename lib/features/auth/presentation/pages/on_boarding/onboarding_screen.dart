import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/platform/utils/exetension.dart';
import 'package:sizer/sizer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../../common/app_routes.dart';
import '../../cubit/on_boarding_cubit/on_boarding_cubit.dart';
import 'widgets/on_boarding_view.dart';

class OnBoardingScreen extends StatelessWidget {
  OnBoardingScreen({Key? key}) : super(key: key);
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: Theme.of(context).appBarTheme.systemOverlayStyle ??
          const SystemUiOverlayStyle(),
      child: BlocListener<OnBoardingCubit, OnBoardingState>(
        listener: (_, state) {
          if (state is FinishOnBoarding) {
            _pageController.dispose();
            Navigator.of(context).pushReplacementNamed(AppRoutes.signInScreen);
          } else if (state is ErrorState) {
            context.showSnackBar(state.message);
          }
        },
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
                    return OnBoardingView(
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
      ),
    );
  }
}
