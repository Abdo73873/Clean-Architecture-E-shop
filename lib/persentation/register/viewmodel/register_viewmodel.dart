import 'dart:async';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:mena/domain/usecase/register_usecase.dart';
import 'package:mena/persentation/base/base_viewmodel.dart';
import 'package:mena/persentation/common/freezed_data_classes.dart';
import 'package:mena/persentation/common/state_renderer/state_renderer_imp.dart';
import 'package:mena/persentation/resources/strings_manager.dart';

import '../../../app/functions.dart';
import '../../common/state_renderer/state_renderer.dart';

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
  StreamController isUserRegisteredSuccessfullyStreamController =
  StreamController<bool>.broadcast();

  final RegisterUseCase _registerUseCase;
  var registerObject = RegisterObject(
      userName: '',
      email: '',
      countryCode: '',
      mobile: '',
      password: '',
      profileImage: '');

  RegisterViewModel(this._registerUseCase);

  @override
  void start() {
    inputState.add(ContentState());
  }

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
  Sink get inputAllInputValid => areAllInputValidStreamController.sink;

  @override
  setUserName(String userName) {
    inputUsername.add(userName);

    if (_isUserNameValid(userName)) {
      registerObject = registerObject.copyWith(
        userName: userName,
      );
    }
    else {
      registerObject = registerObject.copyWith(
        userName: '',
      );
    }
    validate();
  }

  @override
  setEmail(String email) {
    inputEmail.add(email);

    if (isEmailValid(email)) {
      registerObject = registerObject.copyWith(
        email: email,
      );
    } else {
      registerObject = registerObject.copyWith(
        email: '',
      );
    }
    validate();
  }

  @override
  setMobile(String mobile) {
    inputMobile.add(mobile);

    if (_isMobileValid(mobile)) {
      registerObject = registerObject.copyWith(
        mobile: mobile,
      );
    } else {
      registerObject = registerObject.copyWith(
        mobile: '',
      );
    }
    validate();
  }

  @override
  setPassword(String password) {
    inputPassword.add(password);

    if (_isPasswordValid(password)) {
      registerObject = registerObject.copyWith(
        password: password,
      );
    } else {
      registerObject = registerObject.copyWith(
        password: '',
      );
    }
    validate();
  }

  @override
  setCountryCode(String code) {

    if (code.isNotEmpty) {
      registerObject = registerObject.copyWith(
        countryCode: code,
      );
    } else {
      registerObject = registerObject.copyWith(
        countryCode: '',
      );
    }
    validate();
  }

  @override
  setProfileImage(File profileImage) {
    inputProfileImage.add(profileImage);
    if (profileImage.path.isNotEmpty) {
      registerObject = registerObject.copyWith(
        profileImage: profileImage.path,
      );
    } else {
      registerObject = registerObject.copyWith(
        profileImage: '',
      );
    }
    validate();
  }

  @override
  register() async {
    inputState.add(
        LoadingState(stateRendererType: StateRendererType.popupLoadingState));
    (await _registerUseCase.execute(RegisterUseCaseInput(
            userName: registerObject.userName,
            email: registerObject.email,
            countryCode: registerObject.countryCode,
            mobile:registerObject. mobile,
            password: registerObject.password,
            profileImage: registerObject.profileImage)))
        .fold(
            (failure) => {
                  inputState.add(ErrorState(
                      StateRendererType.popupErrorState, failure.message))
                }, (data) {
      isUserRegisteredSuccessfullyStreamController.add(true);
      inputState.add(ContentState());
    });
  }

  //output
  @override
  Stream<bool> get outIsEmailValid =>
      emailStreamController.stream.map((email) => isEmailValid(email));

  @override
  Stream<bool> get outIsMobileValid =>
      mobileStreamController.stream.map((mobile) => _isMobileValid(mobile));

  @override
  Stream<bool> get outIsPasswordValid => passwordStreamController.stream
      .map((password) => _isPasswordValid(password));

  @override
  Stream<File> get outIsProfileImageValid =>
      profileImageStreamController.stream.map((file) => file);

  @override
  Stream<bool> get outIsUserNameValid => userNameStreamController.stream
      .map((userName) => _isUserNameValid(userName));

  @override
  Stream<String?> get outErrorEmail => outIsEmailValid
      .map((isEmailValid) => isEmailValid ? null : AppStrings.emailError.tr());

  @override
  Stream<String?> get outErrorMobile => outIsMobileValid
      .map((isMobileValid) => isMobileValid ? null : AppStrings.mobileNumberInvalid.tr());

  @override
  Stream<String?> get outErrorPassword => outIsPasswordValid.map(
      (isPasswordValid) => isPasswordValid ? null : AppStrings.passwordInvalid.tr());

  @override
  Stream<String?> get outErrorUserName => outIsUserNameValid.map(
      (isUserNameValid) => isUserNameValid ? null : AppStrings.userNameInvalid.tr());

  @override
  Stream<bool> get outIAreAllInputValid =>
      areAllInputValidStreamController.stream.map((event) => _areAllValid());

  //private functions
  bool _isUserNameValid(String userName) {
    return userName.length >= 8;
  }

  bool _isPasswordValid(String userName) {
    return userName.length >= 6;
  }

  bool _isMobileValid(String userName) {
    return userName.length >= 11;
  }

  bool _areAllValid() {
    return registerObject.userName.isNotEmpty &&
        registerObject.email.isNotEmpty &&
        registerObject.mobile.isNotEmpty &&
        registerObject.password.isNotEmpty &&
        registerObject.profileImage.isNotEmpty;
  }

  void validate() {
    inputAllInputValid.add(null);
  }
}

abstract class RegisterViewModelInputs {
  Sink get inputUsername;

  Sink get inputEmail;

  Sink get inputMobile;

  Sink get inputProfileImage;

  Sink get inputPassword;

  Sink get inputAllInputValid;

  setUserName(String userName);

  setEmail(String email);

  setMobile(String mobile);

  setPassword(String password);

  setCountryCode(String code);

  setProfileImage(File profileImage);

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

  Stream<File> get outIsProfileImageValid;

  Stream<bool> get outIAreAllInputValid;
}
