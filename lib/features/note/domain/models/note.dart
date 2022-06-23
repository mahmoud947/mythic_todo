// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import '../../data/data_sources/local/entities/note_entity.dart';

class Note extends Equatable {
  final int id;
  final String title;
  final String description;
  final String startTime;
  final String endTime;
  final NoteColor color;
  final bool isCompleted;
  final bool reminder;
  const Note({
    required this.id,
    required this.title,
    required this.description,
    required this.startTime,
    required this.endTime,
    required this.color,
    required this.isCompleted,
    required this.reminder,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        startTime,
        endTime,
        color,
        isCompleted,
        reminder,
      ];
}
