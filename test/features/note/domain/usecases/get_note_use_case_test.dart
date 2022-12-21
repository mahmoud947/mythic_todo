import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:mocktail/mocktail.dart';
import 'package:mythic_todo/features/note/data/models/note_model.dart';
import 'package:mythic_todo/features/note/domain/entities/note.dart';
import 'package:mythic_todo/features/note/domain/repositories/note_repository.dart';
import 'package:mythic_todo/features/note/domain/usecases/get_note_use_case.dart';

class MockNoteRepository extends Mock implements NoteRepository {}

void main() {
  late MockNoteRepository mockNoteRepository;
  late GetNoteUseCase useCase;

  setUp(() {
    mockNoteRepository = MockNoteRepository();
    useCase = GetNoteUseCase(repository: mockNoteRepository);
  });
  const Note tNote = Note(
      id: '1',
      title: 'title1',
      description: 'description',
      startTime: 'startTime',
      endTime: 'endTime',
      color: NoteColor.babyBlue,
      isCompleted: true,
      reminder: true);
  test('should get note from the repository', () async {
    when(() => mockNoteRepository.getNote(noteId: '1'))
        .thenAnswer((_) async => const Right(tNote));
    final result = await useCase(input: '1');

    expect(result, const Right(tNote));

    verify(
      () => mockNoteRepository.getNote(noteId: '1'),
    );

    verifyNoMoreInteractions(mockNoteRepository);
  });
}
