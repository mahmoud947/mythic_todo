import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'common/app_routes.dart';
import 'features/auth/presentation/cubit/splash_cubit.dart';
import 'features/auth/presentation/pages/splash_screen.dart';

import 'common/app_themes.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(MyApp(
    appRoutes: AppRoutes(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key, required this.appRoutes}) : super(key: key);
  final AppRoutes appRoutes;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<SplashCubit>(
      create: (context) => SplashCubit(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: AppThemes.lightTheme,
        darkTheme: AppThemes.darkTheme,
        themeMode: ThemeMode.system,
        onGenerateRoute: widget.appRoutes.generateRoute,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    FlutterNativeSplash.remove();
  }
}
