import 'package:dartz/dartz.dart';
import 'package:mythic_todo/core/error/failures.dart';
import 'package:mythic_todo/features/auth/data/datasources/remote/authenticator.dart';
import 'package:mythic_todo/features/auth/data/datasources/remote/dto/request/user_request_dto.dart';
import 'package:mythic_todo/features/auth/domain/repositories/auth_repository.dart';

class SignUpUseCase {
  SignUpUseCase({required this.authRepository});
  final AuthRepository authRepository;
  Future<Either<Failure, Token?>> call(
          {required UserRequestDto userRequestDto}) =>
      authRepository.signUp(userRequestDto: userRequestDto);
}
