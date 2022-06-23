import 'package:dartz/dartz.dart';
import '../../../../../core/error/exceptions.dart';
import 'package:sqflite/sqflite.dart';

import 'entities/note_entity.dart';
import 'note_dao.dart';

class NoteDaoImpl implements NoteDao {
  NoteDaoImpl({required this.database});
  final Database database;

  @override
  Future<List<NoteEntity>> getNotes() async {
    final List<Map<String, dynamic>> notesAsMap =
        await database.query(NoteTableInfo.tableName.getName);
    if (notesAsMap.isEmpty) {
      // TODO: remove hard coded
      throw EmptyNotesDataException(message: "Empty Notes");
    } else {
      List<NoteEntity> notes =
          notesAsMap.map((noteMap) => NoteEntity.fromMap(noteMap)).toList();
      return Future.value(notes);
    }
  }

  @override
  Future<Unit> deleteNote(int noteId) async {
    final int affectedRowsCount = await database.delete(
      NoteTableInfo.tableName.getName,
      where: '${NoteTableInfo.id.getName} = ?',
      whereArgs: [noteId],
    );
    if (affectedRowsCount == 0) {
      // TODO: remove hard coded
      throw LocalDatabaseException(message: "an error occurred");
    } else {
      return Future.value(unit);
    }
  }

  @override
  Future<Unit> insertNote(NoteEntity noteEntity) async {
    final int insertedRowsCount = await database.insert(
      NoteTableInfo.tableName.getName,
      noteEntity.toMap(),
    );
    if (insertedRowsCount == 0) {
      // TODO: remove hard coded
      throw LocalDatabaseException(message: "an error occurred");
    } else {
      return Future.value(unit);
    }
  }

  @override
  Future<NoteEntity> updateNote(NoteEntity noteEntity) async {
    final int affectedRowsCount = await database.update(
      NoteTableInfo.tableName.getName,
      noteEntity.toMap(),
      where: '${NoteTableInfo.id.getName} = ?',
      whereArgs: [noteEntity.id],
    );

    if (affectedRowsCount == 0) {
      // TODO: remove hard coded
      throw LocalDatabaseException(message: "an error occurred");
    } else {
      return Future.value(noteEntity);
    }
  }
}
