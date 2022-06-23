import 'package:dartz/dartz.dart';
import 'package:mythic_todo/core/error/failures.dart';
import 'package:mythic_todo/features/note/domain/models/note.dart';

abstract class NoteRepository {
  Future<Either<Failure, List<Note>>> getNotes();
  Future<Either<Failure, Unit>> insertNote();
  Future<Either<Failure, Unit>> deleteNote();
  Future<Either<Failure, Note>> updateNote();
}
