import 'package:dartz/dartz.dart';
import '../../../../core/network/network_helper.dart';
import '../mapper/auth_mapper.dart';
import '../datasources/remote/dto/request/user_request_dto.dart';
import '../datasources/remote/authenticator.dart';
import '../datasources/remote/dto/response/user_response_dto.dart';
import '../datasources/remote/social_authenticator.dart';
import '../../domain/model/user_model.dart';
import '../../../../core/error/error_strings.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/local/auth_dao.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl({
    required this.authDao,
    required this.socialAuthenticator,
    required this.authenticator,
    required this.networkHelper,
  });
  final AuthDao authDao;
  final SocialAuthenticator socialAuthenticator;
  final Authenticator authenticator;
  final NetworkHelper networkHelper;

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
  Future<Either<Failure, UserModel>> signUp(
      {required UserRequestDto userRequestDto}) async {
    try {
      final UserModel userModel =
          await authenticator.signUp(userRequestDto: userRequestDto);

      return Right(userModel);
    } on FirebaseAuthAccountAlreadyExistException catch (e) {
      return Left(FirebaseAuthAccountAlreadyExistFailure(message: e.message));
    } on UnKnownException catch (e) {
      return Left(UnKnownFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, UserModel>> getUserInfo({required String uid}) async {
    if (await networkHelper.isConnected) {
      try {
        final userInfo = await authenticator.getUserInfo(uid: uid);

        final UserResponseDto userResponseDto = UserResponseDto(
          email: userInfo.email,
          displayName: userInfo.displayName,
          imageUrl: userInfo.imageUrl,
          uid: userInfo.uid,
        );
        authDao.updateLocalUserInfo(userResponseDto: userResponseDto);
        return Right(userInfo);
      } on UserNotFoundException catch (e) {
        return Left(UserNotFoundFailure(message: e.message));
      } on UnKnownException catch (e) {
        return Left(UnKnownFailure(message: e.message));
      } on AppSettingException catch (e) {
        return Left(AppSettingFailure(message: e.message));
      }
    } else {
      try {
        final userInfo = await authDao.getLocalUserInfo();
        return Right(userInfo.toDomain());
      } on UserNotFoundException catch (e) {
        return Left(UserNotFoundFailure(message: e.message));
      }
    }
  }

  @override
  Future<Either<Failure, UserModel>> singIn(
      {required String email, required String password}) async {
    try {
      final result =
          await authenticator.signIn(email: email, password: password);
      return Right(result);
    } on SignInException catch (e) {
      return Left(SignInFailure(message: e.message));
    } on UnKnownException catch (e) {
      return Left(UnKnownFailure(message: e.message));
    }
  }
}
