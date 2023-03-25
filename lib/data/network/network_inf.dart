import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class NetworkInf{
  Future<bool> get isConnected;

}


class NetworkInfImpl implements NetworkInf{
  final InternetConnectionChecker _internetConnectionChecker;
  NetworkInfImpl(this._internetConnectionChecker);
  @override
  Future<bool> get isConnected => _internetConnectionChecker.hasConnection;

}