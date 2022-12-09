part of 'on_boarding_cubit.dart';

abstract class OnBoardingState extends Equatable {
  const OnBoardingState();

  @override
  List<Object> get props => [];
}

class OnBoardingInitial extends OnBoardingState {
  const OnBoardingInitial({
    required this.onBoardingObject,
  });
  final OnBoardingObject onBoardingObject;

  @override
  List<Object> get props => [onBoardingObject];
}

class FinishOnBoarding extends OnBoardingState {}

class ErrorState extends OnBoardingState {
  const ErrorState({required this.message});
  final String message;
}
