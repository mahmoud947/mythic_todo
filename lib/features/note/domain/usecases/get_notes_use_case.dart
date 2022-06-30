import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/note.dart';
import '../repositories/note_repository.dart';

class GetNotesUseCase {
  GetNotesUseCase({required this.repository});
  final NoteRepository repository;

  Future<Either<Failure, List<Note>>> call() async {
    return await repository.getNotes();
  }
}
