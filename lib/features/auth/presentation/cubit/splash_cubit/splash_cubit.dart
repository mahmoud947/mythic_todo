import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mythic_todo/features/auth/data/datasources/remote/dto/request/user_request_dto.dart';
import 'package:mythic_todo/features/auth/data/datasources/remote/dto/response/user_response_dto.dart';
import 'package:mythic_todo/features/auth/data/mapper/auth_mapper.dart';
import 'package:mythic_todo/features/auth/domain/model/user_model.dart';

import '../../../../../application/app_constants.dart';
import '../../../domain/usecases/auth_use_cases.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  final AuthUseCases useCases;
  SplashCubit({required this.useCases}) : super(SplashInitial()) {
    _navigate();
  }

  _navigate() async {
    await Future.delayed(
      const Duration(milliseconds: AppConstants.SPLASH_SCREEN_TIME_OUT),
    );

    final either = useCases.checkIsFirstLaunchUseCase();
    either.fold(
      (failure) {
        emit(ErrorState(message: failure.message));
      },
      (isFirstLaunch) {
        if (isFirstLaunch) {
          if (FirebaseAuth.instance.currentUser == null) {
            emit(NavigateToSignIn());
          } else {
            final UserModel userModel = UserResponseDto.fromFirebaseCurrentUser(
                    FirebaseAuth.instance.currentUser)
                .toDomain();
            emit(NavigateToHome(userModel: userModel));
          }
        } else {
          emit(NavigateToOnBoarding());
        }
      },
    );
  }
}
