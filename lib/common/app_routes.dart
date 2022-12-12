import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mythic_todo/features/auth/presentation/bloc/register/register_bloc.dart';

import '../di/app_module.dart';
import '../di/auth_module.dart';

import '../features/auth/presentation/cubit/on_boarding_cubit/on_boarding_cubit.dart';
import '../features/auth/presentation/cubit/splash_cubit/splash_cubit.dart';
import '../features/auth/presentation/pages/resiter/register_screen.dart';
import '../features/auth/presentation/pages/sign_in/sign_in_page.dart';
import '../features/auth/presentation/pages/on_boarding/onboarding_screen.dart';
import '../features/auth/presentation/pages/sign_up_with_email/sign_up_with_emal.dart';
import '../features/auth/presentation/pages/splash/splash_screen.dart';

class AppRoutes {
  static const String splashScreen = '/';
  static const String onBoardingScreen = 'onBoarding_screen';
  static const String signInScreen = 'signIn_screen';
  static const String registerScreen = 'register_screen';
  static const String signUpWithEmailScreen = 'sign_up_with_email_screen';

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
      case signInScreen:
        return MaterialPageRoute(builder: (_) => const SignInPage());
      case registerScreen:
        return MaterialPageRoute(
            builder: (_) => BlocProvider<RegisterBloc>(
                  create: (context) => ls<RegisterBloc>(),
                  child: const RegisterScreen(),
                ));
      case signUpWithEmailScreen:
        return MaterialPageRoute(builder: (_) => const SignUpWithEmail());
      default:
        return null;
    }
  }
}
