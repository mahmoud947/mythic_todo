import 'package:mythic_todo/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:mythic_todo/core/usecase/base_use_case.dart';

class NoteTitleValidationUseCase extends BaseUseCase<String?, String?> {
  @override
  Future<Either<Failure, String?>> call({required String? input}) async {
    if (input == null || input.trim().isEmpty) {
      return left(InvalidInputFailure(message: 'Title Can\'t be empty'));
    } else {
      return right(input);
    }
  }
}
