import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/base_use_case.dart';
import '../repositories/note_repository.dart';

class DeleteAllNoteUseCase extends BaseUseCase<Unit?, Unit> {
  DeleteAllNoteUseCase({required this.repository});
  final NoteRepository repository;
  @override
  Future<Either<Failure, Unit>> call({Unit? input}) {
    return repository.deleteAllNote();
  }
}
