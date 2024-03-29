import 'package:dartz/dartz.dart';
import '../../../../core/network/network_helper.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/platform/worker/note_work_manager.dart';
import '../../domain/entities/note.dart';
import '../../domain/repositories/note_repository.dart';
import '../data_sources/local/note_dao.dart';
import '../data_sources/remote/remote_data_source.dart';
import '../mapper/mapper.dart';
import '../models/note_model.dart';

class NoteRepositoryImpl implements NoteRepository {
  NoteRepositoryImpl({
    required this.noteDao,
    required this.remoteDataSource,
    required this.workmanager,
    required this.networkHelper,
  });
  final NoteDao noteDao;
  final RemoteDataSource remoteDataSource;
  final NoteWorkManager workmanager;
  final NetworkHelper networkHelper;

  @override
  Future<Either<Failure, List<Note>>> getNotes() async {
    try {
      if (await networkHelper.isConnected) {
        final remoteNotes = await remoteDataSource.getNotes();
        for (NoteModel noteModel in remoteNotes) {
          insertNote(noteModel: noteModel, insertToRemote: false);
        }
      }

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
      await workmanager.deleteNote(noteId: noteId);
      return const Right(unit);
    } on LocalDatabaseException catch (e) {
      return Left(LocalDatabaseFailure(message: e.message));
    } on RemoteDataSourceException catch (e) {
      return Left(RemoteDataSourceFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, Unit>> insertNote({
    required NoteModel noteModel,
    bool insertToRemote = true,
  }) async {
    try {
      await noteDao.insertNote(noteModel: noteModel);
      if (insertToRemote) {
        await workmanager.insertNote(noteModel: noteModel);
      }
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
      await workmanager.deleteAllNotes();
      return const Right(unit);
    } on LocalDatabaseException catch (e) {
      return Left(LocalDatabaseFailure(message: e.message));
    }
  }
}
