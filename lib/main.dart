import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/note/presentation/cubit/on_boarding_cubit.dart';
import 'features/note/presentation/screens/onboarding_screen.dart';

import 'common/app_themes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: AppThemes.lightTheme,
      darkTheme: AppThemes.darkTheme,
      themeMode: ThemeMode.system,
      home: BlocProvider<OnBoardingCubit>(
          create: (context) => OnBoardingCubit(), child: OnBoardingScreen()),
    );
  }
}
