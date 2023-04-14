import 'dart:async';
import 'dart:io';

import 'package:mena/domain/usecase/register_usecase.dart';
import 'package:mena/persentation/base/base_viewmodel.dart';
import 'package:mena/persentation/resources/strings_manager.dart';

import '../../../app/functions.dart';

class RegisterViewModel extends BaseViewModel
    with RegisterViewModelInputs, RegisterViewModelOutputs {
  StreamController userNameStreamController =
      StreamController<String>.broadcast();
  StreamController emailStreamController = StreamController<String>.broadcast();
  StreamController mobileStreamController =
      StreamController<String>.broadcast();
  StreamController passwordStreamController =
      StreamController<String>.broadcast();
  StreamController profileImageStreamController =
      StreamController<File>.broadcast();
  StreamController areAllInputValidStreamController =
      StreamController<void>.broadcast();
  final RegisterUseCase _registerUseCase;

  RegisterViewModel(this._registerUseCase);

  @override
  void start() {}

  @override
  void dispose() {
    userNameStreamController.close();
    emailStreamController.close();
    mobileStreamController.close();
    passwordStreamController.close();
    profileImageStreamController.close();
    areAllInputValidStreamController.close();
    super.dispose();
  }

  @override
  Sink get inputEmail => emailStreamController.sink;

  @override
  Sink get inputMobile => mobileStreamController.sink;

  @override
  Sink get inputPassword => passwordStreamController.sink;

  @override
  Sink get inputProfileImage => profileImageStreamController.sink;

  @override
  Sink get inputUsername => userNameStreamController.sink;

  @override
  register() {}

  //output
  @override
  Stream<bool> get outIsEmailValid =>
      emailStreamController.stream.map((email) => isEmailValid(email));

  @override
  Stream<bool> get outIsMobileValid =>
      mobileStreamController.stream.map((mobile) => _isMobileValid(mobile));

  @override
  Stream<bool> get outIsPasswordValid =>
      passwordStreamController.stream.map((password) => _isPasswordValid(password));

  @override
  Stream<bool> get outIsProfileImageValid =>
      profileImageStreamController.stream.map((image) => _isProfileImageValid(image));

  @override
  Stream<bool> get outIsUserNameValid => userNameStreamController.stream
      .map((userName) => _isUserNameValid(userName));

  @override
  Stream<String?> get outErrorEmail => outIsEmailValid
      .map((isEmailValid) => isEmailValid ? null : AppStrings.emailInvalid);

  @override
  Stream<String?> get outErrorMobile => outIsMobileValid
      .map((isMobileValid) => isMobileValid ? null : AppStrings.mobileInvalid);

  @override
  Stream<String?> get outErrorPassword => outIsPasswordValid.map(
      (isPasswordValid) => isPasswordValid ? null : AppStrings.passwordInvalid);

  @override
  Stream<String?> get outErrorUserName => outIsUserNameValid.map(
          (isUserNameValid) => isUserNameValid ? null : AppStrings.userNameInvalid);

  //private functions
  bool _isUserNameValid(String userName) {
    return userName.length >= 8;
  }
  bool _isPasswordValid(String userName) {
    return userName.length >= 8;
  }
  bool _isMobileValid(String userName) {
    return userName.length >= 8;
  }
 bool _isProfileImageValid(File image)  {
    return image.existsSync();
  }
}

abstract class RegisterViewModelInputs {
  Sink get inputUsername;

  Sink get inputEmail;

  Sink get inputMobile;

  Sink get inputProfileImage;

  Sink get inputPassword;

  register();
}

abstract class RegisterViewModelOutputs {
  Stream<bool> get outIsUserNameValid;

  Stream<String?> get outErrorUserName;

  Stream<bool> get outIsEmailValid;

  Stream<String?> get outErrorEmail;

  Stream<bool> get outIsMobileValid;

  Stream<String?> get outErrorMobile;

  Stream<bool> get outIsPasswordValid;

  Stream<String?> get outErrorPassword;

  Stream<bool> get outIsProfileImageValid;
}
