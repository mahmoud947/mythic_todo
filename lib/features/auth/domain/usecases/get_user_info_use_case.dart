import 'package:dartz/dartz.dart';

import 'package:mythic_todo/core/error/failures.dart';
import 'package:mythic_todo/core/usecase/base_use_case.dart';
import 'package:mythic_todo/features/auth/domain/repositories/auth_repository.dart';

import '../model/user_model.dart';

class GetUserInfoUseCase implements BaseUseCase<String, UserModel> {
  GetUserInfoUseCase({
    required this.authRepository,
  });
  final AuthRepository authRepository;
  @override
  Future<Either<Failure, UserModel>> call(String input) {
    return authRepository.getUserInfo(uid: input);
  }
}
