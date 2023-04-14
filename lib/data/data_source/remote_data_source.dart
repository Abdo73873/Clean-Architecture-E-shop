import 'package:mena/data/network/add_api.dart';
import 'package:mena/data/network/requests.dart';
import 'package:mena/data/responses/responses.dart';

abstract class RemoteDataSource{
  Future<AuthenticationResponse> login(LoginRequest loginRequest);
  Future<ForgotPasswordResponse> forgetPassword(String email);
}

class RemoteDataSourceImplementation implements RemoteDataSource{
  final AppServicesClient _appServicesClient;
  RemoteDataSourceImplementation(this._appServicesClient);
  @override
  Future<AuthenticationResponse> login(LoginRequest loginRequest)async {
    return await _appServicesClient.login(loginRequest.email, loginRequest.password);
  }

  @override
  Future<ForgotPasswordResponse> forgetPassword(String email) async {
    final response =await _appServicesClient.forgetPassword(email);
    print(response);
   return await _appServicesClient.forgetPassword(email);
  }

}