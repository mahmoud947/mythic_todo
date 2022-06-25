import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mythic_todo/features/note/data/data_sources/local/entities/note_entity.dart';
import 'package:mythic_todo/features/note/domain/models/note.dart';
import 'package:mythic_todo/features/note/domain/repositories/note_repository.dart';
import 'package:mythic_todo/features/note/domain/usecases/get_notes_use_case.dart';

class MockNoteRepository extends Mock implements NoteRepository {}

void main() {
  late GetNotesUseCase useCase;
  late MockNoteRepository mockNoteRepository;

  setUp(() {
    mockNoteRepository = MockNoteRepository();
    useCase = GetNotesUseCase(repository: mockNoteRepository);
  });

  const List<Note> tNotes = [
    Note(
        id: 1,
        title: 'title1',
        description: 'description',
        startTime: 'startTime',
        endTime: 'endTime',
        color: NoteColor.babyBlue,
        isCompleted: true,
        reminder: true),
    Note(
        id: 2,
        title: 'title2',
        description: 'description',
        startTime: 'startTime',
        endTime: 'endTime',
        color: NoteColor.babyBlue,
        isCompleted: true,
        reminder: true),
    Note(
        id: 3,
        title: 'title3',
        description: 'description',
        startTime: 'startTime',
        endTime: 'endTime',
        color: NoteColor.babyBlue,
        isCompleted: true,
        reminder: true)
  ];

  test('should get all notes from the repository', () async {
    //arrange
    when(() => mockNoteRepository.getNotes())
        .thenAnswer((_) async => const Right(tNotes));

    final result = await useCase();
    expect(result, const Right(tNotes));
    verify(() => mockNoteRepository.getNotes());
    verifyNoMoreInteractions(mockNoteRepository);
  });
}
