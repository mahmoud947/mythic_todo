extension NotNullInteger on int? {
  int orZero() {
    return this ?? 0;
  }
}

extension NotNullString on String? {
  String orEmpty() {
    return this ?? '';
  }
}

extension NotNullBoolean on bool? {
  bool orFalse() {
    return this ?? false;
  }
}

extension IntegerToBoolean on int {
  bool toBoolean() {
    return this == 0 ? false : true;
  }
}
