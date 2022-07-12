import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mythic_todo/common/app_routes.dart';

import '../../../../common/app_fonts.dart';
import '../../../../core/util/extension.dart';
import '../cubit/splash_cubit/on_boarding_cubit/on_boarding_cubit.dart';

class OnBoardingScreen extends StatelessWidget {
  OnBoardingScreen({Key? key}) : super(key: key);
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: PageView.builder(
        controller: _pageController,
        itemCount: BlocProvider.of<OnBoardingCubit>(context).getItemCount(),
        onPageChanged: (index) {
          BlocProvider.of<OnBoardingCubit>(context).onPageChanged(index);
        },
        itemBuilder: (_, index) {
          return OnBoardingPage(
            pageController: _pageController,
          );
        },
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
            Navigator.of(context).pushReplacementNamed(AppRoutes.authScreen);
          }
        },
        builder: (context, state) {
          if (state is OnBoardingInitial) {
            return Stack(
              children: [
                SvgPicture.asset(
                  state.onBoardingObject.backGroundImage,
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                ),
                SizedBox(
                  width: double.infinity,
                  height: double.infinity,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 180),
                        SizedBox(
                          width: 320,
                          height: 152,
                          child: Text(
                            state.onBoardingObject.title,
                            style: TextStyle(
                                color:
                                    Theme.of(context).colorScheme.onSecondary,
                                fontSize: AppFontSize.h3,
                                fontFamily:
                                    AppFontConstants.pacificoFontFamily),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(height: 22),
                        SizedBox(
                          height: 187,
                          width: double.infinity,
                          child: state.onBoardingObject.logo != null
                              ? SvgPicture.asset(state.onBoardingObject.logo!)
                              : Container(),
                        ),
                        const SizedBox(height: 130),
                        SizedBox(
                          width: 400,
                          height: 68,
                          child: Text(
                            state.onBoardingObject.subTitle,
                            style: TextStyle(
                                color:
                                    Theme.of(context).colorScheme.onSecondary,
                                fontSize: AppFontSize.body1,
                                fontFamily:
                                    AppFontConstants.inconsolataFontFamily),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () async {
                            pageController.animateToPage(
                                await BlocProvider.of<OnBoardingCubit>(context)
                                    .getNextPage(),
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.ease);
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                            onPrimary: Theme.of(context).colorScheme.primary,
                            minimumSize: const Size(320, 52),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            elevation: 4,
                          ),
                          child: Text(state.onBoardingObject.btnText.orEmpty()),
                        ),
                      ],
                    ),
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
