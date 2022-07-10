import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mythic_todo/features/auth/presentation/cubit/on_boarding_cubit.dart';
import 'package:mythic_todo/features/auth/presentation/cubit/splash_cubit.dart';
import 'package:mythic_todo/features/auth/presentation/pages/onboarding_screen.dart';
import 'package:mythic_todo/features/auth/presentation/pages/splash_screen.dart';

class AppRoutes {
  static const String splashScreen = '/';
  static const String onBoardingScreen = 'onBoarding_screen';

  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splashScreen:
        return MaterialPageRoute(
            builder: (_) => BlocProvider<SplashCubit>(
                  create: (context) => SplashCubit(),
                  child: const SplashScreen(),
                ));
      case onBoardingScreen:
        return MaterialPageRoute(
            builder: (_) => BlocProvider<OnBoardingCubit>(
                  create: (context) => OnBoardingCubit(),
                  child: OnBoardingScreen(),
                ));
      default:
        return null;
    }
  }
}
