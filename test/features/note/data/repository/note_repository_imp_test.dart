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
        'should return local database failure when call to local data source is fail',
        () async {
      // arrange
      when(() => mockNoteDao.getNotes()).thenThrow(LocalDatabaseException());
      // act
      final result = await repository.getNotes();
      // assert
      result.fold((failure) {
        expect(failure, LocalDatabaseFailure());
        print(LocalDatabaseFailure().message);
      }, (_) => null);
    });
  });
}
