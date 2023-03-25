import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mena/domain/model/models.dart';
import 'package:mena/persentation/base/base_viewmodel.dart';
import 'package:mena/persentation/resources/constant_manager.dart';

import '../../resources/assets_manager.dart';
import '../../resources/strings_manager.dart';

class OnBoardingViewModel extends BaseViewModel
    with OnBoardingViewModelInputs,OnBoardingViewModelOutputs{
  //stream controller outputs
final StreamController _streamController=StreamController<SliderViewObject>();
late final List<SliderObject> _list;
final PageController pageController = PageController();

 int _currentIndex = 0;


  //onBoarding viewModel inputs
  @override
  void start() {
    _list=_getSliderData();
  _postDataToView();
  }

  @override
  void dispose() {
    _streamController.close();
  }

  @override
  int goNext() {
    int nextIndex = ++_currentIndex;
    if (nextIndex == _list.length) {
      nextIndex = 0;
    }
    return nextIndex;
  }

  @override
  int goPrevious() {
    int previousIndex = --_currentIndex;
    if (previousIndex == -1) {
      previousIndex = _list.length - 1;
    }
    return previousIndex;  }

  @override
  void onPageChange(int index) {
    _currentIndex=index;
    _postDataToView();
  }

  void goPreviousPage(){
    pageController.animateToPage(goPrevious(),
        duration: const Duration(
            milliseconds: AppConstants.sliderAnimationTime),
        curve: Curves.bounceInOut);
  }
  void goNextPage(){
    pageController.animateToPage(goNext(),
        duration: const Duration(
            milliseconds: AppConstants.sliderAnimationTime),
        curve: Curves.bounceInOut);
  }
  @override
  // TODO: implement inputSliderViewObject
  Sink get inputSliderViewObject => _streamController.sink;

  @override
  // TODO: implement outputSliderViewObject
  Stream<SliderViewObject> get outputSliderViewObject => _streamController.stream.map((sliderViewObject) =>sliderViewObject );

  //onBoarding private function
List<SliderObject> _getSliderData() => [
  SliderObject(AppStrings.onBoardingTitle1,
      AppStrings.onBoardingSubTitle1, ImagesManager.onBoardingLogo1),
  SliderObject(AppStrings.onBoardingTitle2,
      AppStrings.onBoardingSubTitle2, ImagesManager.onBoardingLogo2),
  SliderObject(AppStrings.onBoardingTitle3,
      AppStrings.onBoardingSubTitle3, ImagesManager.onBoardingLogo3),
  SliderObject(AppStrings.onBoardingTitle4,
      AppStrings.onBoardingSubTitle4, ImagesManager.onBoardingLogo4),
];
void _postDataToView(){
  inputSliderViewObject.add(SliderViewObject(_list[_currentIndex], _list.length, _currentIndex));
}
}

//inputs that our view model will receive from view (actions)
abstract class OnBoardingViewModelInputs{
  int goNext();
  int goPrevious();
  void onPageChange(int index);

  Sink get inputSliderViewObject;
}

abstract class OnBoardingViewModelOutputs{
  Stream<SliderViewObject> get outputSliderViewObject;

}
