import 'package:dartz/dartz.dart';
import 'package:mena/data/network/failure.dart';
import 'package:mena/data/network/requests.dart';
import 'package:mena/domain/model/models.dart';
import 'package:mena/domain/repository/repository.dart';
import 'package:mena/domain/usecase/base_usecase.dart';

class LoginUseCase extends BaseUseCase<LoginUseCaseInput,Authentication>{
  final Repository _repository;

  LoginUseCase(this._repository);

  @override
  Future<Either<Failure, Authentication>> execute(input) async {
  return await _repository.login(LoginRequest(input.email,input.password));

  }

}

class LoginUseCaseInput{
  String email;
  String password;

  LoginUseCaseInput(this.email, this.password);
}