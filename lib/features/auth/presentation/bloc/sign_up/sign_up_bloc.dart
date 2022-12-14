import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mythic_todo/features/auth/domain/usecases/validation/auth_form_validation_use_cases.dart';
import 'package:mythic_todo/features/auth/domain/usecases/validation/confirm_password_validation_use_case.dart';
import 'package:mythic_todo/features/auth/domain/usecases/validation/register_form_validtion_use_case.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final AuthFormValidationUseCase _authFormValidationUseCase;
  final RegisterFormValidationUseCase _registerFormValidationUseCase;

  SignUpBloc(
      this._authFormValidationUseCase, this._registerFormValidationUseCase)
      : super(const SignUpFormState()) {
    on<OnFirstNameChangeEvent>(
      (event, emit) async {
        final firstNameEither = await _authFormValidationUseCase
            .firstNameValidationUseCase(event.firstName);

        firstNameEither.fold(
            (failure) => emit(
                  (state as SignUpFormState).copyWith(
                    firstNameError: Wrapped.value(failure.message),
                    firstName: '',
                    isFormValid: false,
                  ),
                ), (input) {
          emit(
            (state as SignUpFormState).copyWith(
              firstName: input,
              firstNameError: const Wrapped.value(null),
            ),
          );
          isAllInputValid(event, emit);
        });
      },
    );

    on<OnLastNameChangeEvent>(
      (event, emit) async {
        final lastNameValidationEither = await _authFormValidationUseCase
            .lastNameValidationUseCase(event.lastName);

        lastNameValidationEither.fold(
          (failure) => emit(
            (state as SignUpFormState).copyWith(
              lastNameError: Wrapped.value(failure.message),
              lastName: '',
              isFormValid: false,
            ),
          ),
          (input) {
            emit(
              (state as SignUpFormState).copyWith(
                lastName: input,
                lastNameError: const Wrapped.value(null),
              ),
            );
            isAllInputValid(event, emit);
          },
        );
      },
    );

    on<OnEmailChangeEvent>(
      (event, emit) async {
        final passwordValidationEither = await _authFormValidationUseCase
            .emailValidationUseCase(event.email);

        passwordValidationEither.fold(
          (failure) => emit(
            (state as SignUpFormState).copyWith(
              emailError: Wrapped.value(failure.message),
              email: '',
              isFormValid: false,
            ),
          ),
          (input) {
            emit(
              (state as SignUpFormState).copyWith(
                email: input,
                emailError: const Wrapped.value(null),
              ),
            );
            isAllInputValid(event, emit);
          },
        );
      },
    );

    on<OnPasswordChangeEvent>((event, emit) async {
      final confirmPasswordEither = await _authFormValidationUseCase
          .passwordValidationUseCase(event.password);

      confirmPasswordEither.fold(
        (failure) => emit(
          (state as SignUpFormState).copyWith(
            passwordError: Wrapped.value(failure.message),
            password: '',
            isFormValid: false,
          ),
        ),
        (input) {
          emit(
            (state as SignUpFormState).copyWith(
              password: input,
              passwordError: const Wrapped.value(null),
            ),
          );
          isAllInputValid(event, emit);
        },
      );
    });

    on<OnConfirmPasswordChangeEvent>((event, emit) async {
      final currentState = (state as SignUpFormState);
      final either =
          await _authFormValidationUseCase.confirmPasswordValidationUseCase(
              ConfirmPasswordValidationUseCaseInput(
        password: currentState.password,
        confirmPassword: event.confirmPassword,
      ));

      either.fold(
        (failure) => emit(
          (state as SignUpFormState).copyWith(
            confirmPasswordError: Wrapped.value(failure.message),
            confirmPassword: '',
            isFormValid: false,
          ),
        ),
        (input) {
          emit(
            (state as SignUpFormState).copyWith(
              confirmPassword: input,
              confirmPasswordError: const Wrapped.value(null),
            ),
          );
          isAllInputValid(event, emit);
        },
      );
    });

    on<OnSubmitEvent>((event, emit) {
      emit(SignUpSuccessfully());
    });
  }
  isAllInputValid(SignUpEvent event, Emitter<SignUpState> emit) {
    final formState = (state as SignUpFormState);
    final isFormValid = formState.firstName.isNotEmpty &&
        formState.lastName.isNotEmpty &&
        formState.email.isNotEmpty &&
        formState.password.isNotEmpty &&
        formState.confirmPassword.isNotEmpty;

    emit(formState.copyWith(isFormValid: isFormValid));
  }
}
