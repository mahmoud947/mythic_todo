import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../data/models/note_model.dart';
import '../repositories/note_repository.dart';

class InsertNoteUseCase {
  InsertNoteUseCase({required this.repository});
  NoteRepository repository;
  Future<Either<Failure, Unit>> call({required NoteModel noteModel}) async {
    return await repository.insertNote(noteModel: noteModel);
  }
}
