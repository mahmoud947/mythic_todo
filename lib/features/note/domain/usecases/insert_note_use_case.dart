import 'package:dartz/dartz.dart';
import 'package:mythic_todo/core/usecase/base_use_case.dart';

import '../../../../core/error/failures.dart';
import '../../data/models/note_model.dart';
import '../repositories/note_repository.dart';

class InsertNoteUseCase implements BaseUseCase<NoteModel, Unit> {
  InsertNoteUseCase({required this.repository});
  NoteRepository repository;
  @override
  Future<Either<Failure, Unit>> call({required NoteModel input}) async {
    return await repository.insertNote(noteModel: input);
  }
}
