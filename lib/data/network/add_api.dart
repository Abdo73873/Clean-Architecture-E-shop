import 'package:dio/dio.dart';
import 'package:mena/app/constants.dart';
import 'package:retrofit/http.dart';

import '../responses/responses.dart';
part 'add_api.g.dart';

@RestApi(baseUrl: Constants.baseUrl)
abstract class AppServicesClient{
factory AppServicesClient(Dio dio,{String baseUrl})=_AppServicesClient;
@POST('/customer/login')
  Future<AuthenticationResponse> login(
    @Field("email") String email,
    @Field("password") String password,
    );
}