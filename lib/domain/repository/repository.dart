import 'package:dartz/dartz.dart';
import 'package:mena/data/network/requests.dart';
import 'package:mena/domain/model/models.dart';

import '../../data/network/failure.dart';

abstract class Repository{
  Future<Either<Failure,Authentication>> login(LoginRequest loginRequest);
}