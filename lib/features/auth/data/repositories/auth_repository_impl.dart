import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mythic_todo/features/auth/data/datasources/remote/social_authenticator.dart';
import '../../../../core/error/error_strings.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/local/auth_dao.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(
      {required this.authDao, required this.socialAuthenticator});
  final AuthDao authDao;
  final SocialAuthenticator socialAuthenticator;

  @override
  Either<Failure, bool> isFirstLaunching() {
    try {
      final result = authDao.isFirstLaunching();
      return Right(result);
    } catch (e) {
      return Left(AppSettingFailure(message: ErrorString.unexpectedError));
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

  @override
  Future<Either<Failure, UserCredential>> signInWithGoogle() async {
    try {
      final credential = await socialAuthenticator.signInWithGoogle();
      return Right(credential);
    } on FirebaseAuthAccountAlreadyExistException catch (e) {
      return Left(FirebaseAuthAccountAlreadyExistFailure(message: e.message));
    } on UnKnownException catch (e) {
      return Left(UnKnownFailure(message: e.message));
    }
  }
}
