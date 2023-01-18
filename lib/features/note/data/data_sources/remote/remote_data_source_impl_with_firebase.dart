import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../../core/error/exceptions.dart';
import '../../models/note_model.dart';
import 'remote_data_source.dart';

class RemoteDataSourceImplWithFirebase implements RemoteDataSource {
  final notes = FirebaseFirestore.instance.collection('notes');
  final uuid = FirebaseAuth.instance.currentUser?.uid;
  @override
  Future<Unit> deleteAllNote() async {
    try {
      //TODO : remove this shit
      await notes.where('uuid', isEqualTo: uuid).get().then((value) {
        final y = value.docs;
        for (final m in y) {
          m.reference.delete();
        }
      });
      return Future.value(unit);
    } on FirebaseException catch (e) {
      throw RemoteDataSourceException(message: e.toString());
    } on Exception catch (e) {
      throw UnKnownException(message: e.toString());
    }
  }

  @override
  Future<Unit> deleteNote({required String noteId}) async {
    try {
      await notes.doc(noteId).delete();

      return Future.value(unit);
    } on FirebaseException catch (e) {
      throw RemoteDataSourceException(message: e.toString());
    } on Exception catch (e) {
      throw UnKnownException(message: e.toString());
    }
  }

  @override
  Future<NoteModel> getNote({required String noteId}) {
    // TODO: implement getNote
    throw UnimplementedError();
  }

  @override
  Future<List<NoteModel>> getNotes() async {
    return await notes.where('uuid', isEqualTo: uuid).get().then((value) async {
      return value.docs
          .map((noteDoc) => NoteModel.fromMap(noteDoc.data()))
          .toList();
    }).onError((error, stackTrace) =>
        throw RemoteDataSourceException(message: error.toString()));
  }

  @override
  Future<Unit> insertNote({required NoteModel noteModel}) async {
    try {
      await notes.doc(noteModel.id).set(noteModel.toMap());
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
