import 'dart:async';

import 'package:mena/domain/usecase/forget_password_usecase.dart';
import 'package:mena/persentation/base/base_viewmodel.dart';
import 'package:mena/persentation/common/state_renderer/state_renderer.dart';
import 'package:mena/persentation/common/state_renderer/state_renderer_imp.dart';

class ForgetPasswordViewModel extends BaseViewModel
    with ForgetPasswordViewModelInputs, ForgetPasswordViewModelOutputs {
  final StreamController _emailStreamController=StreamController<String>.broadcast();
  final StreamController _isEmailStreamController=StreamController<bool>();
  final ForgetPasswordUseCase _forgetPasswordUseCase;
  ForgetPasswordViewModel(this._forgetPasswordUseCase);
 String _email='';
  @override
  void start() {
    inputState.add(ContentState());
  }
@override
  void dispose() {
    super.dispose();
    _emailStreamController.close();
    _isEmailStreamController.close();
  }
  @override
  Sink get inputEmail => _emailStreamController.sink;

  @override
  Stream<bool> get outIsEmailValid => _emailStreamController.stream.map((email) => _isEmailValid(email));

  bool _isEmailValid(String email){
    return email.isNotEmpty;
  }

  @override
  forgetPassword() async {
    inputState.add(LoadingState(stateRendererType: StateRendererType.popupLoadingState));
    (await _forgetPasswordUseCase.execute(_email))
        .fold((failure){
        inputState.add(ErrorState(StateRendererType.popupErrorState,failure.message));
      }, (data){
        inputState.add(SuccessState(message: data));
      });

  }

  @override
  setEmail(String email) {
    _email=email;
   inputEmail.add(email);
  }

}

abstract class ForgetPasswordViewModelInputs {
  Sink get inputEmail;
  setEmail(String email);
  forgetPassword();
}

abstract class ForgetPasswordViewModelOutputs {
  Stream<bool> get outIsEmailValid;
}
