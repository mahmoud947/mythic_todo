import 'package:dartz/dartz.dart';

import '../../models/note_model.dart';

abstract class NoteDao {
  Future<List<NoteModel>> getNotes();
  Future<Unit> insertNote({required NoteModel noteModel});
  Future<Unit> deleteNote({required int noteId});
  Future<NoteModel> updateNote({required NoteModel noteModel});
  Future<NoteModel> getNote({required int noteId});
}
