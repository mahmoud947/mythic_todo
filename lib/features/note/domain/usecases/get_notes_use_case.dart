import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/base_use_case.dart';
import '../entities/note.dart';
import '../repositories/note_repository.dart';

class GetNotesUseCase implements BaseUseCase<Unit?, List<Note>> {
  GetNotesUseCase({required this.repository});
  final NoteRepository repository;

  @override
  Future<Either<Failure, List<Note>>> call({Unit? input}) async {
    return await repository.getNotes();
  }
}
