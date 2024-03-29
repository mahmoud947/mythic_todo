import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../common/app_strings.dart';
import '../../../../../../common/image_resources.dart';
import '../../../domain/usecases/auth_use_cases.dart';
import '../../utils/on_boarding_object.dart';

part 'on_boarding_state.dart';

class OnBoardingCubit extends Cubit<OnBoardingState> {
  final AuthUseCases useCases;

  final List<OnBoardingObject> _pages = [
    OnBoardingObject(
        title: AppStrings.onBoardingTitleOne,
        subTitle: AppStrings.onBoardingSubTitleOne,
        logo: ImageResources.onBoardingLogoOne,
        btnText: AppStrings.onBoardingNextBtnText),
    OnBoardingObject(
      title: AppStrings.onBoardingTitleTwo,
      subTitle: AppStrings.onBoardingSubTitleTwo,
      logo: ImageResources.onBoardingLogoTwo,
      btnText: AppStrings.onBoardingNextBtnText,
    ),
    OnBoardingObject(
      title: AppStrings.onBoardingTitleThree,
      subTitle: AppStrings.onBoardingSubTitleThree,
      logo: ImageResources.onBoardingLogoThree,
      btnText: AppStrings.onBoardingFinishBtnText,
    ),
  ];
  OnBoardingCubit({required this.useCases})
      : super(
          OnBoardingInitial(
            onBoardingObject: OnBoardingObject(
                title: AppStrings.onBoardingTitleOne,
                logo: ImageResources.onBoardingLogoOne,
                subTitle: AppStrings.onBoardingSubTitleOne,
                btnText: AppStrings.onBoardingNextBtnText),
          ),
        );
  int _currentIndex = 0;

  getNextPage() async {
    if (_currentIndex < _pages.length - 1) {
      return ++_currentIndex;
    } else {
      final either =
          await useCases.setIsFirstLaunchUseCase(isFirstLaunch: true);

      either.fold(
        (failure) => emit(
          ErrorState(message: failure.message),
        ),
        (success) => emit(
          FinishOnBoarding(),
        ),
      );
    }
  }

  getItemCount() => _pages.length;

  onPageChanged(int index) {
    _currentIndex = index;
    emit(
      OnBoardingInitial(onBoardingObject: _pages[_currentIndex]),
    );
  }
}
