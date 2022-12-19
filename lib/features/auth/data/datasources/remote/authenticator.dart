import 'package:mythic_todo/features/auth/data/datasources/remote/dto/request/user_request_dto.dart';
import 'package:mythic_todo/features/auth/domain/model/user_model.dart';

typedef Token = String;

abstract class Authenticator {
  Future<UserModel> signUp({required UserRequestDto userRequestDto});
  Future<UserModel> signIn({required String email, required String password});
  Future<UserModel> getUserInfo({required String uid});
}
