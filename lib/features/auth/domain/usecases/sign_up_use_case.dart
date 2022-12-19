import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/base_use_case.dart';
import '../../data/datasources/remote/dto/request/user_request_dto.dart';
import '../model/user_model.dart';
import '../repositories/auth_repository.dart';

class SignUpUseCase implements BaseUseCase<UserRequestDto, UserModel> {
  SignUpUseCase({required this.authRepository});
  final AuthRepository authRepository;

  @override
  Future<Either<Failure, UserModel>> call(UserRequestDto input) {
    return authRepository.signUp(userRequestDto: input);
  }
}
