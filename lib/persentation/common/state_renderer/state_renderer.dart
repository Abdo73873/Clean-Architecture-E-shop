import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mena/data/network/failure.dart';
import 'package:mena/persentation/resources/assets_manager.dart';
import 'package:mena/persentation/resources/color_manager.dart';
import 'package:mena/persentation/resources/font_manager.dart';
import 'package:mena/persentation/resources/strings_manager.dart';
import 'package:mena/persentation/resources/style_manager.dart';
import 'package:mena/persentation/resources/values_manager.dart';

enum StateRendererType {
  //POPUP STATE (Dialog)
  popupLoadingState,
  popupSuccessState,
  popupErrorState,

  //full screen state (full screen)
  fullScreenLoadingState,
  fullScreenErrorState,
  fullScreenEmptyState,

  //general
  contentState,
}

class StateRenderer extends StatelessWidget {
  StateRendererType stateRendererType;
  String title;
  String message;
  Function retryActionFunction;

  StateRenderer({
    required this.stateRendererType,
    this.title = AppStrings.loading,
    this.message = '',
    required this.retryActionFunction,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return _getStateWidget(context);
  }

  Widget _getStateWidget(context) {
    switch (stateRendererType) {
      case StateRendererType.popupLoadingState:
        return _getPopUpDialog([
          _getAnimatedImage(JsonManager.loading),
          _getMessage('Loading...')
        ]);
      case StateRendererType.popupSuccessState:
        return _getPopUpDialog([
          _getAnimatedImage(JsonManager.success),
          _getMessage(message),
          _getRetryButton(context, AppStrings.ok),
        ]);
      case StateRendererType.popupErrorState:
        return _getPopUpDialog([
          _getAnimatedImage(JsonManager.error),
          _getMessage(message),
          _getRetryButton(context, AppStrings.retryAgain),
        ]);
      case StateRendererType.fullScreenLoadingState:
        return _getItemsColumn([
          _getAnimatedImage(JsonManager.loading),
          _getMessage(message),
        ]);
      case StateRendererType.fullScreenErrorState:
        return _getItemsColumn([
          _getAnimatedImage(JsonManager.error),
          _getMessage(message),
          _getRetryButton(context, AppStrings.retryAgain),
        ]);
      case StateRendererType.fullScreenEmptyState:
        return _getItemsColumn([
          _getAnimatedImage(JsonManager.empty),
          _getMessage(message),
        ]);
      case StateRendererType.contentState:
        return const SizedBox();
      default:
        return const SizedBox();
    }
  }

  Widget _getPopUpDialog(List<Widget> children) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.s14),
        ),
        elevation: AppSize.s1_5,
        backgroundColor: Colors.transparent,
        child: Container(
          decoration: BoxDecoration(
            color: ColorManager.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(AppSize.s14),
            boxShadow: const [BoxShadow(color: Colors.black26)],
          ),
          child: _getDialogContent(children),
        ),
      );

  Widget _getDialogContent(List<Widget> children) =>
      _getItemsColumn(children, mainAxisSize: MainAxisSize.min);

  Widget _getItemsColumn(List<Widget> children,
          {MainAxisSize mainAxisSize = MainAxisSize.max}) =>
      SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(AppPadding.p18),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: mainAxisSize,
            children: children,
          ),
        ),
      );

  Widget _getAnimatedImage(String animationName) => SizedBox(
        height: AppSize.s100,
        width: AppSize.s100,
        child: Lottie.asset(animationName),
      );

  Widget _getMessage(String message) => Text(
        message,
        textAlign:TextAlign.center ,
        style:
            getRegularStyle(color: ColorManager.black, fontSize: FontSize.s18),
      );

  Widget _getRetryButton(context, String buttonTitle) => SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.only(top: AppPadding.p12),
        child: ElevatedButton(
            onPressed: () {
              if (stateRendererType == StateRendererType.fullScreenErrorState) {
                retryActionFunction.call();
              } else {
                Navigator.of(context).pop();
              }
            },
            child: Text(buttonTitle)),
      ));
}
