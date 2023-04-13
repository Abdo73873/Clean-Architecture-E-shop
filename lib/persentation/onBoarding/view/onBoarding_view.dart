import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mena/app/app_prefs.dart';
import 'package:mena/app/di.dart';
import 'package:mena/domain/model/models.dart';
import 'package:mena/persentation/onBoarding/viewmodel/onBoarding_viewmodel.dart';
import 'package:mena/persentation/resources/assets_manager.dart';
import 'package:mena/persentation/resources/color_manager.dart';
import 'package:mena/persentation/resources/constant_manager.dart';
import 'package:mena/persentation/resources/strings_manager.dart';
import 'package:mena/persentation/resources/values_manager.dart';

import '../../resources/routes_manger.dart';

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({Key? key}) : super(key: key);

  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {
  final OnBoardingViewModel _viewModel=OnBoardingViewModel();
  void _bind(){
    instance<AppPreferences>().setOnBoardingScreenViewed();
    _viewModel.start();
  }
  @override
  void initState() {
    _bind();
super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<SliderViewObject>(
      stream: _viewModel.outputSliderViewObject,
      builder: (context, snapshot) =>  _getContentWidget(snapshot.data),);
  }

Widget _getContentWidget(SliderViewObject? sliderViewObject){
if(sliderViewObject==null){
  return const Scaffold(body:  SizedBox());
}
 return Scaffold(
    backgroundColor: ColorManager.white,
    appBar: AppBar(
      backgroundColor: ColorManager.white,
      elevation: 0,
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: ColorManager.white,
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark,
      ),
    ),
    body: PageView.builder(
      controller: _viewModel.pageController,
      itemCount: sliderViewObject.numOfSlides,
      onPageChanged: (value) {
       _viewModel.onPageChange(value);
      },
      itemBuilder: (context, index) => OnBoardingPage(sliderViewObject.sliderObject),
    ),
    bottomSheet: Container(
      color: ColorManager.white,
      height: AppSize.s100,
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, Routes.loginRoute);
              },
              child: Text(
                AppStrings.skip,
                style: Theme.of(context).textTheme.labelLarge,
              ),
            ),
          ),
          _getBottomSheetWidget(sliderViewObject),
        ],
      ),
    ),
  );

}
  Widget _getBottomSheetWidget(SliderViewObject sliderViewObject) => Container(
        color: ColorManager.primary,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppPadding.p8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                _viewModel.goPreviousPage();
                },
                child: Padding(
                  padding: const EdgeInsets.all(AppPadding.p16),
                  child: SizedBox(
                    height: AppSize.s20,
                    width: AppSize.s20,
                    child: SvgPicture.asset(ImagesManager.leftArrowIc),
                  ),
                ),
              ),
              Row(
                children: [
                  for (int i = 0; i < sliderViewObject.numOfSlides; i++)
                    Padding(
                      padding: const EdgeInsets.all(AppPadding.p8),
                      child: _getProperCircle(i,sliderViewObject.currentIndex),
                    ),
                ],
              ),
              GestureDetector(
                onTap: (){
                 _viewModel.goNextPage();
                },
                child: Padding(
                  padding: const EdgeInsets.all(AppPadding.p16),
                  child: GestureDetector(
                    child: SizedBox(
                      height: AppSize.s20,
                      width: AppSize.s20,
                      child: SvgPicture.asset(ImagesManager.rightArrowIc),
                    ),
                  ),
                ),
              ),

            ],
          ),
        ),
      );

  Widget _getProperCircle(int index,int currentIndex) {
    if (index == currentIndex) {
      return SvgPicture.asset(ImagesManager.hollowCircleIc);
    } else {
      return SvgPicture.asset(ImagesManager.solidCircleIc);
    }
  }

  @override
  void dispose(){
    _viewModel.dispose();
    super.dispose();
  }

  }


class OnBoardingPage extends StatelessWidget {
  final SliderObject _sliderObject;

  const OnBoardingPage(this._sliderObject, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: AppSize.s40,
        ),
        Padding(
          padding: const EdgeInsets.all(AppPadding.p8),
          child: Text(
            _sliderObject.title,
            style: Theme.of(context).textTheme.displayLarge,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(AppPadding.p8),
          child: Text(
            _sliderObject.subTitle,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        const SizedBox(
          height: AppSize.s60,
        ),
        SvgPicture.asset(_sliderObject.image),
      ],
    );
  }
}

