// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'splash_cubit.dart';

abstract class SplashState extends Equatable {
  const SplashState();
  @override
  List<Object> get props => [];
}

class SplashInitial extends SplashState {}

class NavigateToOnBoarding extends SplashState {}

class NavigateToSignIn extends SplashState {}

class NavigateToHome extends SplashState {
  const NavigateToHome({
    required this.userModel,
  });
  final UserModel userModel;
}

class ErrorState extends SplashState {
  const ErrorState({this.message});
  final String? message;
}
