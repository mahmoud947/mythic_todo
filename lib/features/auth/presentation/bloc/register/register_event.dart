part of 'register_bloc.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class SignInWithGoogleEvent extends RegisterEvent {}

class SignUpEvent extends RegisterEvent {
  const SignUpEvent({required this.userRequestDto});
  final UserRequestDto userRequestDto;
}
