import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../di/auth_module.dart';
import '../features/auth/presentation/pages/auth_page.dart';

import '../di/app_module.dart';
import '../features/auth/presentation/cubit/on_boarding_cubit.dart';
import '../features/auth/presentation/cubit/splash_cubit.dart';
import '../features/auth/presentation/pages/onboarding_screen.dart';
import '../features/auth/presentation/pages/splash_screen.dart';

class AppRoutes {
  static const String splashScreen = '/';
  static const String onBoardingScreen = 'onBoarding_screen';
  static const String authScreen = 'auth_screen';

  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splashScreen:
        initAuthModule();
        return MaterialPageRoute(
            builder: (_) => BlocProvider<SplashCubit>(
                  create: (context) => ls<SplashCubit>(),
                  child: const SplashScreen(),
                ));
      case onBoardingScreen:
        return MaterialPageRoute(
            builder: (_) => BlocProvider<OnBoardingCubit>(
                  create: (context) => ls<OnBoardingCubit>(),
                  child: OnBoardingScreen(),
                ));
      case authScreen:
        return MaterialPageRoute(builder: (_) => const AuthPage());
      default:
        return null;
    }
  }
}
