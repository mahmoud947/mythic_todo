import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mythic_todo/core/error/error_strings.dart';
import 'package:mythic_todo/core/error/exceptions.dart';
import 'package:mythic_todo/features/auth/data/datasources/remote/dto/request/user_request_dto.dart';

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
      users.add(userRequestDto.toMap());

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
    } on Exception catch (e) {
      throw UnKnownException(message: e.toString());
    }
  }
}
