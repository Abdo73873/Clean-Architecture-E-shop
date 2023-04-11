import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mena/app/app_prefs.dart';
import 'package:mena/data/data_source/remote_data_source.dart';
import 'package:mena/data/network/add_api.dart';
import 'package:mena/data/network/dio_factory.dart';
import 'package:mena/data/network/network_inf.dart';
import 'package:mena/data/repository/repository_imp.dart';
import 'package:mena/domain/repository/repository.dart';
import 'package:mena/domain/usecase/login_usecase.dart';
import 'package:mena/persentation/login/view_model/login_viewmodel.dart';
import 'package:shared_preferences/shared_preferences.dart';

final instance =GetIt.instance;

Future<void> initAppModule() async{
  final sharedPrefs=await SharedPreferences.getInstance();
  instance.registerLazySingleton<SharedPreferences>(() => sharedPrefs);
  instance.registerLazySingleton<AppPreferences>(() => AppPreferences(instance()));
  instance.registerLazySingleton<NetworkInf>(() =>NetworkInfImpl(InternetConnectionChecker()));
  instance.registerLazySingleton<DioFactory>(() =>DioFactory(instance()));
  Dio dio=await instance<DioFactory>().getDio();
  instance.registerLazySingleton<AppServicesClient>(() =>AppServicesClient(dio));
  instance.registerLazySingleton<RemoteDataSource>(() =>RemoteDataSourceImplementation(instance()));
  instance.registerLazySingleton<Repository>(() =>RepositoryImp(instance(), instance()));

}
void initLoginModule() {
  if(!GetIt.I.isRegistered<LoginUseCase>()) {
    instance.registerFactory<LoginUseCase>(() => LoginUseCase(instance()));
    instance.registerFactory<LoginViewModel>(() => LoginViewModel(instance()));
  }

}