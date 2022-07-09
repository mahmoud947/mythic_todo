import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';

abstract class AuthRepository {
  /// check if it first time lunching application
  /// to show onBoarding screen or not
  Either<Failure, bool> isFirstLaunching();

  /// set is first time launching application
  Future<Either<Failure, Unit>> setFirstLaunch({required bool isFirstLaunch});
}
