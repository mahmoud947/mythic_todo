import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mythic_todo/features/auth/domain/usecases/auth_use_cases.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final AuthUseCases useCases;
  RegisterBloc({required this.useCases}) : super(RegisterInitial()) {
    on<RegisterEvent>((event, emit) {});
    on<SignInWithGoogleEvent>(_startSignInWithGoogleFlow);
  }

  void _startSignInWithGoogleFlow(
      SignInWithGoogleEvent event, Emitter<RegisterState> emit) async {
    emit(RegisterLoading());
    final either = await useCases.signInWithGoogleUseCase();
    either.fold(
      (failure) => emit(
        RegisterError(message: failure.message),
      ),
      (credential) => emit(
        RegisterSuccessfully(userCredential: credential),
      ),
    );
  }
}
