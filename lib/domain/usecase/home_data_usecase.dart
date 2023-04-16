import 'package:dartz/dartz.dart';
import 'package:mena/data/network/failure.dart';
import 'package:mena/domain/model/models.dart';
import 'package:mena/domain/repository/repository.dart';
import 'package:mena/domain/usecase/base_usecase.dart';

class HomeDataUseCase extends BaseUseCase<void,HomeObject>{
  final Repository _repository;

  HomeDataUseCase(this._repository);

  @override
  Future<Either<Failure, HomeObject>> execute(input) async {
   return await _repository.getHomeData();
  }
}