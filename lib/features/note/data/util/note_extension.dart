import 'package:flutter/material.dart';
import 'package:mythic_todo/features/note/data/models/note_model.dart';

extension GetColor on NoteColor {
  Color get intColor {
    switch (this) {
      case NoteColor.yellow:
        return const Color(0xFFF9E5AF);
      case NoteColor.green:
        return const Color(0xFFA1EF9B);
      case NoteColor.pink:
        return const Color(0xFFFFAFDF);
      case NoteColor.babyBlue:
        return const Color(0xFFADE3FE);
      case NoteColor.purple:
        return const Color(0xFFD5CFF4);
      case NoteColor.orang:
        return const Color(0xFFF68C8C);
    }
  }
}
