import '../../../../core/util/extensions.dart';
import '../datasources/remote/dto/response/user_response_dto.dart';
import '../../domain/model/user_model.dart';

extension UserDtoToDomain on UserResponseDto {
  UserModel toDomain() => UserModel(
        uid: uid.orEmpty(),
        email: email.orEmpty(),
        displayName: displayName.orEmpty(),
        imageUrl: imageUrl.orEmpty(),
      );
}
