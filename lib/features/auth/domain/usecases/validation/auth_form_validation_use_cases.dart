import '../../../../../core/usecase/text_field_validation_use_case.dart';
import 'confirm_password_validation_use_case.dart';
import 'email_validation_use_case.dart';
import 'password_validation_use_case.dart';

class AuthFormValidationUseCase {
  AuthFormValidationUseCase({
    required this.firstNameValidationUseCase,
    required this.lastNameValidationUseCase,
    required this.passwordValidationUseCase,
    required this.confirmPasswordValidationUseCase,
    required this.emailValidationUseCase,
  });
  final TextFieldValidationUseCase firstNameValidationUseCase;
  final TextFieldValidationUseCase lastNameValidationUseCase;
  final PasswordValidationUseCase passwordValidationUseCase;
  final ConfirmPasswordValidationUseCase confirmPasswordValidationUseCase;
  final EmailValidationUseCase emailValidationUseCase;
}
