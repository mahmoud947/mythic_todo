import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../utils/on_boarding_object.dart';

import '../../../../common/app_strings.dart';
import '../../../../common/image_resources.dart';

part 'on_boarding_state.dart';

class OnBoardingCubit extends Cubit<OnBoardingInitial> {
  final List<OnBoardingObject> _pages = [
    OnBoardingObject(
      title: AppStrings.onBoardingTitleOne,
      subTitle: AppStrings.onBoardingSubTitleOne,
      backGroundImage: ImageResources.onBoardingBackgroundOne,
    ),
    OnBoardingObject(
        title: AppStrings.onBoardingTitleTwo,
        subTitle: AppStrings.onBoardingSubTitleTwo,
        backGroundImage: ImageResources.onBoardingBackgroundTwo,
        logo: ImageResources.onBoardingLogoOne),
    OnBoardingObject(
        title: AppStrings.onBoardingTitleThree,
        subTitle: AppStrings.onBoardingSubTitleThree,
        backGroundImage: ImageResources.onBoardingBackgroundTwo,
        logo: ImageResources.onBoardingLogoTwo),
  ];
  OnBoardingCubit()
      : super(
          OnBoardingInitial(
            onBoardingObject: OnBoardingObject(
              title: AppStrings.onBoardingTitleOne,
              subTitle: AppStrings.onBoardingSubTitleOne,
              backGroundImage: ImageResources.onBoardingBackgroundOne,
            ),
          ),
        );
  int _currentIndex = 0;

  getNextPage() {
    if (_currentIndex < _pages.length - 1) {
      return ++_currentIndex;
    } else {
      return _currentIndex;
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
