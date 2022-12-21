import '../../../../core/util/extensions.dart';
import '../../domain/model/user_model.dart';
import '../datasources/remote/dto/response/user_response_dto.dart';

extension UserDtoToDomain on UserResponseDto {
  UserModel toDomain() => UserModel(
        uid: uid.orEmpty(),
        email: email.orEmpty(),
        displayName: displayName.orEmpty(),
        imageUrl: imageUrl,
      );
}
