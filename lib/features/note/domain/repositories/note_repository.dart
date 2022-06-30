import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../data/models/note_model.dart';
import '../entities/note.dart';

abstract class NoteRepository {
  Future<Either<Failure, List<Note>>> getNotes();
  Future<Either<Failure, Unit>> insertNote({required NoteModel noteModel});
  Future<Either<Failure, Unit>> deleteNote({required int noteId});
  Future<Either<Failure, Note>> updateNote({required NoteModel noteModel});
  Future<Either<Failure, Note>> getNote({required int noteId});
}
