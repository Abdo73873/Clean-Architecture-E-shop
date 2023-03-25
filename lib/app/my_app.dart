import 'package:flutter/material.dart';
import 'package:mena/persentation/resources/routes_manger.dart';
import 'package:mena/persentation/resources/theme_manager.dart';

class MyApp extends StatefulWidget {
  MyApp._internal();
  static final _instance=MyApp._internal();
  factory MyApp()=>_instance;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: getAppTheme(),
      onGenerateRoute: RouteGenerator.getRoute,
      initialRoute: Routes.splashRoute,

    );
  }
}
//ed9728