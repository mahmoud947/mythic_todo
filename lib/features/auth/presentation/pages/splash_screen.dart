import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../common/app_fonts.dart';
import '../../../../common/app_routes.dart';
import '../../../../common/app_strings.dart';
import '../../../../common/image_resources.dart';
import '../cubit/splash_cubit/splash_cubit.dart';

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
          Navigator.of(context).pushReplacementNamed(AppRoutes.authScreen);
        }
      },
      child: Scaffold(
        body: Stack(
          children: [
            SvgPicture.asset(
              ImageResources.splashScreenBackground,
              fit: BoxFit.cover,
            ),
            Align(
              child: SvgPicture.asset(ImageResources.applicationLogo),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  AppStrings.splashScreenSubTitle,
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.onSecondary,
                      fontSize: AppFontSize.body1,
                      fontFamily: AppFontConstants.pacificoFontFamily),
                  textAlign: TextAlign.center,
                ),
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
