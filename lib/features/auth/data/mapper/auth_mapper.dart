import 'package:mythic_todo/core/util/extensions.dart';
import 'package:mythic_todo/features/auth/data/datasources/remote/dto/response/user_response_dto.dart';
import 'package:mythic_todo/features/auth/domain/model/user_model.dart';

extension UserDtoToDomain on UserResponseDto {
  UserModel toDomain() => UserModel(
        uid: uid.orEmpty(),
        email: email.orEmpty(),
        displayName: displayName.orEmpty(),
        imageUrl: imageUrl.orEmpty(),
      );
}
