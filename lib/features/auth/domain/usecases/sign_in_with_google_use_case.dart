import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:mythic_todo/core/error/failures.dart';
import 'package:mythic_todo/features/auth/domain/repositories/auth_repository.dart';

class SignInWithGoogleUseCase {
  SignInWithGoogleUseCase({required this.authRepository});
  final AuthRepository authRepository;
  Future<Either<Failure, UserCredential>> call() =>
      authRepository.signInWithGoogle();
}
