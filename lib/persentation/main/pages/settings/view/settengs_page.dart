import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mena/app/app_prefs.dart';
import 'package:mena/app/di.dart';
import 'package:mena/data/data_source/local_data_source.dart';
import 'package:mena/persentation/resources/assets_manager.dart';
import 'package:mena/persentation/resources/color_manager.dart';
import 'package:mena/persentation/resources/langauge_manager.dart';
import 'package:mena/persentation/resources/strings_manager.dart';
import 'package:mena/persentation/resources/values_manager.dart';

import '../../../../resources/routes_manger.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(AppPadding.p16),
      children: [
        _buildItem(
            title: AppStrings.changeLanguage.tr(),
            icon: ImagesManager.changeLangIc,
            onTap: () {
              _changeLanguage();
            }),
        _buildItem(
            title: AppStrings.contactUs.tr(),
            icon: ImagesManager.contactUsIc,
            onTap: () {}),
        _buildItem(
            title: AppStrings.inviteYourFriends.tr(),
            icon: ImagesManager.inviteFriendsIc,
            onTap: () {
            }),
        _buildItem(
            title: AppStrings.logout.tr(),
            icon: ImagesManager.logoutIc,
            onTap: () {
              _logOut();
            }),
      ],
    );
  }

  Widget _buildItem(
          {required String title, required String icon, Function()? onTap}) =>
      ListTile(
        title: Text(
          title,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        leading: SvgPicture.asset(
          icon,
          width: AppSize.s30,
        ),
        trailing: Transform(
          transform: Matrix4.rotationY(_isRtl()?pi:0),
          child: SvgPicture.asset(
            ImagesManager.settingsRightArrowIc,
          ),
        ),
        onTap: onTap,
      );
  void _changeLanguage(){
    instance<AppPreferences>().changeAppLanguage();
    Phoenix.rebirth(context);
  }
  bool _isRtl(){
   return context.locale==ARABIC_LOCALE;
  }

  void _inviteYourFriends(){
    //todo share your app
  }

  void _logOut(){
    instance<AppPreferences>().logOut();
    instance<LocalDataSource>().clearCache();

    Navigator.pushReplacementNamed(context, Routes.loginRoute);
  }

}
