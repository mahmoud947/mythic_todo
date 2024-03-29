// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  get message;
  @override
  List<Object?> get props => [];
}

class AppSettingFailure extends Failure {
  AppSettingFailure({this.message}) : super();

  @override
  final String? message;
  @override
  List<Object?> get props => [message];
}

class EmptyNotesDataFailure extends Failure {
  EmptyNotesDataFailure({this.message});
  @override
  final String? message;

  @override
  List<Object?> get props => [message];
}

class LocalDatabaseFailure extends Failure {
  LocalDatabaseFailure({this.message});
  @override
  final String? message;
  @override
  List<Object?> get props => [message];
}

class LocalDatabaseNotFoundFailure extends Failure {
  LocalDatabaseNotFoundFailure({this.message});
  @override
  final String? message;
  @override
  List<Object?> get props => [message];
}

class FirebaseAuthAccountAlreadyExistFailure extends Failure {
  FirebaseAuthAccountAlreadyExistFailure({this.message});
  @override
  final String? message;
  @override
  List<Object?> get props => [message];
}

class UnKnownFailure extends Failure {
  UnKnownFailure({this.message});
  @override
  final String? message;
  @override
  List<Object?> get props => [message];
}

class InvalidInputFailure extends Failure {
  InvalidInputFailure({this.message});
  @override
  final String? message;
  @override
  List<Object?> get props => [message];
}

class UserNotFoundFailure extends Failure {
  UserNotFoundFailure({this.message});
  @override
  final String? message;
  @override
  List<Object?> get props => [message];
}

class SignInFailure extends Failure {
  SignInFailure({this.message});
  @override
  final String? message;
  @override
  List<Object?> get props => [message];
}

class RemoteDataSourceFailure extends Failure {
  RemoteDataSourceFailure({this.message});
  @override
  final String? message;
  @override
  List<Object?> get props => [message];
}
