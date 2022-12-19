part of 'sign_in_bloc.dart';

abstract class SignInEvent extends Equatable {
  const SignInEvent();

  @override
  List<Object> get props => [];
}

class OnEmailChangeEvent extends SignInEvent {
  const OnEmailChangeEvent({required this.email});
  final String email;
  @override
  List<Object> get props => [email];
}

class OnPasswordChangeEvent extends SignInEvent {
  const OnPasswordChangeEvent({required this.password});
  final String password;
  @override
  List<Object> get props => [password];
}

class OnSubmitEvent extends SignInEvent {}

class OnSignInWithGoogleEvent extends SignInEvent {}
