import '../../../domain/model/user_model.dart';
import 'dto/request/user_request_dto.dart';

typedef Token = String;

abstract class Authenticator {
  Future<UserModel> signUp({required UserRequestDto userRequestDto});
  Future<UserModel> signIn({required String email, required String password});
  Future<UserModel> getUserInfo({required String uid});
}
