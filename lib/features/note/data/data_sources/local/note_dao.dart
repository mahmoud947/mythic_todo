import 'package:dartz/dartz.dart';

import 'entities/note_entity.dart';

abstract class NoteDao {
  Future<List<NoteEntity>> getNotes();
  Future<Unit> insertNote({required NoteEntity noteEntity});
  Future<Unit> deleteNote({required int noteId});
  Future<NoteEntity> updateNote({required NoteEntity noteEntity});
}
