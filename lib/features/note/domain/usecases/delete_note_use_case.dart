import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/base_use_case.dart';
import '../repositories/note_repository.dart';

class DeleteNoteUseCase extends BaseUseCase<String, Unit?> {
  DeleteNoteUseCase({required this.repository});
  final NoteRepository repository;
  @override
  Future<Either<Failure, Unit?>> call({required String input}) {
    return repository.deleteNote(noteId: input);
  }
}
