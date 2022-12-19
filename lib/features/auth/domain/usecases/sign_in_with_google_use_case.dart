import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../data/datasources/remote/dto/response/user_response_dto.dart';
import '../repositories/auth_repository.dart';

class SignInWithGoogleUseCase {
  SignInWithGoogleUseCase({required this.authRepository});
  final AuthRepository authRepository;
  Future<Either<Failure, UserResponseDto>> call() =>
      authRepository.signInWithGoogle();
}
