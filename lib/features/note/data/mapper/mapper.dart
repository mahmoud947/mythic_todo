import 'package:mythic_todo/core/util/extension.dart';
import 'package:mythic_todo/features/note/data/data_sources/local/entities/note_entity.dart';
import 'package:mythic_todo/features/note/domain/models/note.dart';

extension NoteEntityMapper on NoteEntity {
  Note toDomain() {
    return Note(
      id: id.orZero(),
      title: title,
      description: description.orEmpty(),
      startTime: startTime.orEmpty(),
      endTime: endTime.orEmpty(),
      color: color,
      isCompleted: isCompleted.orFalse(),
      reminder: reminder.orFalse(),
    );
  }
}
