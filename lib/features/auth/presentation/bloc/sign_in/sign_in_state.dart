// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'sign_in_bloc.dart';

abstract class SignInState extends Equatable {
  const SignInState();

  @override
  List<Object?> get props => [];
}

class SignInInitialState extends SignInState {}

class SingInLoadingState extends SignInState {}

class SignInFormState extends SignInState {
  const SignInFormState({
    this.email = '',
    this.password = '',
    this.emailError,
    this.passwordError,
    this.isFormValid = false,
  });
  final String email;
  final String password;
  final String? emailError;
  final String? passwordError;
  final bool isFormValid;

  SignInFormState copyWith({
    String? email,
    String? password,
    Wrapper<String?>? emailError,
    Wrapper<String?>? passwordError,
    bool? isFormValid,
  }) {
    return SignInFormState(
      email: email ?? this.email,
      password: password ?? this.password,
      emailError: emailError != null ? emailError.value : this.emailError,
      passwordError:
          passwordError != null ? passwordError.value : this.passwordError,
      isFormValid: isFormValid ?? this.isFormValid,
    );
  }

  @override
  List<Object?> get props =>
      [email, password, emailError, passwordError, isFormValid];
}

class SingInErrorState extends SignInState {
  const SingInErrorState({
    required this.message,
  });
  final String message;

  @override
  List<Object> get props => [message];
}

class SingInSuccessfulState extends SignInState {
  const SingInSuccessfulState();
}

class Wrapper<T> extends Equatable {
  final T value;
  const Wrapper.value(this.value);
  @override
  List<Object?> get props => [value];
}
