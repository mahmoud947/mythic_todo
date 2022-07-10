import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mythic_todo/common/app_routes.dart';
import 'package:mythic_todo/common/app_strings.dart';
import 'package:mythic_todo/common/image_resources.dart';
import 'package:mythic_todo/features/auth/presentation/cubit/splash_cubit.dart';

import '../../../../common/app_fonts.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashCubit, SplashState>(
      listenWhen: (previous, current) => current is NavigateState,
      listener: (context, state) {
        Navigator.of(context).pushReplacementNamed(AppRoutes.onBoardingScreen);
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
