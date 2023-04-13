import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mena/persentation/common/state_renderer/state_renderer.dart';
import 'package:mena/persentation/resources/strings_manager.dart';

import '../../../app/constants.dart';

abstract class FlowState {
  StateRendererType getStateRendererTyp();

  String getMessage();
}

class LoadingState extends FlowState {
  StateRendererType stateRendererType;
  String message;

  LoadingState(
      {required this.stateRendererType, this.message = AppStrings.loading});

  @override
  String getMessage() => message;

  @override
  StateRendererType getStateRendererTyp() => stateRendererType;
}

class ErrorState extends FlowState {
  StateRendererType stateRendererType;
  String message;

  ErrorState(this.stateRendererType, this.message);

  @override
  String getMessage() => message;

  @override
  StateRendererType getStateRendererTyp() => stateRendererType;
}

class ContentState extends FlowState {
  @override
  String getMessage() => Constants.empty;

  @override
  StateRendererType getStateRendererTyp() => StateRendererType.contentState;
}

class EmptyState extends FlowState {
  String message;

  EmptyState(this.message);

  @override
  String getMessage() => message;

  @override
  StateRendererType getStateRendererTyp() =>
      StateRendererType.fullScreenEmptyState;
}


extension FlowStateExtantion on FlowState {
  Widget getScreenWidget(BuildContext context, Widget contentScreenWidget,
      Function retryActionFunction) {
    switch (runtimeType) {
      case LoadingState:
        if (getStateRendererTyp() == StateRendererType.popupLoadingState) {
          showPopup(context, getStateRendererTyp(), getMessage());
          return contentScreenWidget;
        } else {
          return StateRenderer(
            message: getMessage(),
            stateRendererType: getStateRendererTyp(),
            retryActionFunction: retryActionFunction,
          );
        }
      case ErrorState:
        dismissDialog(context);
        if (getStateRendererTyp() == StateRendererType.popupErrorState) {
          showPopup(context, getStateRendererTyp(), getMessage());
          return contentScreenWidget;
        }
        else {
          return StateRenderer(
            message: getMessage(),
            stateRendererType: getStateRendererTyp(),
            retryActionFunction: retryActionFunction,
          );
        }
      case EmptyState:
        return StateRenderer(
           message: getMessage(),
            stateRendererType: getStateRendererTyp(),
            retryActionFunction: (){});
      case ContentState:
        dismissDialog(context);
        return contentScreenWidget;
      default:
        dismissDialog(context);
        return contentScreenWidget;
    }
  }

 bool _isCurrentDialogShowing(context)=>ModalRoute.of(context)?.isCurrent!=true;
  void dismissDialog(context){
    if(_isCurrentDialogShowing(context)){
      Navigator.of(context,rootNavigator: true).pop(true);
    }
  }
  showPopup(context, StateRendererType stateRendererType, String message) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      showDialog(
        context: context,
        builder: (context) => StateRenderer(
          stateRendererType: stateRendererType,
          message: message,
          retryActionFunction: () {},
        ),
      );
    });
  }
}
