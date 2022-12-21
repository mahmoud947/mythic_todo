import 'package:get_it/get_it.dart';
import 'package:mythic_todo/core/platform/database/database_factory.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

final ls = GetIt.instance;

Future<void> initAppModule() async {
  //! 3rd party
  //? ...sharedPreferences
  final prefs = await SharedPreferences.getInstance();
  ls.registerLazySingleton<SharedPreferences>(() => prefs);

  if (!GetIt.I.isRegistered<Database>()) {
    final Database database = await SqfliteFactory().instance();
    ls.registerLazySingleton<Database>(() {
      return database;
    });
  }
}
