import 'package:dartz/dartz.dart';

import '../../data_sources/local/entity/note_entity.dart';

abstract class NoteDao {
  Future<List<NoteEntity>> getNotes();
  Future<Unit> insertNote(NoteEntity noteEntity);
  Future<Unit> deleteNote(int noteId);
  Future<NoteEntity> updateNote(NoteEntity noteEntity);
}
