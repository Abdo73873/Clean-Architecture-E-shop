import 'package:flutter/material.dart';
import 'package:mena/app/di.dart';

import 'app/functions.dart';
import 'app/my_app.dart';
// flutter pub run build_runner build --delete-conflicting-outputs
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await initAppModule();
  isEmailValid('hi');
  runApp( MyApp());
}

