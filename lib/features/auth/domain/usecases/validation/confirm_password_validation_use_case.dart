import '../../../../../core/error/failures.dart';
import 'package:dartz/dartz.dart';
import '../../../../../core/usecase/base_use_case.dart';

class ConfirmPasswordValidationUseCase
    extends BaseUseCase<ConfirmPasswordValidationUseCaseInput, String?> {
  @override
  Future<Either<Failure, String?>> call(
      {required ConfirmPasswordValidationUseCaseInput input}) async {
    if (input.confirmPassword == null || input.confirmPassword!.isEmpty) {
      return Left(InvalidInputFailure(message: 'confirm password is required'));
    } else if (input.confirmPassword!.trim().length < 8) {
      return Left(InvalidInputFailure(
          message: 'password should be more than 8 character'));
    } else if (input.confirmPassword!.trim() != input.password!.trim()) {
      return Left(InvalidInputFailure(message: 'Passwords Don\'t Match'));
    } else {
      return Right(input.confirmPassword!.trim());
    }
  }
}

class ConfirmPasswordValidationUseCaseInput {
  ConfirmPasswordValidationUseCaseInput({
    this.password,
    this.confirmPassword,
  });
  final String? password;
  final String? confirmPassword;
}
