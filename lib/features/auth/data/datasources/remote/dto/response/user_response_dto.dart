// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:firebase_auth/firebase_auth.dart';

class UserResponseDto {
  UserResponseDto({
    required this.uid,
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
}
