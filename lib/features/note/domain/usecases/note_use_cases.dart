import 'package:mythic_todo/features/note/domain/usecases/get_note_use_case.dart';
import 'package:mythic_todo/features/note/domain/usecases/get_notes_use_case.dart';
import 'package:mythic_todo/features/note/domain/usecases/insert_note_use_case.dart';

class NoteUseCases {
  NoteUseCases({
    required this.getNoteUseCase,
    required this.insertNoteUseCase,
    required this.getNotesUseCase,
  });
  final GetNoteUseCase getNoteUseCase;
  final InsertNoteUseCase insertNoteUseCase;
  final GetNotesUseCase getNotesUseCase;
}
