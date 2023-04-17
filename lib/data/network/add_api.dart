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
@POST('/customer/forgetPassword')
Future<ForgotPasswordResponse> forgetPassword(@Field("email") String email);

@POST('/customer/register')
Future<AuthenticationResponse> register(
    @Field("user_name") String userName,
    @Field("email") String email,
    @Field("country_mobile_code") String countryCode,
    @Field("mobile_number") String mobile,
    @Field("password") String password,
    @Field("profile_image") String profileImage,
    );

@GET('/home')
Future<HomeResponse> getHomeData();

@GET('/storeDetails/1')
Future<StoreDetailsResponse> getStoreDetailsData();

}