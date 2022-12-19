import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/base_use_case.dart';
import '../repositories/auth_repository.dart';

import '../model/user_model.dart';

class GetUserInfoUseCase implements BaseUseCase<String, UserModel> {
  GetUserInfoUseCase({
    required this.authRepository,
  });
  final AuthRepository authRepository;
  @override
  Future<Either<Failure, UserModel>> call({required String input}) {
    return authRepository.getUserInfo(uid: input);
  }
}
