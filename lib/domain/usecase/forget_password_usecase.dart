import 'package:dartz/dartz.dart';
import 'package:mena/data/network/failure.dart';
import 'package:mena/domain/repository/repository.dart';
import 'package:mena/domain/usecase/base_usecase.dart';


class ForgetPasswordUseCase extends BaseUseCase<String,String>{
  final Repository _repository;

  ForgetPasswordUseCase(this._repository);

  @override
  Future<Either<Failure, String>> execute(input) async {
   return await _repository.forgetPassword(input);
  }

}