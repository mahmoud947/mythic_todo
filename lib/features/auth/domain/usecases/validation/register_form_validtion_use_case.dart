// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';

import 'package:mythic_todo/core/error/failures.dart';
import 'package:mythic_todo/core/usecase/base_use_case.dart';
import 'package:mythic_todo/features/auth/domain/usecases/validation/auth_form_validation_use_cases.dart';
import 'package:mythic_todo/features/auth/domain/usecases/validation/confirm_password_validation_use_case.dart';
import 'package:mythic_todo/features/auth/domain/usecases/validation/email_validation_use_case.dart';
import 'package:mythic_todo/features/auth/presentation/bloc/sign_up/sign_up_bloc.dart';

class RegisterFormValidationUseCase extends BaseUseCase<SignUpFormState, bool> {
  final AuthFormValidationUseCase validation;
  RegisterFormValidationUseCase({
    required this.validation,
  });
  @override
  Future<Either<Failure, bool>> call(SignUpFormState input) async {
    final emailValidation =
        await validation.emailValidationUseCase(input.email);
    final fNameValidation =
        await validation.firstNameValidationUseCase(input.firstName);
    final lNameValidation =
        await validation.lastNameValidationUseCase(input.lastNameError);
    final passwordValidation =
        await validation.passwordValidationUseCase(input.password);
    final confirmPasswordValidation =
        await validation.confirmPasswordValidationUseCase(
      ConfirmPasswordValidationUseCaseInput(
        password: input.password,
        confirmPassword: input.confirmPassword,
      ),
    );

    if (emailValidation.isRight() &&
        fNameValidation.isRight() &&
        lNameValidation.isRight() &&
        passwordValidation.isRight() &&
        confirmPasswordValidation.isRight()) {
      return const Right(true);
    } else {
      return Left(InvalidInputFailure(message: ''));
    }
  }
}
