import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/note.dart';
import '../repositories/note_repository.dart';

class GetNoteUseCase {
  GetNoteUseCase({required this.repository});
  final NoteRepository repository;

  Future<Either<Failure, Note>> call({required int noteId}) async {
    return await repository.getNote(noteId: noteId);
  }
}
