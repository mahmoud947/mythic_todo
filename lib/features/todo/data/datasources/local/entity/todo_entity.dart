import 'dart:convert';

import 'package:flutter/cupertino.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
enum TodoColor { yellow, green, pink, babyBlue, purple, orange }

class TodoEntity {
  final int id;
  final String title;
  final String description;
  final String? startTime;
  final String? endTime;
  final int color;
  final bool isCompleted;
  final bool reminder;
  TodoEntity({
    required this.id,
    required this.title,
    required this.description,
    this.startTime,
    this.endTime,
    required this.color,
    required this.isCompleted,
    required this.reminder,
  });

  Color get getTodoColor {
    switch (color) {
      case 1:
        return const Color(0xFFF9E5AF);
      case 2:
        return const Color(0xFFA1EF9B);
      case 3:
        return const Color(0xFFFFAFDF);
      case 4:
        return const Color(0xFFADE3FE);
      case 5:
        return const Color(0xFFD5CFF4);
      case 6:
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
      'color': color,
      'isCompleted': isCompleted,
      'reminder': reminder,
    };
  }

  factory TodoEntity.fromMap(Map<String, dynamic> map) {
    return TodoEntity(
      id: map['id'] as int,
      title: map['title'] as String,
      description: map['description'] as String,
      startTime: map['startTime'] != null ? map['startTime'] as String : null,
      endTime: map['endTime'] != null ? map['endTime'] as String : null,
      color: map['color'] as int,
      isCompleted: map['isCompleted'] as bool,
      reminder: map['reminder'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory TodoEntity.fromJson(String source) =>
      TodoEntity.fromMap(json.decode(source) as Map<String, dynamic>);
}
