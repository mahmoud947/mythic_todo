import 'package:get_it/get_it.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

import '../features/note/data/models/note_model.dart';

final ls = GetIt.instance;

Future<void> initAppModule() async {
  //! 3rd party
  //? ...sharedPreferences
  final prefs = await SharedPreferences.getInstance();
  ls.registerLazySingleton<SharedPreferences>(() => prefs);

  //? ...sqflite database
  ls.registerSingletonAsync<Database>(() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'mythtic.db');
    Database database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
    CREATE TABLE ${NoteTableInfo.tableName.getName} (
     ${NoteTableInfo.id.getName} TEXT NOT NULL PRIMARY KEY,
     ${NoteTableInfo.title.getName} TEXT,
     ${NoteTableInfo.description.getName} TEXT,
     ${NoteTableInfo.startTime.getName} TEXT,
     ${NoteTableInfo.endTime.getName} TEXT,
     ${NoteTableInfo.color.getName} INTEGER,
     ${NoteTableInfo.isCompleted.getName} INTEGER,
     ${NoteTableInfo.reminder.getName} INTEGER,
      value INTEGER, num REAL)
    ''');
        print(
            'Create Database and table==================================================');
      },
    );
    return database;
  });
}
