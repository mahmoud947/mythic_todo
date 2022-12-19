import 'package:dartz/dartz.dart';
import 'package:mythic_todo/core/error/failures.dart';
import 'package:mythic_todo/core/usecase/base_use_case.dart';
import 'package:mythic_todo/features/auth/data/datasources/remote/dto/request/user_request_dto.dart';
import 'package:mythic_todo/features/auth/domain/model/user_model.dart';
import 'package:mythic_todo/features/auth/domain/repositories/auth_repository.dart';

class SignUpUseCase implements BaseUseCase<UserRequestDto, UserModel> {
  SignUpUseCase({required this.authRepository});
  final AuthRepository authRepository;

  @override
  Future<Either<Failure, UserModel>> call(UserRequestDto input) {
    return authRepository.signUp(userRequestDto: input);
  }
}
