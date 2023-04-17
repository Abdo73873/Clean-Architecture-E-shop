import 'package:mena/data/mapper/mapper.dart';
import 'package:mena/data/network/add_api.dart';
import 'package:mena/data/network/requests.dart';
import 'package:mena/data/responses/responses.dart';

abstract class RemoteDataSource {
  Future<AuthenticationResponse> login(LoginRequest loginRequest);

  Future<AuthenticationResponse> register(RegisterRequest registerRequest);

  Future<ForgotPasswordResponse> forgetPassword(String email);
  Future<HomeResponse> getHomeData();
  Future<StoreDetailsResponse> getStoreDetailsData();
}

class RemoteDataSourceImplementation implements RemoteDataSource {
  final AppServicesClient _appServicesClient;

  RemoteDataSourceImplementation(this._appServicesClient);

  @override
  Future<AuthenticationResponse> login(LoginRequest loginRequest) async {
    return await _appServicesClient.login(
        loginRequest.email, loginRequest.password);
  }

  @override
  Future<ForgotPasswordResponse> forgetPassword(String email) async {
    final response = await _appServicesClient.forgetPassword(email);
    print(response);
    return await _appServicesClient.forgetPassword(email);
  }

  @override
  Future<AuthenticationResponse> register(
      RegisterRequest registerRequest) async {
    final response = await _appServicesClient.register(
        registerRequest.userName,
        registerRequest.email,
        registerRequest.countryCode,
        registerRequest.mobile,
        registerRequest.password,
       "");
    return response;
  }

  @override
  Future<HomeResponse> getHomeData()async{
    return await _appServicesClient.getHomeData();

  }

  @override
  Future<StoreDetailsResponse> getStoreDetailsData() async {
  return  await _appServicesClient.getStoreDetailsData();
  }
}
