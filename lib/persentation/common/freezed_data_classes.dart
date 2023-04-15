import 'package:freezed_annotation/freezed_annotation.dart';

part 'freezed_data_classes.freezed.dart';

@freezed
class LoginObject with _$LoginObject{
factory LoginObject(String email,String password)=_LoginObject;
}

@freezed
class RegisterObject with _$RegisterObject{
  factory RegisterObject({
    required String userName,
  required String email,
  required String countryCode,
  required String mobile,
  required String password,
  required String profileImage,})=_RegisterObject;
}
