import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mythic_todo/core/error/exceptions.dart';
import 'package:mythic_todo/core/error/failures.dart';
import 'package:mythic_todo/features/note/data/data_sources/local/note_dao.dart';
import 'package:mythic_todo/features/note/data/mapper/mapper.dart';
import 'package:mythic_todo/features/note/data/models/note_model.dart';
import 'package:mythic_todo/features/note/data/repositories/note_repository_impl.dart';
import 'package:mythic_todo/features/note/domain/entities/note.dart';

class MockNoteDao extends Mock implements NoteDao {}

void main() {
  late NoteRepositoryImpl repository;
  late MockNoteDao mockNoteDao;

  setUp(() {
    mockNoteDao = MockNoteDao();
    repository = NoteRepositoryImpl(noteDao: mockNoteDao);
  });
  group('getNotes', () {
    const List<NoteModel> tNotesModels = [
      NoteModel(
          id: 1,
          title: 'title1',
          description: 'description',
          startTime: 'startTime',
          endTime: 'endTime',
          color: NoteColor.babyBlue,
          isCompleted: true,
          reminder: true),
      NoteModel(
          id: 2,
          title: 'title2',
          description: 'description',
          startTime: 'startTime',
          endTime: 'endTime',
          color: NoteColor.babyBlue,
          isCompleted: true,
          reminder: true),
      NoteModel(
          id: 3,
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

      // assert
      result.fold((_) => null, (notes) {
        expect(notes, tNotes);
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
      result.fold(
          (failure) => expect(failure, EmptyNotesDataFailure()), (_) => null);
    });
  });

  group('deleteNote', () {
    const tNoteId = 1;
    test(
        'should return unit when local data source is delete note successfully',
        () async {
      // arrange
      when(() => mockNoteDao.deleteNote(noteId: tNoteId))
          .thenAnswer((_) async => unit);
      // act
      final result = await repository.deleteNote(noteId: tNoteId);
      // assert
      result.fold((_) => null, (success) => expect(success, unit));
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
      result.fold(
          (failure) => expect(failure, LocalDatabaseFailure()), (_) => null);
    });
  });

  group('insertNote', () {
    const NoteModel tNoteModel = NoteModel(
        id: 2,
        title: 'title2',
        description: 'description',
        startTime: 'startTime',
        endTime: 'endTime',
        color: NoteColor.babyBlue,
        isCompleted: true,
        reminder: true);
    test(
        'should return unit when local data source is insert note successfully',
        () async {
      // arrange
      when(() => mockNoteDao.insertNote(noteEntity: tNoteModel))
          .thenAnswer((_) async => unit);
      // act
      final result = await repository.insertNote(noteModel: tNoteModel);
      // assert
      result.fold((_) => null, (success) => expect(success, unit));
    });

    test(
        'should return local database failure when local data source fail in insert note ',
        () async {
      // arrange
      when(() => mockNoteDao.insertNote(noteEntity: tNoteModel))
          .thenThrow(LocalDatabaseException());
      // act
      final result = await repository.insertNote(noteModel: tNoteModel);
      // assert
      result.fold(
          (failure) => expect(failure, LocalDatabaseFailure()), (_) => null);
    });
  });

  group('updateNote', () {
    const NoteModel tNoteModel = NoteModel(
        id: 2,
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
      when(() => mockNoteDao.updateNote(noteEntity: tNoteModel))
          .thenAnswer((_) async => tNoteModel);
      // act
      final result = await repository.updateNote(noteModel: tNoteModel);
      // assert
      result.fold((_) => null, (note) => expect(note, tNote));
    });

    test(
        'should return local database failure when local data source fail in update note ',
        () async {
      // arrange
      when(() => mockNoteDao.insertNote(noteEntity: tNoteModel))
          .thenThrow(LocalDatabaseException());
      // act
      final result = await repository.insertNote(noteModel: tNoteModel);
      // assert
      result.fold(
          (failure) => expect(failure, LocalDatabaseFailure()), (_) => null);
    });
  });

  group('getNote', () {
    const tNoteId = 1;
    const NoteModel tNoteModel = NoteModel(
        id: 2,
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
      result.fold((_) => null, (note) => expect(note, tNote));
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
      result.fold((failure) => expect(failure, LocalDatabaseNotFoundFailure()),
          (_) => null);
    });
  });
}
