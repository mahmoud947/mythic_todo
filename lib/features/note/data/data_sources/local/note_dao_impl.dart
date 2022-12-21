import 'package:dartz/dartz.dart';
import 'package:sqflite/sqflite.dart';

import '../../../../../core/error/exceptions.dart';
import '../../models/note_model.dart';
import 'note_dao.dart';

class NoteDaoImpl implements NoteDao {
  NoteDaoImpl({required this.database});
  final Database database;

  @override
  Future<List<NoteModel>> getNotes() async {
    final List<Map<String, dynamic>> notesAsMap = await database.query(
      NoteTableInfo.tableName.getName,
      orderBy: '${NoteTableInfo.startTime.getName} DESC',
    );
    if (notesAsMap.isEmpty) {
      // TODO: remove hard coded
      throw EmptyNotesDataException(message: 'Empty Notes');
    } else {
      List<NoteModel> notes =
          notesAsMap.map((noteMap) => NoteModel.fromMap(noteMap)).toList();
      return Future.value(notes);
    }
  }

  @override
  Future<Unit> deleteNote({required String noteId}) async {
    final int affectedRowsCount = await database.delete(
      NoteTableInfo.tableName.getName,
      where: '${NoteTableInfo.id.getName} = ?',
      whereArgs: [noteId],
    );
    if (affectedRowsCount == 0) {
      // TODO: remove hard coded
      throw LocalDatabaseException(message: 'an error occurred');
    } else {
      return Future.value(unit);
    }
  }

  @override
  Future<Unit> deleteAllNote() async {
    final int affectedRowsCount =
        await database.delete(NoteTableInfo.tableName.getName);
    if (affectedRowsCount == 0) {
      throw LocalDatabaseException(message: 'an error occurred');
    } else {
      return Future.value(unit);
    }
  }

  @override
  Future<Unit> insertNote({required NoteModel noteModel}) async {
    final int insertedRowsCount = await database.insert(
      NoteTableInfo.tableName.getName,
      noteModel.toMap(),
    );
    if (insertedRowsCount == 0) {
      // TODO: remove hard coded
      throw LocalDatabaseException(message: 'an error occurred');
    } else {
      return Future.value(unit);
    }
  }

  @override
  Future<NoteModel> updateNote({required NoteModel noteModel}) async {
    final int affectedRowsCount = await database.update(
      NoteTableInfo.tableName.getName,
      noteModel.toMap(),
      where: '${NoteTableInfo.id.getName} = ?',
      whereArgs: [noteModel.id],
    );

    if (affectedRowsCount == 0) {
      // TODO: remove hard coded
      throw LocalDatabaseException(message: 'an error occurred');
    } else {
      return Future.value(noteModel);
    }
  }

  @override
  Future<NoteModel> getNote({required String noteId}) async {
    final List<Map<String, dynamic>> noteAsMap = await database.query(
        NoteTableInfo.tableName.getName,
        where: '${NoteTableInfo.id} = ?',
        whereArgs: [noteId]);
    if (noteAsMap.isEmpty) {
      // TODO: remove hard coded
      throw LocalDatabaseNotFoundException(message: 'Notes not found');
    } else {
      final NoteModel note = NoteModel.fromMap(noteAsMap.first);
      return Future.value(note);
    }
  }
}
