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
