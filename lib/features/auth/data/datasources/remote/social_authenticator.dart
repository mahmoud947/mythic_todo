import 'package:dartz/dartz.dart';

import 'dto/response/user_response_dto.dart';

abstract class SocialAuthenticator {
  Future<UserResponseDto> signInWithGoogle();
  Future<Unit> signOut();
}
