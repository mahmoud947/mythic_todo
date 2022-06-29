import 'package:dartz/dartz.dart';

import '../../models/note_model.dart';

abstract class NoteDao {
  Future<List<NoteModel>> getNotes();
  Future<Unit> insertNote({required NoteModel noteEntity});
  Future<Unit> deleteNote({required int noteId});
  Future<NoteModel> updateNote({required NoteModel noteEntity});
  Future<NoteModel> getNote({required int noteId});
}
