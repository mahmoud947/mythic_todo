import 'dart:convert';

import 'package:flutter/material.dart';

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
        return '_id';
      case NoteTableInfo.title:
        return 'title';

      case NoteTableInfo.description:
        return 'description';

      case NoteTableInfo.startTime:
        return 'start_time';

      case NoteTableInfo.endTime:
        return 'end_time';

      case NoteTableInfo.color:
        return 'color';

      case NoteTableInfo.isCompleted:
        return 'note_state';

      case NoteTableInfo.reminder:
        return 'reminder_state';
    }
  }
}

class NoteEntity {
  final int id;
  final String title;
  final String description;
  final String? startTime;
  final String? endTime;
  final NoteColor color;
  final bool? isCompleted;
  final bool reminder;
  NoteEntity({
    required this.id,
    required this.title,
    required this.description,
    this.startTime,
    this.endTime,
    required this.color,
    this.isCompleted,
    required this.reminder,
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
      'id': id,
      'title': title,
      'description': description,
      'startTime': startTime,
      'endTime': endTime,
      'color': color.index,
      'isCompleted': isCompleted,
      'reminder': reminder,
    };
  }

  factory NoteEntity.fromMap(Map<String, dynamic> map) {
    return NoteEntity(
      id: map['id'] as int,
      title: map['title'] as String,
      description: map['description'] as String,
      startTime: map['startTime'] != null ? map['startTime'] as String : null,
      endTime: map['endTime'] != null ? map['endTime'] as String : null,
      color: NoteColor.values[map['color'] as int],
      isCompleted: map['isCompleted'] as bool,
      reminder: map['reminder'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory NoteEntity.fromJson(String source) =>
      NoteEntity.fromMap(json.decode(source) as Map<String, dynamic>);
}
