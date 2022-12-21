import 'package:dartz/dartz.dart';
import '../remote/dto/response/user_response_dto.dart';

abstract class AuthDao {
  bool isFirstLaunching();
  //TODO:remove function args
  Future<Unit> setFirstLaunch({required bool isFirstLaunch});
  //? save user info on local storage
  Future<Unit> updateLocalUserInfo({required UserResponseDto userResponseDto});

  Future<UserResponseDto> getLocalUserInfo();
}
