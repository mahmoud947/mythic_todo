part of 'splash_cubit.dart';

abstract class SplashState extends Equatable {
  const SplashState();
  @override
  List<Object> get props => [];
}

class SplashInitial extends SplashState {}

class NavigateToOnBoarding extends SplashState {}

class NavigateToHome extends SplashState {}

class ErrorState extends SplashState {
  const ErrorState({this.message});
  final String? message;
}
