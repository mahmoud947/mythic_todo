import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final ls = GetIt.instance;

Future<void> initAppModule() async {
  //! 3rd party
  //? ...sharedPreferences
  final prefs = await SharedPreferences.getInstance();
  ls.registerLazySingleton<SharedPreferences>(() => prefs);
}
