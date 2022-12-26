import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mythic_todo/core/error/exceptions.dart';
import 'package:mythic_todo/core/error/failures.dart';
import 'package:mythic_todo/core/platform/worker/note_work_manager.dart';
import 'package:mythic_todo/features/note/data/data_sources/local/note_dao.dart';
import 'package:mythic_todo/features/note/data/data_sources/remote/remote_data_source.dart';
import 'package:mythic_todo/features/note/data/mapper/mapper.dart';
import 'package:mythic_todo/features/note/data/models/note_model.dart';
import 'package:mythic_todo/features/note/data/repositories/note_repository_impl.dart';
import 'package:mythic_todo/features/note/domain/entities/note.dart';
import 'package:workmanager/workmanager.dart';

class MockNoteDao extends Mock implements NoteDao {}

class MockRemoteDataSource extends Mock implements RemoteDataSource {}

class MockNoteWorkManager extends Mock implements NoteWorkManager {}

void tCallbackDispatcher() async {
  Workmanager().executeTask(
    (taskName, inputData) async {
      switch (taskName) {
        case ADD_NOTE_TASK:
          if (inputData != null) {
            await Future.value(unit);
          }
          break;
        default:
          break;
      }

      return Future.value(true);
    },
  );
}

void main() {
  late NoteRepositoryImpl repository;
  late MockNoteDao mockNoteDao;
  late MockRemoteDataSource mockRemoteDataSource;
  late MockNoteWorkManager mockNoteWorkManager;
  setUp(() async {
    mockNoteDao = MockNoteDao();
    mockRemoteDataSource = MockRemoteDataSource();
    mockNoteWorkManager = MockNoteWorkManager();

    repository = NoteRepositoryImpl(
        noteDao: mockNoteDao,
        remoteDataSource: mockRemoteDataSource,
        workmanager: mockNoteWorkManager);
  });
  group('getNotes', () {
    const List<NoteModel> tNotesModels = [
      NoteModel(
          id: '1',
          uuid: 'uuid',
          title: 'title1',
          description: 'description',
          startTime: 'startTime',
          endTime: 'endTime',
          color: NoteColor.babyBlue,
          isCompleted: true,
          reminder: true),
      NoteModel(
          id: '2',
          uuid: 'uuid',
          title: 'title2',
          description: 'description',
          startTime: 'startTime',
          endTime: 'endTime',
          color: NoteColor.babyBlue,
          isCompleted: true,
          reminder: true),
      NoteModel(
          id: '3',
          uuid: 'uuid',
          title: 'title3',
          description: 'description',
          startTime: 'startTime',
          endTime: 'endTime',
          color: NoteColor.babyBlue,
          isCompleted: true,
          reminder: true),
    ];
    final List<Note> tNotes = tNotesModels.map((e) => e.toDomain()).toList();

    test('should return notes when local data source is successfully:',
        () async {
      // arrange
      when(() => mockNoteDao.getNotes()).thenAnswer((_) async => tNotesModels);
      // act
      final result = await repository.getNotes();
      /*
      * Using fold as this is a problem with dart itself and lists, for info:
      * https://github.com/spebbe/dartz/issues/39
      * and https://stackoverflow.com/questions/10404516/how-can-i-compare-lists-for-equality-in-dart
      */
      // assert
      result.fold((left) => expect(left, null), (notes) {
        expect(listEquals(notes, tNotes), true);
      });
    });

    test(
        'should return empty local database failure when call to local data source is fail',
        () async {
      // arrange
      when(() => mockNoteDao.getNotes()).thenThrow(EmptyNotesDataException());
      // act
      final result = await repository.getNotes();
      // assert
      expect(result, Left(EmptyNotesDataFailure()));
    });
  });

  group('deleteNote', () {
    const tNoteId = '1';
    test(
        'should return unit when local data source is delete note successfully',
        () async {
      // arrange
      when(() => mockNoteDao.deleteNote(noteId: tNoteId))
          .thenAnswer((_) async => unit);
      // act
      final result = await repository.deleteNote(noteId: tNoteId);
      // assert
      expect(result, const Right(unit));
    });

    test(
        'should return local database failure when local data source fail in delete note ',
        () async {
      // arrange
      when(() => mockNoteDao.deleteNote(noteId: tNoteId))
          .thenThrow(LocalDatabaseException());
      // act
      final result = await repository.deleteNote(noteId: tNoteId);
      // assert
      expect(result, Left(LocalDatabaseFailure()));
    });
  });

  group('insertNote', () {
    const NoteModel tNoteModel = NoteModel(
      id: '2',
      uuid: 'uuid',
      title: 'title2',
      description: 'description',
      startTime: 'startTime',
      endTime: 'endTime',
      color: NoteColor.babyBlue,
      isCompleted: true,
      reminder: true,
    );
    test(
        'should return unit when local data source is insert note successfully',
        () async {
      // arrange

      when(() => mockNoteDao.insertNote(noteModel: tNoteModel))
          .thenAnswer((_) async => unit);
      when(() => mockRemoteDataSource.insertNote(noteModel: tNoteModel))
          .thenAnswer((_) async => unit);
      when(() => mockNoteWorkManager.insertNote(noteModel: tNoteModel))
          .thenAnswer((_) async => unit);
      //act
      final result = await repository.insertNote(noteModel: tNoteModel);
      // assert
      expect(result, const Right(unit));
    });

    test(
        'should return local database failure when local data source fail in insert note ',
        () async {
      // arrange
      when(() => mockNoteDao.insertNote(noteModel: tNoteModel))
          .thenThrow(LocalDatabaseException());
      // act
      final result = await repository.insertNote(noteModel: tNoteModel);
      // assert
      expect(result, Left(LocalDatabaseFailure()));
    });
  });

  group('updateNote', () {
    const NoteModel tNoteModel = NoteModel(
        id: '2',
        uuid: 'uuid',
        title: 'title2',
        description: 'description',
        startTime: 'startTime',
        endTime: 'endTime',
        color: NoteColor.babyBlue,
        isCompleted: true,
        reminder: true);

    final Note tNote = tNoteModel.toDomain();
    test(
        'should return note when local data source is update note successfully',
        () async {
      // arrange
      when(() => mockNoteDao.updateNote(noteModel: tNoteModel))
          .thenAnswer((_) async => tNoteModel);
      // act
      final result = await repository.updateNote(noteModel: tNoteModel);
      // assert
      expect(result, Right(tNote));
    });

    test(
        'should return local database failure when local data source fail in update note ',
        () async {
      // arrange
      when(() => mockNoteDao.insertNote(noteModel: tNoteModel))
          .thenThrow(LocalDatabaseException());
      // act
      final result = await repository.insertNote(noteModel: tNoteModel);
      // assert
      expect(result, Left(LocalDatabaseFailure()));
    });
  });

  group('getNote', () {
    const tNoteId = '1';
    const NoteModel tNoteModel = NoteModel(
        id: '2',
        uuid: 'uuid',
        title: 'title2',
        description: 'description',
        startTime: 'startTime',
        endTime: 'endTime',
        color: NoteColor.babyBlue,
        isCompleted: true,
        reminder: true);
    final tNote = tNoteModel.toDomain();
    test('should return note when local data source is successfully', () async {
      // arrange
      when(() => mockNoteDao.getNote(noteId: tNoteId))
          .thenAnswer((_) async => tNoteModel);
      // act
      final result = await repository.getNote(noteId: tNoteId);
      // assert
      expect(result, Right(tNote));
    });

    test(
        'should return local database not found failure when local data source fail in get note ',
        () async {
      // arrange
      when(() => mockNoteDao.getNote(noteId: tNoteId))
          .thenThrow(LocalDatabaseNotFoundException());
      // act
      final result = await repository.getNote(noteId: tNoteId);
      // assert
      expect(result, Left(LocalDatabaseNotFoundFailure()));
    });
  });
}
