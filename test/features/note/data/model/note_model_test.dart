import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mythic_todo/features/note/data/models/note_model.dart';

import '../../../../fixtures/fixtures_render.dart';

void main() {
  const NoteModel tNoteModel = NoteModel(
      id: 1,
      title: 'title1',
      description: 'description',
      startTime: 'startTime',
      endTime: 'endTime',
      color: NoteColor.green,
      isCompleted: true,
      reminder: true);

  group('data transfer object', () {
    test('should return a valid model', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(fixture('note_map.json'));
      // act
      final result = NoteModel.fromMap(jsonMap);
      // assert
      expect(result, tNoteModel);
    });
  });
}
