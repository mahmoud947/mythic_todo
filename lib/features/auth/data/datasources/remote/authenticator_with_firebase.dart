import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import '../../../../../core/error/error_strings.dart';
import '../../../../../core/error/exceptions.dart';
import 'dto/request/user_request_dto.dart';
import 'dto/response/user_response_dto.dart';
import '../../mapper/auth_mapper.dart';
import '../../../domain/model/user_model.dart';

import 'authenticator.dart';

//Todo : remove hardcode
class AuthenticatorWithFirebase implements Authenticator {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  @override
  Future<UserModel> signUp({required UserRequestDto userRequestDto}) async {
    try {
      final credential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: userRequestDto.email,
        password: userRequestDto.password,
      );

      final CollectionReference users = _firestore.collection('users');
      users.doc(credential.user?.uid).set(userRequestDto.toMap());
      final UserModel userModel =
          await getUserInfo(uid: _firebaseAuth.currentUser?.uid ?? '');
      return userModel;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw UnKnownException(message: 'The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        throw FirebaseAuthAccountAlreadyExistException(
            message: 'The account already exists for that email.');
      } else {
        throw throw UnKnownException(message: ErrorString.unexpectedError);
      }
    } on PlatformException catch (e) {
      throw UnKnownException(message: e.toString());
    } on Exception catch (e) {
      throw UnKnownException(message: e.toString());
    }
  }

  @override
  Future<UserModel> signIn({
    required String email,
    required String password,
  }) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);

      return getUserInfo(uid: _firebaseAuth.currentUser?.uid ?? '');
    } on FirebaseAuthException catch (e) {
      throw SignInException(message: e.message);
    } on Exception {
      throw UnKnownException(message: ErrorString.unexpectedError);
    }
  }

  @override
  Future<UserModel> getUserInfo({required String uid}) async {
    try {
      final doc = await _firestore
          .collection('users')
          .doc(_firebaseAuth.currentUser?.uid)
          .get();
      if (!doc.exists) {
        throw UserNotFoundException(message: 'user not found');
      } else {
        final userInfoAsMap = doc.data() as Map<String, dynamic>;
        return UserResponseDto.fromMap(userInfoAsMap).toDomain();
      }
    } on Exception {
      throw UnKnownException(message: 'unexpected error occurred ');
    }
  }
}
