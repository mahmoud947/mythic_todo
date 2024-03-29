import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../features/note/presentation/cubit/preview/preview_cubit.dart';
import '../features/note/presentation/pages/note_preview_page/note_preview_page.dart';

import '../di/app_module.dart';
import '../di/auth_module.dart';
import '../di/note_module.dart';
import '../features/auth/domain/model/user_model.dart';
import '../features/auth/presentation/bloc/register/register_bloc.dart';
import '../features/auth/presentation/bloc/sign_in/sign_in_bloc.dart';
import '../features/auth/presentation/bloc/sign_up/sign_up_bloc.dart';
import '../features/auth/presentation/cubit/on_boarding_cubit/on_boarding_cubit.dart';
import '../features/auth/presentation/cubit/splash_cubit/splash_cubit.dart';
import '../features/auth/presentation/pages/on_boarding/onboarding_screen.dart';
import '../features/auth/presentation/pages/register/register_screen.dart';
import '../features/auth/presentation/pages/sign_in/sign_in_page.dart';
import '../features/auth/presentation/pages/sign_up_with_email/sign_up_with_email.dart';
import '../features/auth/presentation/pages/splash/splash_screen.dart';
import '../features/note/presentation/bloc/add_note/add_note_bloc.dart';
import '../features/note/presentation/cubit/home/home_cubit.dart';
import '../features/note/presentation/pages/add_edit_note_page/add_edit_note_page.dart';
import '../features/note/presentation/pages/note_page/home_page.dart';

class AppRoutes {
  static const String splashScreen = '/';
  static const String onBoardingScreen = 'onBoarding_screen';
  static const String signInScreen = 'signIn_screen';
  static const String registerScreen = 'register_screen';
  static const String signUpWithEmailScreen = 'sign_up_with_email_screen';
  static const String notsScreen = 'note_screen';
  static const String addNotsScreen = 'add_note_screen';
  static const String notePreview = 'note_preview';

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
        return MaterialPageRoute(
            builder: (_) => BlocProvider<SignInBloc>(
                  create: (context) => ls<SignInBloc>(),
                  child: const SignInPage(),
                ));
      case registerScreen:
        return MaterialPageRoute(
            builder: (_) => BlocProvider<RegisterBloc>(
                  create: (context) => ls<RegisterBloc>(),
                  child: const RegisterScreen(),
                ));
      case signUpWithEmailScreen:
        return MaterialPageRoute(
            builder: (_) => BlocProvider<SignUpBloc>(
                  create: (context) => ls<SignUpBloc>(),
                  child: const SignUpWithEmailPage(),
                ));
      case notsScreen:
        initNoteModule();
        final userModel = settings.arguments as UserModel;
        return MaterialPageRoute(
          builder: (_) => BlocProvider<HomeCubit>(
            create: (context) => ls<HomeCubit>(),
            child: HomePage(
              userModel: userModel,
            ),
          ),
        );

      case addNotsScreen:
        final String? noteId = settings.arguments as String?;
        return MaterialPageRoute(
          builder: (context) => BlocProvider<AddNoteBloc>.value(
            value: ls<AddNoteBloc>(),
            child: AddNotePage(noteId: noteId),
          ),
        );
      case notePreview:
        final noteId = settings.arguments as String;
        return MaterialPageRoute(
          builder: (context) => BlocProvider<PreviewCubit>(
            create: (context) => ls<PreviewCubit>(),
            child: NotePreviewPage(noteId: noteId),
          ),
        );

      default:
        return null;
    }
  }
}
