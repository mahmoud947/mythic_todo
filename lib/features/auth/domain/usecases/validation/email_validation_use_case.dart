import 'package:dartz/dartz.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/usecase/base_use_case.dart';

class EmailValidationUseCase extends BaseUseCase<String?, String?> {
  final RegExp _emailRegExp =
      RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$');

  @override
  Future<Either<Failure, String?>> call(String? input) async {
    if (input == null || input.isEmpty) {
      return Left(InvalidInputFailure(message: 'email is required'));
    } else if (!_emailRegExp.hasMatch(input)) {
      return Left(InvalidInputFailure(message: 'please enter a valid email'));
    } else {
      return Right(input);
    }
  }
}
