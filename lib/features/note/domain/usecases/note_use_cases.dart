import 'delete_all_note_use_case.dart';

import 'get_note_use_case.dart';
import 'get_notes_use_case.dart';
import 'insert_note_use_case.dart';

class NoteUseCases {
  NoteUseCases({
    required this.getNoteUseCase,
    required this.insertNoteUseCase,
    required this.getNotesUseCase,
    required this.deleteAllNoteUseCase,
  });
  final GetNoteUseCase getNoteUseCase;
  final InsertNoteUseCase insertNoteUseCase;
  final GetNotesUseCase getNotesUseCase;
  final DeleteAllNoteUseCase deleteAllNoteUseCase;
}
