import 'package:flutter_test/flutter_test.dart';
import 'package:mythic_todo/features/note/data/mapper/mapper.dart';
import 'package:mythic_todo/features/note/data/models/note_model.dart';
import 'package:mythic_todo/features/note/domain/entities/note.dart';

void main() {
  const List<NoteModel> notesModels = [
    NoteModel(
        id: '1',
        uuid: 'uuid',
        title: 'title',
        description: 'description',
        startTime: 'startTime',
        endTime: 'endTime',
        color: NoteColor.babyBlue,
        isCompleted: true,
        reminder: true)
  ];
  const List<Note> notes = [
    Note(
        id: '1',
        title: 'title',
        description: 'description',
        startTime: 'startTime',
        endTime: 'endTime',
        color: NoteColor.babyBlue,
        isCompleted: true,
        reminder: true)
  ];

  test('should return list of note from noteModel', () {
    final result = notesModels.map((e) => e.toDomain()).toList();

    expect(result, notes);
  });
}
