import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

import '../core/network/network_helper.dart';
import '../core/network/network_helper_impl.dart';
import '../core/platform/database/database_factory.dart';

final ls = GetIt.instance;

Future<void> initAppModule() async {
  //! 3rd party
  //? ...sharedPreferences
  final prefs = await SharedPreferences.getInstance();
  ls.registerLazySingleton<SharedPreferences>(() => prefs);

  //? ...sqflite
  if (!GetIt.I.isRegistered<Database>()) {
    final Database database = await SqfliteFactory().instance();
    ls.registerLazySingleton<Database>(() {
      return database;
    });
  }

  //? ...InternetConnectionChecker
  ls.registerLazySingleton<InternetConnectionChecker>(
      () => InternetConnectionChecker());

  //! ...networkHelper
  ls.registerLazySingleton<NetworkHelper>(
    () => NetworkHelperImpl(connectionChecker: ls()),
  );
}
