// ignore_for_file: public_member_api_docs, sort_constructors_first
class EmptyNotesDataException implements Exception {
  String? message;
  EmptyNotesDataException({
    this.message,
  });
}

class LocalDatabaseException implements Exception {
  String? message;
  LocalDatabaseException({
    this.message,
  });
}
