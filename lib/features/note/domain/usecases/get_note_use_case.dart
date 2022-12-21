import 'package:dartz/dartz.dart';
import '../../../../core/usecase/base_use_case.dart';

import '../../../../core/error/failures.dart';
import '../entities/note.dart';
import '../repositories/note_repository.dart';

class GetNoteUseCase implements BaseUseCase<String, Note> {
  GetNoteUseCase({required this.repository});
  final NoteRepository repository;

  @override
  Future<Either<Failure, Note>> call({required String input}) async {
    return await repository.getNote(noteId: input);
  }
}
