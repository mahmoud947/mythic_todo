import 'package:mythic_todo/features/auth/data/datasources/remote/dto/request/user_request_dto.dart';
import 'package:mythic_todo/features/auth/data/datasources/remote/dto/response/user_response_dto.dart';

typedef Token = String;

abstract class Authenticator {
  Future<Token?> signUp({required UserRequestDto userRequestDto});
}
