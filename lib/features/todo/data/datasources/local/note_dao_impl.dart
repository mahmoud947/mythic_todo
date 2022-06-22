import 'entity/note_entity.dart';
import 'note_dao.dart';

class NoteDaoImpl implements NoteDao {
  @override
  Future<int> deleteNote(int noteId) {
    // TODO: implement deleteNote
    throw UnimplementedError();
  }

  @override
  Future<List<NoteEntity>> getNotes() {
    // TODO: implement getNotes
    throw UnimplementedError();
  }

  @override
  Future<NoteEntity> insertNote(NoteEntity noteEntity) {
    // TODO: implement insertNote
    throw UnimplementedError();
  }

  @override
  Future<NoteEntity> updateNote(NoteEntity noteEntity) {
    // TODO: implement updateNote
    throw UnimplementedError();
  }
}
