import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../../../features/note/data/models/note_model.dart';

class SqfliteFactory {
  final String createNoteTable = '''
    CREATE TABLE ${NoteTableInfo.tableName.getName} (
     ${NoteTableInfo.id.getName} TEXT NOT NULL PRIMARY KEY,
     ${NoteTableInfo.uuid.getName} TEXT NOT NULL,
     ${NoteTableInfo.title.getName} TEXT,
     ${NoteTableInfo.description.getName} TEXT,
     ${NoteTableInfo.startTime.getName} TEXT,
     ${NoteTableInfo.endTime.getName} TEXT,
     ${NoteTableInfo.color.getName} INTEGER,
     ${NoteTableInfo.isCompleted.getName} INTEGER,
     ${NoteTableInfo.reminder.getName} INTEGER,
      value INTEGER, num REAL)
    ''';
  Future<Database> instance() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'mythtic.db');
    Database database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute(createNoteTable);
        print(
            'Create Database and table==================================================');
      },
    );
    return database;
  }
}
