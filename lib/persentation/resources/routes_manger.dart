import 'package:flutter/material.dart';
import 'package:mena/persentation/forget_password/forget_password_view.dart';
import 'package:mena/persentation/main/main_view.dart';
import 'package:mena/persentation/onBoarding/view/onBoarding_view.dart';
import 'package:mena/persentation/register/register_view.dart';
import 'package:mena/persentation/resources/strings_manager.dart';
import 'package:mena/persentation/splash/splash_view.dart';

import '../login/view/login_view.dart';
import '../store_details/store_details_view.dart';

class Routes{
  static const String splashRoute="/";
  static const String onBoardingRoute="/onBoarding";
  static const String loginRoute="/login";
  static const String registerRoute="/register";
  static const String forgotPasswordRoute="/forgotPassword";
  static const String mainRoute="/main";
  static const String storeDetailsRoute="/storeDetails";
}
class RouteGenerator{
  static Route<dynamic> getRoute(RouteSettings settings){
    switch(settings.name){
      case Routes.splashRoute:
        return MaterialPageRoute(builder: (context) => const SplashView(),);
      case Routes.onBoardingRoute:
        return MaterialPageRoute(builder: (context) => const OnBoardingView(),);
      case Routes.loginRoute:
        return MaterialPageRoute(builder: (context) => const LoginView(),);
      case Routes.registerRoute:
        return MaterialPageRoute(builder: (context) => const RegisterView(),);
      case Routes.forgotPasswordRoute:
        return MaterialPageRoute(builder: (context) => const ForgetPasswordView(),);
      case Routes.mainRoute:
        return MaterialPageRoute(builder: (context) => const MainView(),);
      case Routes.storeDetailsRoute:
        return MaterialPageRoute(builder: (context) => const StoreDetailsView(),);
    default:
      return unDefineRoute();
    }
  }
  static Route<dynamic> unDefineRoute(){
    return MaterialPageRoute(builder: (context) => Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.noRouteFound),
      ),
      body: const Center(child: Text(AppStrings.noRouteFound),),
    ),);
  }
}