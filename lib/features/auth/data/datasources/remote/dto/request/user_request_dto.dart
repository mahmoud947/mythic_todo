import 'dart:convert';

class UserRequestDto {
  UserRequestDto({
    required this.email,
    required this.displayName,
    required this.password,
    this.imageUrl,
  });
  final String email;
  final String displayName;
  final String? imageUrl;
  final String password;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'displayName': displayName,
      'imageUrl': imageUrl,
    };
  }

  String toJson() => json.encode(toMap());
}
