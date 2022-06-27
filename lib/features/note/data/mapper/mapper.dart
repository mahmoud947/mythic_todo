import 'package:mythic_todo/core/util/extension.dart';
import 'package:mythic_todo/features/note/domain/entities/note.dart';

import '../models/note_model.dart';

extension NoteEntityMapper on NoteModel {
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
