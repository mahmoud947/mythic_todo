import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:mythic_todo/core/util/extensions.dart';

enum NoteColor { yellow, green, pink, babyBlue, purple, orang }

enum NoteTableInfo {
  tableName,
  id,
  title,
  description,
  startTime,
  endTime,
  color,
  isCompleted,
  reminder,
}

extension GetTableInfo on NoteTableInfo {
  get getName {
    switch (this) {
      case NoteTableInfo.tableName:
        return 'note_table';

      case NoteTableInfo.id:
        return 'id';

      case NoteTableInfo.title:
        return 'title';

      case NoteTableInfo.description:
        return 'description';

      case NoteTableInfo.startTime:
        return 'startTime';

      case NoteTableInfo.endTime:
        return 'endTime';

      case NoteTableInfo.color:
        return 'color';

      case NoteTableInfo.isCompleted:
        return 'isCompleted';

      case NoteTableInfo.reminder:
        return 'reminder';
    }
  }
}

class NoteModel extends Equatable {
  final int? id;
  final String title;
  final String? description;
  final String? startTime;
  final String? endTime;
  final NoteColor color;
  final bool? isCompleted;
  final bool? reminder;
  const NoteModel({
    this.id,
    required this.title,
    this.description,
    this.startTime,
    this.endTime,
    required this.color,
    this.isCompleted,
    this.reminder,
  });

  Color get getNoteColor {
    switch (color.index) {
      case 0:
        return const Color(0xFFF9E5AF);
      case 1:
        return const Color(0xFFA1EF9B);
      case 2:
        return const Color(0xFFFFAFDF);
      case 3:
        return const Color(0xFFADE3FE);
      case 4:
        return const Color(0xFFD5CFF4);
      case 5:
        return const Color(0xFFF68C8C);
      default:
        return const Color(0xFFF9E5AF);
    }
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      NoteTableInfo.id.getName: id,
      NoteTableInfo.title.getName: title,
      NoteTableInfo.description.getName: description,
      NoteTableInfo.startTime.getName: startTime,
      NoteTableInfo.endTime.getName: endTime,
      NoteTableInfo.color.getName: color.index,
      NoteTableInfo.isCompleted.getName: isCompleted,
      NoteTableInfo.reminder.getName: reminder,
    };
  }

  factory NoteModel.fromMap(Map<String, dynamic> map) {
    return NoteModel(
      id: map[NoteTableInfo.id.getName] as int,
      title: map[NoteTableInfo.title.getName] as String,
      description: map[NoteTableInfo.description.getName] as String,
      startTime: map[NoteTableInfo.startTime.getName] != null
          ? map['startTime'] as String
          : null,
      endTime: map[NoteTableInfo.endTime.getName] != null
          ? map['endTime'] as String
          : null,
      color: NoteColor.values[map[NoteTableInfo.color.getName] as int],
      isCompleted: (map[NoteTableInfo.isCompleted.getName] as int).toBoolean(),
      reminder: (map[NoteTableInfo.reminder.getName] as int).toBoolean(),
    );
  }

  String toJson() => json.encode(toMap());

  factory NoteModel.fromJson(String source) =>
      NoteModel.fromMap(json.decode(source) as Map<String, dynamic>);

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
