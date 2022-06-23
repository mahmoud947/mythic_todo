class EmptyNotesDataException implements Exception {
  EmptyNotesDataException({this.message});
  String? message;
}

class LocalDatabaseException implements Exception {
  LocalDatabaseException({this.message});
  String? message;
}
