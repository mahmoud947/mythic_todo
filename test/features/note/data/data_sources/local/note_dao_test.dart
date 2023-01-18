import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sqflite/sqlite_api.dart';

import 'package:mythic_todo/core/error/exceptions.dart';
import 'package:mythic_todo/features/note/data/data_sources/local/note_dao.dart';
import 'package:mythic_todo/features/note/data/data_sources/local/note_dao_impl.dart';
import 'package:mythic_todo/features/note/data/models/note_model.dart';

import '../../../../../fixtures/fixtures_render.dart';

class MockDatabase extends Mock implements Database {}

void main() {
  late MockDatabase mockDatabase;
  late NoteDao daoImpl;

  setUp(() {
    mockDatabase = MockDatabase();
    daoImpl = NoteDaoImpl(database: mockDatabase);
  });

  group('getNotes', () {
    const List<NoteModel> tNotesModels = [
      NoteModel(
          id: '1',
          uuid: 'uuid',
          title: 'title1',
          description: 'description',
          startTime: 'startTime',
          endTime: 'endTime',
          color: NoteColor.babyBlue,
          isCompleted: true,
          reminder: true),
      NoteModel(
          id: '2',
          uuid: 'uuid',
          title: 'title1',
          description: 'description',
          startTime: 'startTime',
          endTime: 'endTime',
          color: NoteColor.babyBlue,
          isCompleted: true,
          reminder: true),
      NoteModel(
          id: '3',
          uuid: 'uuid',
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
              NoteTableInfo.uuid.getName.toString(): e['uuid'],
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
      when(() => mockDatabase.query(
            NoteTableInfo.tableName.getName,
            orderBy: '${NoteTableInfo.startTime.getName} DESC',
          )).thenAnswer((_) async => tMap);

      // act
      final List<NoteModel> result = await daoImpl.getNotes();
      // assert
      verify(() => mockDatabase.query(
            NoteTableInfo.tableName.getName,
            orderBy: '${NoteTableInfo.startTime.getName} DESC',
          ));
      verifyNoMoreInteractions(mockDatabase);
      expect(result, tNotesModels);
    });

    test(
        'should throw a EmptyNotesDataException when there is no database values',
        () async {
      // arrange
      when(() => mockDatabase.query(
            NoteTableInfo.tableName.getName,
            orderBy: '${NoteTableInfo.startTime.getName} DESC',
          )).thenAnswer((_) async => []);

      // act
      final call = daoImpl.getNotes;
      // assert
      expect(() => call(), throwsA(isA<EmptyNotesDataException>()));
    });
  });

  group('deleteNote', () {
    const tNoteId = '1';
    const successCount = 1;
    const failureCount = 0;
    test(
        'should return unit from Database(sqflite) when there is notesModels to delete in the database',
        () async {
      // arrange
      when(
        () => mockDatabase.delete(
          NoteTableInfo.tableName.getName,
          where: '${NoteTableInfo.id.getName} = ?',
          whereArgs: [tNoteId],
        ),
      ).thenAnswer((_) async => successCount);
      // act
      final result = await daoImpl.deleteNote(noteId: tNoteId);
      // assert
      expect(result, unit);
    });

    test(
        'should throw a LocalDatabaseException when there is no note to delete ',
        () async {
      // arrange
      when(
        () => mockDatabase.delete(
          NoteTableInfo.tableName.getName,
          where: '${NoteTableInfo.id.getName} = ?',
          whereArgs: [tNoteId],
        ),
      ).thenAnswer((_) async => failureCount);
      // act
      final call = daoImpl.deleteNote;
      // assert
      expect(
          () => call(noteId: tNoteId), throwsA(isA<LocalDatabaseException>()));
    });
  });

  group('insertNote', () {
    const tNote = NoteModel(
        id: '3',
        uuid: 'uuid',
        title: 'title1',
        description: 'description',
        startTime: 'startTime',
        endTime: 'endTime',
        color: NoteColor.babyBlue,
        isCompleted: true,
        reminder: true);
    const successRowCount = 1;
    const failureRowCount = 0;
    test(
        'should return unit from Database(sqflite) when there is notesModels inserted in the database',
        () async {
      // arrange
      when(
        () => mockDatabase.insert(
            NoteTableInfo.tableName.getName, tNote.toMap(),
            conflictAlgorithm: ConflictAlgorithm.replace),
      ).thenAnswer((_) async => successRowCount);

      // act
      final result = await daoImpl.insertNote(noteModel: tNote);
      // assert
      expect(result, unit);
    });

    test(
        'should throw a LocalDatabaseException when database fail to insert note ',
        () async {
      // arrange
      when(
        () => mockDatabase.insert(
            NoteTableInfo.tableName.getName, tNote.toMap(),
            conflictAlgorithm: ConflictAlgorithm.replace),
      ).thenAnswer((_) async => failureRowCount);
      // act
      final call = daoImpl.insertNote;
      // assert
      expect(
          () => call(noteModel: tNote), throwsA(isA<LocalDatabaseException>()));
    });
  });

  group('updateNote', () {
    const tNote = NoteModel(
        id: '3',
        uuid: 'uuid',
        title: 'title1',
        description: 'description',
        startTime: 'startTime',
        endTime: 'endTime',
        color: NoteColor.babyBlue,
        isCompleted: true,
        reminder: true);
    const successRowCount = 1;
    const failureRowCount = 0;
    test('should return noteModel when database(sqflite) success in update',
        () async {
      // arrange
      when(
        () => mockDatabase.update(
          NoteTableInfo.tableName.getName,
          tNote.toMap(),
          where: '${NoteTableInfo.id.getName} = ?',
          whereArgs: [tNote.id],
        ),
      ).thenAnswer((_) async => successRowCount);
      // act
      final result = await daoImpl.updateNote(noteModel: tNote);
      // assert
      expect(result, tNote);
    });

    test(
        'should throw a LocalDatabaseException when database fail to update note',
        () async {
      // arrange
      when(
        () => mockDatabase.update(
          NoteTableInfo.tableName.getName,
          tNote.toMap(),
          where: '${NoteTableInfo.id.getName} = ?',
          whereArgs: [tNote.id],
        ),
      ).thenAnswer((_) async => failureRowCount);
      // act
      final call = daoImpl.updateNote;
      // assert
      expect(
          () => call(noteModel: tNote), throwsA(isA<LocalDatabaseException>()));
    });
  });

  group('getNote', () {
    const tNote = NoteModel(
      id: '1',
      uuid: 'uuid',
      title: 'title1',
      description: 'description',
      startTime: 'startTime',
      endTime: 'endTime',
      color: NoteColor.babyBlue,
      isCompleted: true,
      reminder: true,
    );

    const List<Map<String, dynamic>> tMap = [
      {
        'id': '1',
        'uuid': 'uuid',
        'title': 'title1',
        'description': 'description',
        'startTime': 'startTime',
        'endTime': 'endTime',
        'color': 3,
        'isCompleted': 1,
        'reminder': 1
      },
    ];
    const tNoteId = '1';
    test(
        'should return notesModel by noteId from Database(sqflite) when database success to found it',
        () async {
      // arrange
      when(
        () => mockDatabase.query(NoteTableInfo.tableName.getName,
            where: '${NoteTableInfo.id.getName} = ?', whereArgs: [tNoteId]),
      ).thenAnswer((_) async => tMap);
      // act
      final result = await daoImpl.getNote(noteId: tNoteId);
      // assert
      expect(result, tNote);
    });

    test(
        'should throw a LocalDatabaseException when database fail to find noteModel by noteId ',
        () async {
      // arrange
      when(
        () => mockDatabase.query(NoteTableInfo.tableName.getName,
            where: '${NoteTableInfo.id.getName} = ?', whereArgs: [tNoteId]),
      ).thenAnswer((_) async => []);
      // act
      final call = daoImpl.getNote;
      // assert
      expect(() => call(noteId: tNoteId),
          throwsA(isA<LocalDatabaseNotFoundException>()));
    });
  });
}
