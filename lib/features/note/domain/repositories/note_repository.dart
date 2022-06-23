import 'package:dartz/dartz.dart';
import 'package:mythic_todo/core/error/failures.dart';
import 'package:mythic_todo/features/note/data/data_sources/local/entities/note_entity.dart';
import 'package:mythic_todo/features/note/domain/models/note.dart';

abstract class NoteRepository {
  Future<Either<Failure, List<Note>>> getNotes();
  Future<Either<Failure, Unit>> insertNote(NoteEntity noteEntity);
  Future<Either<Failure, Unit>> deleteNote(int noteId);
  Future<Either<Failure, Note>> updateNote(NoteEntity noteEntity);
}
