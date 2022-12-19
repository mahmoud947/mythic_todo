import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:mythic_todo/core/error/error_strings.dart';
import 'package:mythic_todo/core/error/exceptions.dart';
import 'package:mythic_todo/features/auth/data/datasources/remote/dto/request/user_request_dto.dart';
import 'package:mythic_todo/features/auth/data/datasources/remote/dto/response/user_response_dto.dart';
import 'package:mythic_todo/features/auth/data/mapper/auth_mapper.dart';
import 'package:mythic_todo/features/auth/domain/model/user_model.dart';

import 'authenticator.dart';

//Todo : remove hardcode
class AuthenticatorWithFirebase implements Authenticator {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  @override
  Future<Token?> signUp({required UserRequestDto userRequestDto}) async {
    try {
      final credential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: userRequestDto.email,
        password: userRequestDto.password,
      );

      final CollectionReference users = _firestore.collection('users');
      users.doc(credential.user?.uid).set(userRequestDto.toMap());

      return credential.credential?.accessToken;
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

      final UserModel userModel = UserModel(
          uid: _firebaseAuth.currentUser?.uid ?? '',
          email: _firebaseAuth.currentUser?.email ?? '',
          displayName: _firebaseAuth.currentUser?.displayName ?? '',
          imageUrl: _firebaseAuth.currentUser?.photoURL ?? '');
      return userModel;
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
