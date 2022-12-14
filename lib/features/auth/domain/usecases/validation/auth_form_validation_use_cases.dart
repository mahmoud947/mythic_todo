import 'package:mythic_todo/core/usecase/text_field_validation_use_case.dart';
import 'package:mythic_todo/features/auth/domain/usecases/validation/confirm_password_validation_use_case.dart';
import 'package:mythic_todo/features/auth/domain/usecases/validation/email_validation_use_case.dart';
import 'package:mythic_todo/features/auth/domain/usecases/validation/password_validation_use_case.dart';
import 'package:mythic_todo/features/auth/domain/usecases/validation/register_form_validtion_use_case.dart';

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
