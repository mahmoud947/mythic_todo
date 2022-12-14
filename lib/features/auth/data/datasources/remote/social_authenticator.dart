import 'package:dartz/dartz.dart';
import 'package:mythic_todo/features/auth/data/datasources/remote/dto/response/user_response_dto.dart';

abstract class SocialAuthenticator {
  Future<UserResponseDto> signInWithGoogle();
  Future<Unit> signOut();
}
