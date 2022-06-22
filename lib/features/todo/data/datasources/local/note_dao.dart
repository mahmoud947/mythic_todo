import 'package:mythic_todo/features/todo/data/datasources/local/entity/note_entity.dart';

abstract class NoteDao {
  Future<List<NoteEntity>> getNotes();
  Future<NoteEntity> insertNote(NoteEntity noteEntity);
  Future<int> deleteNote(int noteId);
  Future<NoteEntity> updateNote(NoteEntity noteEntity);
}
