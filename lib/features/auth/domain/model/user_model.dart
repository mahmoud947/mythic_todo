// ignore_for_file: public_member_api_docs, sort_constructors_first

class UserModel {
  UserModel({
    required this.uid,
    required this.email,
    required this.displayName,
    required this.imageUrl,
  });
  final String uid;
  final String email;
  final String displayName;
  final String imageUrl;
}
