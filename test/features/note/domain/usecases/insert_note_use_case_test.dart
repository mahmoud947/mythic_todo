import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mythic_todo/features/note/data/models/note_model.dart';
import 'package:mythic_todo/features/note/domain/repositories/note_repository.dart';
import 'package:mythic_todo/features/note/domain/usecases/insert_note_use_case.dart';

class MockNoteRepository extends Mock implements NoteRepository {}

void main() {
  late InsertNoteUseCase useCase;
  late MockNoteRepository mockNoteRepository;

  setUp(() {
    mockNoteRepository = MockNoteRepository();
    useCase = InsertNoteUseCase(repository: mockNoteRepository);
  });

  const NoteModel noteModel =
      NoteModel(title: 'test title', color: NoteColor.babyBlue);

  test('should insert new note vie repository', () async {
    // arrange
    when(() => mockNoteRepository.insertNote(noteModel: noteModel))
        .thenAnswer((_) async => const Right(unit));
    // act
    final result = await useCase(input: noteModel);
    // assert
    expect(result, const Right(unit));
    verify(() => mockNoteRepository.insertNote(noteModel: noteModel));
    verifyNoMoreInteractions(mockNoteRepository);
  });
}
