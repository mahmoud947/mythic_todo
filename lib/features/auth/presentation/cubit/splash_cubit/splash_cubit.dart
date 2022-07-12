import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
          emit(NavigateToHome());
        } else {
          emit(NavigateToOnBoarding());
        }
      },
    );
  }
}
