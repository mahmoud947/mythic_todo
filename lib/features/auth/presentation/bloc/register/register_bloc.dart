import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/datasources/remote/dto/request/user_request_dto.dart';
import '../../../data/mapper/auth_mapper.dart';
import '../../../domain/model/user_model.dart';
import '../../../domain/usecases/auth_use_cases.dart';

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
      (userDto) {
        emit(
          RegisterSuccessfully(userModel: userDto.toDomain()),
        );
      },
    );
  }
}
