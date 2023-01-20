import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';

class UserResponseDto {
  UserResponseDto({
    this.uid,
    required this.email,
    required this.displayName,
    required this.imageUrl,
  });
  final String? uid;
  final String? email;
  final String? displayName;
  final String? imageUrl;

  factory UserResponseDto.fromCredential(UserCredential userCredential) {
    final user = userCredential.user;
    return UserResponseDto(
      uid: user?.uid,
      email: user?.email,
      displayName: user?.displayName,
      imageUrl: user?.photoURL,
    );
  }
  factory UserResponseDto.fromMap(Map<String, dynamic> map) {
    return UserResponseDto(
      uid: map['uid'] != null ? map['uid'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      displayName:
          map['displayName'] != null ? map['displayName'] as String : null,
      imageUrl: map['imageUrl'] != null ? map['imageUrl'] as String : null,
    );
  }

  factory UserResponseDto.fromFirebaseCurrentUser(User? currentUser) {
    return UserResponseDto(
      email: currentUser?.email,
      displayName: currentUser?.displayName,
      imageUrl: currentUser?.photoURL,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'email': email,
      'displayName': displayName,
      'imageUrl': imageUrl,
    };
  }

  String toJson() => json.encode(toMap());

  factory UserResponseDto.fromJson(String source) =>
      UserResponseDto.fromMap(json.decode(source) as Map<String, dynamic>);
}
