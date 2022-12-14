import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mythic_todo/core/error/error_strings.dart';
import 'package:mythic_todo/core/error/exceptions.dart';
import 'package:mythic_todo/features/auth/data/datasources/remote/dto/response/user_response_dto.dart';
import 'package:mythic_todo/features/auth/data/datasources/remote/social_authenticator.dart';

class SocialAuthenticatorWithFirebase implements SocialAuthenticator {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  @override
  Future<UserResponseDto> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);

    try {
      final UserCredential userCredential =
          await firebaseAuth.signInWithCredential(credential);
      return Future.value(UserResponseDto.fromCredential(userCredential));
    } on FirebaseAuthException catch (e) {
      // TODO: remove hard coded
      if (e.code == 'account-exists-with-different-credential') {
        throw FirebaseAuthAccountAlreadyExistException(message: e.message);
      } else {
        throw UnKnownException(message: ErrorString.unexpectedError);
      }
    } on Exception catch (e) {
      throw UnKnownException(message: ErrorString.unexpectedError);
    }
  }

  @override
  Future<Unit> signOut() async {
    try {
      await firebaseAuth.signOut();
      if (firebaseAuth.currentUser == null) {
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
