import 'dart:ffi';

import 'package:dartz/dartz.dart';
import 'package:mena/data/network/failure.dart';
import 'package:mena/domain/model/models.dart';
import 'package:mena/domain/repository/repository.dart';
import 'package:mena/domain/usecase/base_usecase.dart';

class StoreDetailsUseCase extends BaseUseCase<void,StoreDetails>{
  final Repository _repository;

  StoreDetailsUseCase(this._repository);

  @override
  Future<Either<Failure, StoreDetails>> execute(input) async {
   return await _repository.getStoreDetailsData();
  }
}