import 'package:dartz/dartz.dart';
import 'package:mythic_todo/core/error/failures.dart';
import 'package:mythic_todo/features/note/domain/models/note.dart';
import 'package:mythic_todo/features/note/domain/repositories/note_repository.dart';

class GetNotesUseCase {
  GetNotesUseCase({required this.repository});
  final NoteRepository repository;

  Future<Either<Failure, List<Note>>> call() async {
    return await repository.getNotes();
  }
}
