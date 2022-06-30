import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mythic_todo/core/error/exceptions.dart';
import 'package:mythic_todo/features/note/data/data_sources/local/note_dao_impl.dart';
import 'package:mythic_todo/features/note/data/models/note_model.dart';
import 'package:sqflite/sqlite_api.dart';

import '../../../../fixtures/fixtures_render.dart';

class MockDatabase extends Mock implements Database {}

void main() {
  late MockDatabase mockDatabase;
  late NoteDaoImpl daoImpl;

  setUp(() {
    mockDatabase = MockDatabase();
    daoImpl = NoteDaoImpl(database: mockDatabase);
  });

  group('getNotes', () {
    const List<NoteModel> tNotesModels = [
      NoteModel(
          id: 1,
          title: 'title1',
          description: 'description',
          startTime: 'startTime',
          endTime: 'endTime',
          color: NoteColor.babyBlue,
          isCompleted: true,
          reminder: true),
      NoteModel(
          id: 2,
          title: 'title1',
          description: 'description',
          startTime: 'startTime',
          endTime: 'endTime',
          color: NoteColor.babyBlue,
          isCompleted: true,
          reminder: true),
      NoteModel(
          id: 3,
          title: 'title1',
          description: 'description',
          startTime: 'startTime',
          endTime: 'endTime',
          color: NoteColor.babyBlue,
          isCompleted: true,
          reminder: true),
    ];

    final List tJson = json.decode(fixture('note_dao_response.json'));
    final List<Map<String, dynamic>> tMap = tJson
        .map((e) => {
              NoteTableInfo.id.getName.toString(): e['id'],
              NoteTableInfo.title.getName.toString(): e['title'],
              NoteTableInfo.description.getName.toString(): e['description'],
              NoteTableInfo.startTime.getName.toString(): e['startTime'],
              NoteTableInfo.endTime.getName.toString(): e['endTime'],
              NoteTableInfo.color.getName.toString(): e['color'],
              NoteTableInfo.isCompleted.getName.toString(): e['isCompleted'],
              NoteTableInfo.reminder.getName.toString(): e['reminder'],
            })
        .toList();
    test(
        'should return notesModels from Database(sqflite) when there is notesModels in the database',
        () async {
      // arrange
      when(() => mockDatabase.query(NoteTableInfo.tableName.getName))
          .thenAnswer((_) async => tMap);

      // act
      final List<NoteModel> result = await daoImpl.getNotes();
      // assert
      verify(() => mockDatabase.query(NoteTableInfo.tableName.getName));
      verifyNoMoreInteractions(mockDatabase);
      expect(result, tNotesModels);
    });

    test(
        'should throw a EmptyNotesDataException when there is no database values',
        () async {
      // arrange
      when(() => mockDatabase.query(NoteTableInfo.tableName.getName))
          .thenAnswer((_) async => []);

      // act
      final call = daoImpl.getNotes;
      // assert
      expect(() => call(), throwsA(isA<EmptyNotesDataException>()));
    });
  });
}
