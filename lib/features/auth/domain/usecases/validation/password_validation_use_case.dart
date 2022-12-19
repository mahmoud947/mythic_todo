import '../../../../../core/error/failures.dart';
import 'package:dartz/dartz.dart';
import '../../../../../core/usecase/base_use_case.dart';

class PasswordValidationUseCase extends BaseUseCase<String?, String?> {
  @override
  Future<Either<Failure, String?>> call(String? input) async {
    if (input == null || input.isEmpty) {
      return Left(
        InvalidInputFailure(message: 'password is required'),
      );
    } else if (input.trim().length < 8) {
      return Left(
        InvalidInputFailure(
            message: 'password should be more than 8 character'),
      );
    } else {
      return Right(input);
    }
  }
}
