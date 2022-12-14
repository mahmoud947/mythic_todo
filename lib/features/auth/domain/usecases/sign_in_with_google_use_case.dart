import 'package:dartz/dartz.dart';

import 'package:mythic_todo/core/error/failures.dart';
import 'package:mythic_todo/features/auth/data/datasources/remote/dto/response/user_response_dto.dart';
import 'package:mythic_todo/features/auth/domain/repositories/auth_repository.dart';

class SignInWithGoogleUseCase {
  SignInWithGoogleUseCase({required this.authRepository});
  final AuthRepository authRepository;
  Future<Either<Failure, UserResponseDto>> call() =>
      authRepository.signInWithGoogle();
}
