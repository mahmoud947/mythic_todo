// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'sign_up_bloc.dart';

abstract class SignUpState extends Equatable {
  const SignUpState();

  @override
  List<Object?> get props => [];
}

class SignUpInitial extends SignUpState {}

class SignUpSuccessfully extends SignUpState {}

class SignUpFormState extends SignUpState {
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String confirmPassword;
  final String? firstNameError;
  final String? lastNameError;
  final String? emailError;
  final String? passwordError;
  final String? confirmPasswordError;
  final bool isFormValid;
  const SignUpFormState({
    this.firstName = '',
    this.lastName = '',
    this.email = '',
    this.password = '',
    this.confirmPassword = '',
    this.firstNameError,
    this.lastNameError,
    this.emailError,
    this.passwordError,
    this.confirmPasswordError,
    this.isFormValid = false,
  });

  SignUpFormState copyWith({
    String? firstName,
    String? lastName,
    String? email,
    String? password,
    String? confirmPassword,
    Wrapped<String?>? firstNameError,
    Wrapped<String?>? lastNameError,
    Wrapped<String?>? emailError,
    Wrapped<String?>? passwordError,
    Wrapped<String?>? confirmPasswordError,
    bool? isFormValid,
  }) {
    return SignUpFormState(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      firstNameError:
          firstNameError != null ? firstNameError.value : this.firstNameError,
      lastNameError:
          lastNameError != null ? lastNameError.value : this.lastNameError,
      emailError: emailError != null ? emailError.value : this.emailError,
      passwordError:
          passwordError != null ? passwordError.value : this.passwordError,
      confirmPasswordError: confirmPasswordError != null
          ? confirmPasswordError.value
          : this.confirmPasswordError,
      isFormValid: isFormValid ?? this.isFormValid,
    );
  }

  @override
  List<Object?> get props => [
        firstName,
        lastName,
        email,
        password,
        confirmPassword,
        emailError,
        firstNameError,
        lastNameError,
        passwordError,
        confirmPasswordError,
        isFormValid
      ];
}

class Wrapped<T> extends Equatable {
  final T value;
  const Wrapped.value(this.value);

  @override
  List<Object?> get props => [value];
}
