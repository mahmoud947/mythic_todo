import 'package:dartz/dartz.dart';
import '../../../../core/platform/worker/note_work_manager.dart';
import '../data_sources/remote/remote_data_source.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/note.dart';
import '../../domain/repositories/note_repository.dart';
import '../data_sources/local/note_dao.dart';
import '../mapper/mapper.dart';
import '../models/note_model.dart';

class NoteRepositoryImpl implements NoteRepository {
  NoteRepositoryImpl({
    required this.noteDao,
    required this.remoteDataSource,
    required this.workmanager,
  });
  final NoteDao noteDao;
  final RemoteDataSource remoteDataSource;
  final NoteWorkManager workmanager;

  @override
  Future<Either<Failure, List<Note>>> getNotes() async {
    try {
      final localNotes = await noteDao.getNotes();
      final List<Note> notes =
          localNotes.map((localNote) => localNote.toDomain()).toList();
      return Future.value(Right(notes));
    } on EmptyNotesDataException catch (e) {
      return Future.value(Left(EmptyNotesDataFailure(message: e.message)));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteNote({required String noteId}) async {
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
      await noteDao.insertNote(noteModel: noteModel);
      await workmanager.insertNote(noteModel: noteModel);
      return const Right(unit);
    } on LocalDatabaseException catch (e) {
      return Left(LocalDatabaseFailure(message: e.message));
    } on RemoteDataSourceException catch (e) {
      return Left(RemoteDataSourceFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, Note>> updateNote({
    required NoteModel noteModel,
  }) async {
    try {
      final localUpdatedResult = await noteDao.updateNote(noteModel: noteModel);
      return Right(localUpdatedResult.toDomain());
    } on LocalDatabaseException catch (e) {
      return Left(LocalDatabaseFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, Note>> getNote({required String noteId}) async {
    try {
      final NoteModel localNoteModel = await noteDao.getNote(noteId: noteId);
      final Note note = localNoteModel.toDomain();
      return Right(note);
    } on LocalDatabaseNotFoundException catch (e) {
      return Left(LocalDatabaseNotFoundFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteAllNote() async {
    try {
      await noteDao.deleteAllNote();
      return const Right(unit);
    } on LocalDatabaseException catch (e) {
      return Left(LocalDatabaseFailure(message: e.message));
    }
  }
}
