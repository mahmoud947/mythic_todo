import 'package:dartz/dartz.dart';
import 'package:mythic_todo/core/error/exceptions.dart';

import 'package:mythic_todo/core/error/failures.dart';
import 'package:mythic_todo/features/note/data/data_sources/local/note_dao.dart';
import 'package:mythic_todo/features/note/data/mapper/mapper.dart';
import 'package:mythic_todo/features/note/domain/entities/note.dart';
import 'package:mythic_todo/features/note/domain/repositories/note_repository.dart';

import '../models/note_model.dart';

class NoteRepositoryImpl implements NoteRepository {
  NoteRepositoryImpl({required this.noteDao});
  final NoteDao noteDao;
  @override
  Future<Either<Failure, List<Note>>> getNotes() async {
    try {
      final localNotes = await noteDao.getNotes();
      final List<Note> notes =
          localNotes.map((localNote) => localNote.toDomain()).toList();
      return Right(notes);
    } on LocalDatabaseException catch (e) {
      return Left(LocalDatabaseFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteNote({required int noteId}) async {
    try {
      await noteDao.deleteNote(noteId: noteId);
      return const Right(unit);
    } on LocalDatabaseException catch (e) {
      return Left(LocalDatabaseFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, Unit>> insertNote({
    required NoteModel noteModel,
  }) async {
    try {
      await noteDao.insertNote(noteEntity: noteModel);
      return const Right(unit);
    } on LocalDatabaseException catch (e) {
      return Left(LocalDatabaseFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, Note>> updateNote({
    required NoteModel noteModel,
  }) async {
    try {
      final localUpdatedResult =
          await noteDao.updateNote(noteEntity: noteModel);
      return Right(localUpdatedResult.toDomain());
    } on LocalDatabaseException catch (e) {
      return Left(LocalDatabaseFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, Note>> getNote({required int noteId}) {
    // TODO: implement getNote
    throw UnimplementedError();
  }
}
