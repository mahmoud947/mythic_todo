// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserRequestDto {
  UserRequestDto({
    required this.email,
    required this.displayName,
    required this.password,
  });
  final String email;
  final String displayName;
  final String password;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'displayName': displayName,
      'password': password,
    };
  }

  factory UserRequestDto.fromMap(Map<String, dynamic> map) {
    return UserRequestDto(
      email: map['email'] as String,
      displayName: map['displayName'] as String,
      password: map['password'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserRequestDto.fromJson(String source) =>
      UserRequestDto.fromMap(json.decode(source) as Map<String, dynamic>);
}
