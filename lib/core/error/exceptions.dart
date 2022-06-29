// ignore_for_file: public_member_api_docs, sort_constructors_first
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
