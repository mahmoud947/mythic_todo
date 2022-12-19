import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';
import 'package:sizer/sizer.dart';

import 'common/app_routes.dart';
import 'common/app_themes.dart';
import 'di/app_module.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await di.initAppModule();
  runApp(MyApp(
    appRoutes: AppRoutes(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.appRoutes}) : super(key: key);
  final AppRoutes appRoutes;

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: AppThemes.lightTheme,
        darkTheme: AppThemes.darkTheme,
        themeMode: ThemeMode.system,
        //home: const NotePage(),
        onGenerateRoute: appRoutes.generateRoute,
        //test
      );
    });
  }
}
