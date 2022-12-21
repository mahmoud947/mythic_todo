import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mythic_todo/features/note/data/models/note_model.dart';

import '../../../../fixtures/fixtures_render.dart';

void main() {
  const NoteModel tNoteModel = NoteModel(
    id: '1',
    title: 'title1',
    description: 'description',
    startTime: 'startTime',
    endTime: 'endTime',
    color: NoteColor.green,
    isCompleted: true,
    reminder: true,
  );

  group('data transfer object', () {
    test('should return a valid model from map', () async {
      // arrange
      final Map<String, dynamic> map =
          json.decode(fixture('note_response.json'));
      // act
      final result = NoteModel.fromMap(map);
      // assert
      expect(result, tNoteModel);
    });
    test('should return a valid model from json', () async {
      // arrange
      final jsonString = fixture('note_response.json');
      // act
      final result = NoteModel.fromJson(jsonString);
      // assert
      expect(result, tNoteModel);
    });
    test('should return a valid json from NoteModel', () async {
      // arrange
      final jsonString = fixture('note_response.json');
      // act
      final result = tNoteModel.toJson();
      // assert
      expect(result, jsonString);
    });

    test('should return valid map from NoteModel', () async {
      // arrange
      final map = json.decode(fixture('note_response.json'));
      // act
      final result = tNoteModel.toMap();
      // assert
      expect(result, map);
    });
  });
}
