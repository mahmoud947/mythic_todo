import 'package:dartz/dartz.dart';

import '../../models/note_model.dart';

abstract class RemoteDataSource {
  Future<List<NoteModel>> getNotes();
  Future<Unit> insertNote({required NoteModel noteModel});
  Future<Unit> deleteNote({required String noteId});
  Future<Unit> deleteAllNote();
  Future<NoteModel> updateNote({required NoteModel noteModel});
  Future<NoteModel> getNote({required String noteId});
}
