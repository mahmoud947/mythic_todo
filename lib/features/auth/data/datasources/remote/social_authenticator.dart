import 'package:firebase_auth/firebase_auth.dart';

abstract class SocialAuthenticator {
  Future<UserCredential> signInWithGoogle();
}
