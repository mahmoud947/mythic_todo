import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/util/extensions.dart';
import '../../../data/datasources/remote/dto/request/user_request_dto.dart';
import '../../../domain/model/user_model.dart';
import '../../../domain/usecases/auth_use_cases.dart';
import '../../../domain/usecases/validation/auth_form_validation_use_cases.dart';
import '../../../domain/usecases/validation/confirm_password_validation_use_case.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final AuthFormValidationUseCase authFormValidationUseCase;
  final AuthUseCases authUseCases;

  SignUpBloc(
      {required this.authFormValidationUseCase, required this.authUseCases})
      : super(const SignUpFormState()) {
    on<OnFirstNameChangeEvent>(
      (event, emit) async => await _onFirstNameChange(event, emit),
    );

    on<OnLastNameChangeEvent>(
      (event, emit) async => await _onLastNameChange(event, emit),
    );

    on<OnEmailChangeEvent>(
      (event, emit) async => await _onEmailChange(event, emit),
    );

    on<OnPasswordChangeEvent>(
      (event, emit) async => await _onPasswordChange(event, emit),
    );

    on<OnConfirmPasswordChangeEvent>(
      (event, emit) async => await _onConfirmPasswordChange(event, emit),
    );

    on<OnSubmitEvent>(
      (event, emit) async => await _onSubmit(emit),
    );
  }

  _isAllInputValid(SignUpEvent event, Emitter<SignUpState> emit) {
    final formState = (state as SignUpFormState);
    final isFormValid = formState.firstName.isNotEmpty &&
        formState.lastName.isNotEmpty &&
        formState.email.isNotEmpty &&
        formState.password.isNotEmpty &&
        formState.confirmPassword.isNotEmpty;

    emit(formState.copyWith(isFormValid: isFormValid));
  }

  Future<void> _onSubmit(Emitter<SignUpState> emit) async {
    final formState = (state as SignUpFormState);
    final either = await authUseCases.signUpUseCase(
      input: UserRequestDto(
        email: formState.email,
        displayName: '${formState.firstName} ${formState.lastName}',
        password: formState.password,
      ),
    );

    either.fold(
      (failure) {
        if (failure is FirebaseAuthAccountAlreadyExistFailure) {
          emit(UserAlreadyExistState(message: failure.message.orEmpty()));
        } else {
          emit(SignUpErrorState(message: failure.message));
        }
      },
      (userModel) => emit(SignUpSuccessfully(userModel: userModel)),
    );
  }

  Future<void> _onConfirmPasswordChange(
    OnConfirmPasswordChangeEvent event,
    Emitter<SignUpState> emit,
  ) async {
    final currentState = (state as SignUpFormState);
    final either =
        await authFormValidationUseCase.confirmPasswordValidationUseCase(
            input: ConfirmPasswordValidationUseCaseInput(
      password: currentState.password,
      confirmPassword: event.confirmPassword,
    ));

    failureState(message) => currentState.copyWith(
          confirmPasswordError: Wrapped.value(message),
          confirmPassword: '',
          isFormValid: false,
        );
    successState(input) => currentState.copyWith(
          confirmPassword: input,
          confirmPasswordError: const Wrapped.value(null),
        );

    either.fold(
      (failure) => emit(failureState(failure.message)),
      (input) {
        emit(successState(input));
        _isAllInputValid(event, emit);
      },
    );
  }

  Future<void> _onPasswordChange(
    OnPasswordChangeEvent event,
    Emitter<SignUpState> emit,
  ) async {
    final confirmPasswordEither = await authFormValidationUseCase
        .passwordValidationUseCase(input: event.password);
    final currentState = state as SignUpFormState;

    failureState(message) => currentState.copyWith(
          passwordError: Wrapped.value(message),
          password: '',
          isFormValid: false,
        );
    successState(input) => currentState.copyWith(
          password: input,
          passwordError: const Wrapped.value(null),
        );
    confirmPasswordEither.fold(
      (failure) => emit(failureState(failure.message)),
      (input) {
        emit(successState(input));
        _isAllInputValid(event, emit);
      },
    );
  }

  Future<void> _onEmailChange(
    OnEmailChangeEvent event,
    Emitter<SignUpState> emit,
  ) async {
    final passwordValidationEither = await authFormValidationUseCase
        .emailValidationUseCase(input: event.email);
    final currentState = state as SignUpFormState;

    failureState(message) => currentState.copyWith(
          emailError: Wrapped.value(message),
          email: '',
          isFormValid: false,
        );
    successState(input) => currentState.copyWith(
          email: input,
          emailError: const Wrapped.value(null),
        );

    passwordValidationEither.fold(
      (failure) => emit(failureState(failure.message)),
      (input) {
        emit(successState(input));
        _isAllInputValid(event, emit);
      },
    );
  }

  Future<void> _onFirstNameChange(
    OnFirstNameChangeEvent event,
    Emitter<SignUpState> emit,
  ) async {
    final firstNameEither = await authFormValidationUseCase
        .firstNameValidationUseCase(input: event.firstName);
    final currentState = state as SignUpFormState;
    failureState(message) => currentState.copyWith(
        firstNameError: Wrapped.value(message),
        firstName: '',
        isFormValid: false);
    successState(input) => currentState.copyWith(
          firstName: input,
          firstNameError: const Wrapped.value(null),
        );

    firstNameEither.fold(
      (failure) => emit(failureState(failure.message)),
      (input) {
        emit(successState(input));
        _isAllInputValid(event, emit);
      },
    );
  }

  Future<void> _onLastNameChange(
    OnLastNameChangeEvent event,
    Emitter<SignUpState> emit,
  ) async {
    final lastNameValidationEither = await authFormValidationUseCase
        .lastNameValidationUseCase(input: event.lastName);
    final currentState = state as SignUpFormState;
    failureState(message) => currentState.copyWith(
        lastNameError: Wrapped.value(message),
        lastName: '',
        isFormValid: false);
    successState(input) => currentState.copyWith(
          lastName: input,
          lastNameError: const Wrapped.value(null),
        );
    lastNameValidationEither.fold(
      (failure) => emit(failureState(failure.message)),
      (input) {
        emit(successState(input));
        _isAllInputValid(event, emit);
      },
    );
  }
}
