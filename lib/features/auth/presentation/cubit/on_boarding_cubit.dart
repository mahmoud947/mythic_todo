import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/app_strings.dart';
import '../../../../common/image_resources.dart';
import '../utils/on_boarding_object.dart';

part 'on_boarding_state.dart';

class OnBoardingCubit extends Cubit<OnBoardingInitial> {
  final List<OnBoardingObject> _pages = [
    OnBoardingObject(
        title: AppStrings.onBoardingTitleOne,
        subTitle: AppStrings.onBoardingSubTitleOne,
        backGroundImage: ImageResources.onBoardingBackgroundOne,
        btnText: AppStrings.onBoardingNextBtnText),
    OnBoardingObject(
      title: AppStrings.onBoardingTitleTwo,
      subTitle: AppStrings.onBoardingSubTitleTwo,
      backGroundImage: ImageResources.onBoardingBackgroundTwo,
      logo: ImageResources.onBoardingLogoOne,
      btnText: AppStrings.onBoardingNextBtnText,
    ),
    OnBoardingObject(
      title: AppStrings.onBoardingTitleThree,
      subTitle: AppStrings.onBoardingSubTitleThree,
      backGroundImage: ImageResources.onBoardingBackgroundTwo,
      logo: ImageResources.onBoardingLogoTwo,
      btnText: AppStrings.onBoardingFinishBtnText,
    ),
  ];
  OnBoardingCubit()
      : super(
          OnBoardingInitial(
            onBoardingObject: OnBoardingObject(
                title: AppStrings.onBoardingTitleOne,
                subTitle: AppStrings.onBoardingSubTitleOne,
                backGroundImage: ImageResources.onBoardingBackgroundOne,
                btnText: AppStrings.onBoardingNextBtnText),
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
