import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

import '../../../../../core/error/exceptions.dart';
import '../../models/note_model.dart';
import 'remote_data_source.dart';

class RemoteDataSourceImplWithFirebase implements RemoteDataSource {
  final notes = FirebaseFirestore.instance.collection('notes');

  @override
  Future<Unit> deleteAllNote() {
    // TODO: implement deleteAllNote
    throw UnimplementedError();
  }

  @override
  Future<Unit> deleteNote({required String noteId}) {
    // TODO: implement deleteNote
    throw UnimplementedError();
  }

  @override
  Future<NoteModel> getNote({required String noteId}) {
    // TODO: implement getNote
    throw UnimplementedError();
  }

  @override
  Future<List<NoteModel>> getNotes() {
    // TODO: implement getNotes
    throw UnimplementedError();
  }

  @override
  Future<Unit> insertNote({required NoteModel noteModel}) async {
    try {
      await notes.add(noteModel.toMap());
      return Future.value(unit);
    } on FirebaseException catch (e) {
      throw RemoteDataSourceException(message: e.toString());
    } on Exception catch (e) {
      throw UnKnownException(message: e.toString());
    }
  }

  @override
  Future<NoteModel> updateNote({required NoteModel noteModel}) {
    // TODO: implement updateNote
    throw UnimplementedError();
  }
}
