import 'package:dartz/dartz.dart';
import 'package:mythic_todo/features/auth/data/datasources/remote/dto/request/user_request_dto.dart';
import 'package:mythic_todo/features/auth/data/datasources/remote/authenticator.dart';
import 'package:mythic_todo/features/auth/data/datasources/remote/dto/response/user_response_dto.dart';
import 'package:mythic_todo/features/auth/data/datasources/remote/social_authenticator.dart';
import '../../../../core/error/error_strings.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/local/auth_dao.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(
      {required this.authDao,
      required this.socialAuthenticator,
      required this.authenticator});
  final AuthDao authDao;
  final SocialAuthenticator socialAuthenticator;
  final Authenticator authenticator;

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
  Future<Either<Failure, UserResponseDto>> signInWithGoogle() async {
    try {
      final userDto = await socialAuthenticator.signInWithGoogle();
      return Right(userDto);
    } on FirebaseAuthAccountAlreadyExistException catch (e) {
      return Left(FirebaseAuthAccountAlreadyExistFailure(message: e.message));
    } on UnKnownException catch (e) {
      return Left(UnKnownFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, Token?>> signUp(
      {required UserRequestDto userRequestDto}) async {
    try {
      final Token? token =
          await authenticator.signUp(userRequestDto: userRequestDto);
      return Right(token);
    } on FirebaseAuthAccountAlreadyExistException catch (e) {
      return Left(FirebaseAuthAccountAlreadyExistFailure(message: e.message));
    } on UnKnownException catch (e) {
      return Left(UnKnownFailure(message: e.message));
    }
  }
}
