// ignore_for_file: public_member_api_docs, sort_constructors_first
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
