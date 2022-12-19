import '../error/failures.dart';
import 'package:dartz/dartz.dart';
import 'base_use_case.dart';

class TextFieldValidationUseCase extends BaseUseCase<String?, String?> {
  @override
  Future<Either<Failure, String?>> call({String? input}) async {
    if (input == null || input.isEmpty) {
      return left(InvalidInputFailure(message: 'input is require'));
    } else {
      return Right(input);
    }
  }
}
