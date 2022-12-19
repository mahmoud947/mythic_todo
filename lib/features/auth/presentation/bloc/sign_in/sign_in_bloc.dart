import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mythic_todo/features/auth/data/mapper/auth_mapper.dart';
import 'package:mythic_todo/features/auth/domain/model/user_model.dart';

import '../../../domain/usecases/auth_use_cases.dart';
import '../../../domain/usecases/sign_in_use_case.dart';
import '../../../domain/usecases/validation/auth_form_validation_use_cases.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final AuthFormValidationUseCase authFormValidationUseCase;
  final AuthUseCases authUseCases;

  SignInBloc({
    required this.authFormValidationUseCase,
    required this.authUseCases,
  }) : super(const SignInFormState()) {
    on<OnEmailChangeEvent>((event, emit) => _onEmailChange(event, emit));
    on<OnPasswordChangeEvent>((event, emit) => _onPasswordChange(event, emit));
    on<OnSubmitEvent>((event, emit) => _onSubmit(emit));
    on<OnSignInWithGoogleEvent>((event, emit) => _onSignInWithGoogle(emit));
  }

  _isAllInputValid(SignInEvent event, Emitter<SignInState> emit) {
    final formState = (state as SignInFormState);
    final isFormValid =
        formState.email.isNotEmpty && formState.password.isNotEmpty;

    emit(formState.copyWith(isFormValid: isFormValid));
  }

  Future<void> _onEmailChange(
    OnEmailChangeEvent event,
    Emitter<SignInState> emit,
  ) async {
    final passwordValidationEither =
        await authFormValidationUseCase.emailValidationUseCase(event.email);
    final currentState = state as SignInFormState;

    failureState(message) => currentState.copyWith(
          emailError: Wrapper.value(message),
          email: '',
          isFormValid: false,
        );
    successState(input) => currentState.copyWith(
          email: input,
          emailError: const Wrapper.value(null),
        );

    passwordValidationEither.fold(
      (failure) => emit(failureState(failure.message)),
      (input) {
        emit(successState(input));
        _isAllInputValid(event, emit);
      },
    );
  }

  Future<void> _onPasswordChange(
    OnPasswordChangeEvent event,
    Emitter<SignInState> emit,
  ) async {
    final confirmPasswordEither = await authFormValidationUseCase
        .firstNameValidationUseCase(event.password);
    final currentState = state as SignInFormState;

    failureState(message) => currentState.copyWith(
          passwordError: Wrapper.value(message),
          password: '',
          isFormValid: false,
        );
    successState(input) => currentState.copyWith(
          password: input,
          passwordError: const Wrapper.value(null),
        );
    confirmPasswordEither.fold(
      (failure) => emit(failureState(failure.message)),
      (input) {
        emit(successState(input));
        _isAllInputValid(event, emit);
      },
    );
  }

  Future<void> _onSubmit(Emitter<SignInState> emit) async {
    final formState = (state as SignInFormState);
    final either = await authUseCases.signInUseCase(
      SignInUseCaseInput(email: formState.email, password: formState.password),
    );

    either.fold(
      (failure) {
        emit(SingInErrorState(message: failure.message));
        emit(const SignInFormState());
      },
      (userModel) => emit(SingInSuccessfulState(userModel: userModel)),
    );
  }

  _onSignInWithGoogle(Emitter<SignInState> emit) async {
    final either = await authUseCases.signInWithGoogleUseCase();
    either.fold(
      (failure) {
        emit(SingInErrorState(message: failure.message));
        emit(const SignInFormState());
      },
      (userDto) {
        emit(SingInSuccessfulState(userModel: userDto.toDomain()));
      },
    );
  }
}
