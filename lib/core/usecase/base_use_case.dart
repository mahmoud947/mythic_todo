import 'package:dartz/dartz.dart';
import 'package:mythic_todo/core/error/failures.dart';

abstract class BaseUseCase<In, Out> {
  Future<Either<Failure, Out>> call(In input);
}
