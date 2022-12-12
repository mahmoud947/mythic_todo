import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mythic_todo/core/error/error_strings.dart';
import 'package:mythic_todo/core/error/exceptions.dart';
import 'package:mythic_todo/features/auth/data/datasources/remote/social_authenticator.dart';

class SocialAuthenticatorWithFirebase implements SocialAuthenticator {
  @override
  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);

    try {
      return await FirebaseAuth.instance.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      // TODO: remove hard coded
      if (e.code == 'account-exists-with-different-credential') {
        throw FirebaseAuthAccountAlreadyExistException(message: e.message);
      } else {
        throw UnKnownException(message: ErrorString.unexpectedError);
      }
    }
  }
}
