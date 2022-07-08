import 'package:dartz/dartz.dart';
import 'package:mythic_todo/core/error/failures.dart';

abstract class AppSetting {
  /// check if it first time lunching application
  /// to show onBoarding screen or not
  Future<Either<Failure, bool>> isFirstLaunching();
  Future<Either<Failure, Unit>> setFirstLaunch({bool isFirstLaunch});
}
