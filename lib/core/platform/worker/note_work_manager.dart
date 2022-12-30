// ignore_for_file: constant_identifier_names

import 'package:dartz/dartz.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mythic_todo/features/note/data/data_sources/remote/remote_data_source_impl_with_firebase.dart';
import 'package:uuid/uuid.dart';
import 'package:workmanager/workmanager.dart';

import '../../../features/note/data/data_sources/remote/remote_data_source.dart';
import '../../../features/note/data/models/note_model.dart';
import '../../../firebase_options.dart';
import '../../util/extensions.dart';

@pragma('vm:entry-point')
void callbackDispatcher() async {
  WidgetsFlutterBinding.ensureInitialized();

  Workmanager().executeTask(
    (taskName, inputData) async {
      await Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform);

      switch (taskName) {
        case ADD_NOTE_TASK:
          if (inputData != null) {
            final RemoteDataSource remoteDataSource =
                RemoteDataSourceImplWithFirebase();
            await remoteDataSource.insertNote(
                noteModel: NoteModel.fromMap(inputData));
          }
          break;
        case DELETE_ALL_NOTES:
          final RemoteDataSource remoteDataSource =
              RemoteDataSourceImplWithFirebase();
          await remoteDataSource.deleteAllNote();
          break;
        case DELETE_NOTE:
          final RemoteDataSource remoteDataSource =
              RemoteDataSourceImplWithFirebase();
          remoteDataSource.deleteNote(
            noteId: inputData?['noteId'],
          );

          break;
        default:
          break;
      }

      return Future.value(true);
    },
  );
}

const ADD_NOTE_TASK = 'add_note';
const DELETE_ALL_NOTES = 'delete_all_notes';
const DELETE_NOTE = 'delete_note';

abstract class NoteWorkManager {
  Future<Unit> insertNote({required NoteModel noteModel});
  Future<Unit> deleteAllNotes();
  Future<Unit> deleteNote({required String noteId});
}

class NoteWorkManagerImpl implements NoteWorkManager {
  @override
  Future<Unit> insertNote({required NoteModel noteModel}) async {
    var uniqueName = noteModel.id.orEmpty();
    try {
      await Workmanager().registerOneOffTask(
        uniqueName,
        ADD_NOTE_TASK,
        constraints: Constraints(
          networkType: NetworkType.connected,
        ),
        inputData: noteModel.toMap(),
      );
      return Future.value(unit);
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<Unit> deleteAllNotes() async {
    final uniqueName = const Uuid().v1();
    try {
      await Workmanager().registerOneOffTask(
        uniqueName,
        DELETE_ALL_NOTES,
        constraints: Constraints(
          networkType: NetworkType.connected,
        ),
      );
      return Future.value(unit);
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<Unit> deleteNote({required String noteId}) async {
    final uniqueName = const Uuid().v1();
    try {
      await Workmanager().registerOneOffTask(
        uniqueName,
        DELETE_NOTE,
        constraints: Constraints(
          networkType: NetworkType.connected,
        ),
        inputData: {'noteId': noteId},
      );
      return Future.value(unit);
    } on Exception {
      rethrow;
    }
  }
}
