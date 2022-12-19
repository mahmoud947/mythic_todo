import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mythic_todo/features/auth/data/datasources/remote/dto/request/user_request_dto.dart';
import 'package:mythic_todo/features/auth/data/datasources/remote/dto/response/user_response_dto.dart';
import 'package:mythic_todo/features/auth/domain/model/user_model.dart';

import '../../../../core/error/failures.dart';

abstract class AuthRepository {
  /// check if it first time lunching application
  /// to show onBoarding screen or not
  Either<Failure, bool> isFirstLaunching();

  /// set is first time launching application
  Future<Either<Failure, Unit>> setFirstLaunch({required bool isFirstLaunch});

  /// sign in with google account
  Future<Either<Failure, UserResponseDto>> signInWithGoogle();

  // sign in with email and password
  Future<Either<Failure, UserModel>> singIn({
    required String email,
    required String password,
  });

  /// sign in with email and password
  Future<Either<Failure, UserModel>> signUp({
    required UserRequestDto userRequestDto,
  });

  Future<Either<Failure, UserModel>> getUserInfo({required String uid});
}
