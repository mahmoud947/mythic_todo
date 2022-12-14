// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'sign_up_bloc.dart';

abstract class SignUpEvent extends Equatable {
  const SignUpEvent();

  @override
  List<Object> get props => [];
}

class OnFirstNameChangeEvent extends SignUpEvent {
  const OnFirstNameChangeEvent({required this.firstName});
  final String firstName;
  @override
  List<Object> get props => [firstName];
}

class OnLastNameChangeEvent extends SignUpEvent {
  const OnLastNameChangeEvent({required this.lastName});
  final String lastName;
  @override
  List<Object> get props => [lastName];
}

class OnEmailChangeEvent extends SignUpEvent {
  const OnEmailChangeEvent({required this.email});
  final String email;
  @override
  List<Object> get props => [email];
}

class OnPasswordChangeEvent extends SignUpEvent {
  const OnPasswordChangeEvent({required this.password});
  final String password;
  @override
  List<Object> get props => [password];
}

class OnConfirmPasswordChangeEvent extends SignUpEvent {
  const OnConfirmPasswordChangeEvent({required this.confirmPassword});
  final String confirmPassword;
  @override
  List<Object> get props => [confirmPassword];
}

class OnSubmitEvent extends SignUpEvent {}
