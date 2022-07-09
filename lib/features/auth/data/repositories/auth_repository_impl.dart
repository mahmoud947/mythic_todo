import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/local/auth_dao.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl({required this.authDao});
  final AuthDao authDao;

  @override
  Either<Failure, bool> isFirstLaunching() {
    try {
      final result = authDao.isFirstLaunching();
      return Right(result);
    } on AppSettingException catch (e) {
      return Left(AppSettingFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, Unit>> setFirstLaunch(
      {required bool isFirstLaunch}) async {
    try {
      await authDao.setFirstLaunch(isFirstLaunch: isFirstLaunch);
      return const Right(unit);
    } on AppSettingException catch (e) {
      return Left(AppSettingFailure(message: e.message));
    }
  }
}
