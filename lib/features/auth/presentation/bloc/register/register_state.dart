part of 'register_bloc.dart';

abstract class RegisterState extends Equatable {
  const RegisterState();

  @override
  List<Object> get props => [];
}

class RegisterInitial extends RegisterState {}

class RegisterLoading extends RegisterState {}

class RegisterError extends RegisterState {
  const RegisterError({required this.message});
  final String message;
}

class RegisterSuccessfully extends RegisterState {
  const RegisterSuccessfully({required this.userModel});
  final UserModel userModel;
}
