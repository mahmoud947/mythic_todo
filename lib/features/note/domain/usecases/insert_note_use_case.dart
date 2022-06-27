import 'package:dartz/dartz.dart';

import 'package:mythic_todo/core/error/failures.dart';
import 'package:mythic_todo/features/note/data/models/note_model.dart';
import 'package:mythic_todo/features/note/domain/repositories/note_repository.dart';

class InsertNoteUseCase {
  InsertNoteUseCase({required this.repository});
  NoteRepository repository;
  Future<Either<Failure, Unit>> call({required NoteModel noteModel}) async {
    return await repository.insertNote(noteModel: noteModel);
  }
}
