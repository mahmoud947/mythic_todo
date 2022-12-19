// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:mythic_todo/core/usecase/base_use_case.dart';
import 'package:mythic_todo/features/auth/domain/repositories/auth_repository.dart';

import '../../../../core/error/failures.dart';
import '../model/user_model.dart';

class SignInUseCase implements BaseUseCase<SignInUseCaseInput, UserModel> {
  final AuthRepository authRepository;
  SignInUseCase({required this.authRepository});

  @override
  Future<Either<Failure, UserModel>> call(SignInUseCaseInput input) {
    return authRepository.singIn(email: input.email, password: input.password);
  }
}

class SignInUseCaseInput {
  SignInUseCaseInput({
    required this.email,
    required this.password,
  });
  final String email;
  final String password;
}
