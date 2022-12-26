class AppSettingException implements Exception {
  AppSettingException({this.message});
  String? message;
}

class EmptyNotesDataException implements Exception {
  EmptyNotesDataException({this.message});
  String? message;
}

class LocalDatabaseException implements Exception {
  LocalDatabaseException({this.message});
  String? message;
}

class LocalDatabaseNotFoundException implements Exception {
  LocalDatabaseNotFoundException({this.message});
  String? message;
}

class FirebaseAuthAccountAlreadyExistException implements Exception {
  FirebaseAuthAccountAlreadyExistException({this.message});
  String? message;
}

class UnKnownException implements Exception {
  UnKnownException({this.message});
  String? message;
}

class UserNotFoundException implements Exception {
  UserNotFoundException({this.message});
  String? message;
}

class SignInException implements Exception {
  SignInException({this.message});
  String? message;
}

class RemoteDataSourceException implements Exception {
  RemoteDataSourceException({this.message});
  String? message;
}
