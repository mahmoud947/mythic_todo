import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../../../core/error/error_strings.dart';
import '../../../../../core/error/exceptions.dart';
import '../../../../../core/util/extensions.dart';
import 'dto/request/user_request_dto.dart';
import 'dto/response/user_response_dto.dart';
import 'social_authenticator.dart';

class SocialAuthenticatorWithFirebase implements SocialAuthenticator {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  @override
  Future<UserResponseDto> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);

      final UserCredential userCredential =
          await _firebaseAuth.signInWithCredential(credential);

      final CollectionReference users = _firestore.collection('users');
      final UserRequestDto userRequestDto = UserRequestDto(
        email: _firebaseAuth.currentUser?.email.orEmpty() ?? '',
        displayName: _firebaseAuth.currentUser?.displayName.orEmpty() ?? '',
        imageUrl: _firebaseAuth.currentUser?.photoURL?.orEmpty(),
        password: '',
      );
      users.doc(_firebaseAuth.currentUser?.uid).set(userRequestDto.toMap());

      return Future.value(UserResponseDto.fromCredential(userCredential));
    } on FirebaseAuthException catch (e) {
      // TODO: remove hard coded
      if (e.code == 'account-exists-with-different-credential') {
        throw FirebaseAuthAccountAlreadyExistException(message: e.message);
      } else {
        throw UnKnownException(message: ErrorString.unexpectedError);
      }
    } on Exception {
      throw UnKnownException(message: ErrorString.unexpectedError);
    }
  }

  @override
  Future<Unit> signOut() async {
    try {
      await _firebaseAuth.signOut();
      if (_firebaseAuth.currentUser == null) {
        return Future.value(unit);
      } else {
        throw UnKnownException(message: ErrorString.unexpectedError);
      }
    } on FirebaseAuthException catch (e) {
      throw UnKnownException(message: e.message);
    } on Exception catch (e) {
      throw UnKnownException(message: e.toString());
    }
  }
}
