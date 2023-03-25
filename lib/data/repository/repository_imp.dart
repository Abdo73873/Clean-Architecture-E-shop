import 'package:dartz/dartz.dart';
import 'package:mena/data/mapper/mapper.dart';
import 'package:mena/data/network/failure.dart';
import 'package:mena/data/network/requests.dart';
import 'package:mena/domain/model/models.dart';
import 'package:mena/domain/repository/repository.dart';

import '../data_source/remote_data_source.dart';
import '../network/network_inf.dart';


 class RepositoryImp implements Repository{
   final RemoteDataSource _remoteDataSource;
   final NetworkInf _networkInf;
   RepositoryImp(this._remoteDataSource,this._networkInf);
  @override
  Future<Either<Failure, Authentication>> login(LoginRequest loginRequest)async {
    if(await _networkInf.isConnected){
      final response=await _remoteDataSource.login(loginRequest);
      if(response.status==0){
      return Right(response.toDomain());
      }else{
        return Left(Failure(409,response.message??"business error "));
      }
    }
    else{
      return Left(Failure(501,"please check your internet connection"));

    }
  }

}