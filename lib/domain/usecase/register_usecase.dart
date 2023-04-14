import 'package:dartz/dartz.dart';
import 'package:mena/data/network/failure.dart';
import 'package:mena/data/network/requests.dart';
import 'package:mena/domain/repository/repository.dart';
import 'package:mena/domain/usecase/base_usecase.dart';

import '../model/models.dart';

class RegisterUseCase
    extends BaseUseCase<RegisterUseCaseInput, Authentication> {
  final Repository _repository;

  RegisterUseCase(this._repository);

  @override
  Future<Either<Failure, Authentication>> execute(input) async {
    return await _repository.register(RegisterRequest(
        userName: input.userName,
        email: input.email,
        countryCode: input.countryCode,
        mobile: input.mobile,
        password: input.password,
        profileImage: input.profileImage));
  }
}

class RegisterUseCaseInput {
  String userName;
  String email;
  String countryCode;
  String mobile;
  String password;
  String profileImage;

  RegisterUseCaseInput(
      {required this.userName,
      required this.email,
      required this.countryCode,
      required this.mobile,
      required this.password,
      required this.profileImage});
}
