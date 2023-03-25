import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mena/persentation/resources/assets_manager.dart';
import 'package:mena/persentation/resources/color_manager.dart';
import 'package:mena/persentation/resources/constant_manager.dart';

import '../resources/routes_manger.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  Timer? _timer;

  _startDelay() {
    _timer = Timer(const Duration(seconds: AppConstants.splashDelay), _goNext);
  }

    _goNext(){
      Navigator.pushReplacementNamed(context, Routes.onBoardingRoute);
    }
    @override
  void initState() {
    super.initState();
    _startDelay();
  }
  @override
  void dispose() {
  _timer?.cancel();
  super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: ColorManager.primary,
      body: Center(child: Image(image: AssetImage(ImagesManager.splashLogo),)),
    );
  }
}
