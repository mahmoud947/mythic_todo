import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/util/extensions.dart';
import '../../../domain/model/user_model.dart';

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
      (isFirstLaunch) async {
        if (isFirstLaunch) {
          if (FirebaseAuth.instance.currentUser == null) {
            emit(NavigateToSignIn());
          } else {
            _getUserInfoOrReSignIn();
          }
        } else {
          emit(NavigateToOnBoarding());
        }
      },
    );
  }

  Future<void> _getUserInfoOrReSignIn() async {
    final userInfoEither = await useCases.getUserInfoUseCase(
        input: FirebaseAuth.instance.currentUser!.uid.orEmpty());

    userInfoEither.fold(
      (failure) => emit(NavigateToSignIn()),
      (userModel) => emit(NavigateToHome(userModel: userModel)),
    );
  }
}
