import 'package:dartz/dartz.dart';
import 'package:mythic_todo/core/error/failures.dart';
import 'package:mythic_todo/features/note/domain/entities/note.dart';

import '../../data/models/note_model.dart';

abstract class NoteRepository {
  Future<Either<Failure, List<Note>>> getNotes();
  Future<Either<Failure, Unit>> insertNote({required NoteModel noteEntity});
  Future<Either<Failure, Unit>> deleteNote({required int noteId});
  Future<Either<Failure, Note>> updateNote({required NoteModel noteEntity});
  Future<Either<Failure, Note>> getNote({required int noteId});
}
