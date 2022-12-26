import 'package:dartz/dartz.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:workmanager/workmanager.dart';

import '../../../di/app_module.dart';
import '../../../di/note_module.dart';
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
            initNoteModule();
            final RemoteDataSource remoteDataSource = ls();
            await remoteDataSource.insertNote(
                noteModel: NoteModel.fromMap(inputData));
          }
          break;
        default:
          break;
      }

      return Future.value(true);
    },
  );
}

// ignore: constant_identifier_names
const ADD_NOTE_TASK = 'add_note';

abstract class NoteWorkManager {
  Future<Unit> insertNote({required NoteModel noteModel});
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
}
