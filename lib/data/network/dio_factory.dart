import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:mena/app/app_prefs.dart';
import 'package:mena/app/constants.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

const String APPLICATION_JSON="application/json";
const String COTENT_TYPE="content-type";
const String ACCEPT="Accept";
const String AUTHORIZATION="authorization";
const String DEFAULT_LANGUAGUE="language";

class DioFactory{
final AppPreferences _appPreferences;
DioFactory(this._appPreferences);

  Future<Dio> getDio()async{
    Dio dio=Dio();
    String language=await _appPreferences.getAppLanguage();
    Map<String,String> headers={
      ACCEPT:APPLICATION_JSON,
      COTENT_TYPE:APPLICATION_JSON,
      AUTHORIZATION:Constants.apiToken,
      DEFAULT_LANGUAGUE:language, //todo get language from app refs
    };
    dio.options=BaseOptions(
      baseUrl: Constants.baseUrl,
      headers: headers,
      connectTimeout:const Duration(seconds: Constants.apiTimeOut),
      receiveTimeout: const Duration(seconds: Constants.apiTimeOut),
      sendTimeout: const Duration(seconds: Constants.apiTimeOut),
    );
    if(!kReleaseMode){
      dio.interceptors.add(PrettyDioLogger(
        requestHeader:true,
        requestBody: true,
        responseHeader: true,
        error: true,
        responseBody: true,
        request: true,
      ));
    }
    return dio;
  }
}