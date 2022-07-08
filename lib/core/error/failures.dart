// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class AppSettingFailure extends Failure {
  AppSettingFailure({this.message});
  final String? message;
  @override
  List<Object?> get props => [message];
}

class EmptyNotesDataFailure extends Failure {
  EmptyNotesDataFailure({this.message});
  final String? message;

  @override
  List<Object?> get props => [message];
}

class LocalDatabaseFailure extends Failure {
  LocalDatabaseFailure({this.message});
  final String? message;
  @override
  List<Object?> get props => [message];
}

class LocalDatabaseNotFoundFailure extends Failure {
  LocalDatabaseNotFoundFailure({this.message});
  final String? message;
  @override
  List<Object?> get props => [message];
}
