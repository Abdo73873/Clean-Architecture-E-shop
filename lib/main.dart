import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:mena/app/di.dart';
import 'package:mena/persentation/resources/langauge_manager.dart';

import 'app/functions.dart';
import 'app/my_app.dart';

// flutter pub run build_runner build --delete-conflicting-outputs
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await initAppModule();

  runApp(EasyLocalization(
      supportedLocales: const [ENGLISH_LOCALE, ARABIC_LOCALE],
      path: ASSET_PATH_LOCALISATION,
      child: Phoenix(child: MyApp())));
}
