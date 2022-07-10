import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashInitial()) {
    _navigate();
  }

  _navigate() async {
    await Future.delayed(const Duration(milliseconds: 5000));
    emit(NavigateState());
  }
}
