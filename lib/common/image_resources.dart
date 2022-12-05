import 'package:flutter/cupertino.dart';
import 'package:mythic_todo/core/platorm/utils/exetension.dart';

class ImageResources {
  // Application Logo
  static const String applicationLogo = 'assets/images/app_logo.svg';
  static const String lightLogo = 'assets/images/light_logo.svg';
  static const String darkLogo = 'assets/images/dark_logo.svg';

  static String getAppLogo(bool isDarkMode) =>
      isDarkMode ? darkLogo : lightLogo;
  // Splash screen
  static const String splashScreenBackground =
      'assets/images/splash_screen_background.svg';
  // onBoarding
  static const String onBoardingLogoOne =
      'assets/images/onboarding_logo_one.svg';
  static const String onBoardingLogoTwo =
      'assets/images/onboarding_logo_two.svg';
  static const String onBoardingLogoThree =
      'assets/images/onboarding_logo_three.svg';

  static const String circleTopLeft = 'assets/images/top_right_red_circle.svg';

  static const String smallYellowCircle =
      'assets/images/small_yellow_circle.svg';
  static const String smallLightBlueCircle =
      'assets/images/small_light_blue_circle.svg';
  static const String smallPinkCircle = 'assets/images/small_pink_circle.svg';

  static const String onBoardingLiftCircle =
      'assets/images/on_boarding_left_circle.svg';
  static const String onBoardingRightCircle =
      'assets/images/on_boarding_right_circle.svg';
  static const String onBoardingSmallRightLightBlueCircle =
      'assets/images/on_boarding_right_small_light_blue_circle.svg';
}
