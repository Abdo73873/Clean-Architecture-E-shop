import 'package:dartz/dartz.dart';
import 'package:mena/data/data_source/local_data_source.dart';
import 'package:mena/data/mapper/mapper.dart';
import 'package:mena/data/network/error_handler.dart';
import 'package:mena/data/network/failure.dart';
import 'package:mena/data/network/requests.dart';
import 'package:mena/domain/model/models.dart';
import 'package:mena/domain/repository/repository.dart';

import '../data_source/remote_data_source.dart';
import '../network/network_inf.dart';


 class RepositoryImp implements Repository{
   final RemoteDataSource _remoteDataSource;
   final LocalDataSource _localDataSource;
   final NetworkInf _networkInf;
   RepositoryImp(this._remoteDataSource,this._localDataSource,this._networkInf);
  @override
  Future<Either<Failure, Authentication>> login(LoginRequest loginRequest)async {
    if(await _networkInf.isConnected){
      try{
        final response=await _remoteDataSource.login(loginRequest);
        if(response.status==ApiInternalStatus.SCUSSUS){
          return Right(response.toDomain());
        }else{
          return Left(Failure(ApiInternalStatus.FAILURE,response.message??ResponseMessage.DEFAULT));
        }
      }catch(error){
        return Left(ErrorHandler.handle(error).failure);
      }

    }
    else{
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, String>> forgetPassword(String email) async {
    if(await _networkInf.isConnected){
      try{
        final response =await _remoteDataSource.forgetPassword(email);

        print(response);
        if(response.status==ApiInternalStatus.SCUSSUS){
          return Right(response.toDomain());
        }else{
          return Left(Failure(ApiInternalStatus.FAILURE,response.message??ResponseMessage.DEFAULT));
        }
      }catch(error){
        return Left(ErrorHandler.handle(error).failure);
    }
    }else{
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());

    }
  }

  @override
  Future<Either<Failure, Authentication>> register(RegisterRequest registerRequest) async {
   if(await _networkInf.isConnected){
    try{
      final response =await _remoteDataSource.register(registerRequest);
      if(response.status==ApiInternalStatus.SCUSSUS){
        return Right(response.toDomain());
      }else{
        return Left(Failure(ApiInternalStatus.FAILURE,ResponseMessage.DEFAULT));
      }
    }catch(error){
      return Left(ErrorHandler.handle(error).failure);
    }
   }
   else{
     return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
   }
  }

  @override
  Future<Either<Failure, HomeObject>> getHomeData() async {

    try{
      final response=await _localDataSource.getHomeData();
      print(response);
      return Right(response.toDomain());

    }catch(cacheError){
      print('error =============$cacheError=========');
      if(await _networkInf.isConnected){
        try{
          final response=await _remoteDataSource.getHomeData();
          if(response.status==ApiInternalStatus.SCUSSUS){
            _localDataSource.saveHomeDataToCache(response);
            return Right(response.toDomain());
          }else{
            return Left(Failure(ApiInternalStatus.FAILURE,ResponseMessage.DEFAULT));
          }
        }catch(error){
          print(error);
          print('=============================');
          return Left(ErrorHandler.handle(error).failure);
        }

      }else{
        return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
      }
    }


  }

  @override
  Future<Either<Failure, StoreDetails>> getStoreDetailsData() async {
    try{
      final response= _localDataSource.getStoreDetailsData();
      print(response);
      return Right(response.toDomain());

    }catch(cacheError){
      print('error =============$cacheError=========');
      if(await _networkInf.isConnected){
        try{
          final response=await _remoteDataSource.getStoreDetailsData();
          if(response.status==ApiInternalStatus.SCUSSUS){
            _localDataSource.saveStoreDetailsDataToCache(response);
            return Right(response.toDomain());
          }else{
            return Left(Failure(ApiInternalStatus.FAILURE,ResponseMessage.DEFAULT));
          }
        }catch(error){
          print(error);
          return Left(ErrorHandler.handle(error).failure);
        }

      }else{
        return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
      }
    }
  }

}