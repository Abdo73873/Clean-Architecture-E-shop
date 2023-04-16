import 'package:flutter/material.dart';
import 'package:mena/persentation/main/pages/home/view/home_page.dart';
import 'package:mena/persentation/main/pages/notification/view/notification_page.dart';
import 'package:mena/persentation/main/pages/search/view/search_page.dart';
import 'package:mena/persentation/main/pages/settings/view/settengs_page.dart';
import 'package:mena/persentation/resources/color_manager.dart';
import 'package:mena/persentation/resources/routes_manger.dart';
import 'package:mena/persentation/resources/strings_manager.dart';
import 'package:mena/persentation/resources/style_manager.dart';
import 'package:mena/persentation/resources/values_manager.dart';

class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  List<Widget> pages = [
    const HomePage(),
    const SearchPage(),
    const NotificationPage(),
    const SettingsPage(),
  ];
  final List<String> _titles =[
    AppStrings.home,
    AppStrings.search,
    AppStrings.notification,
    AppStrings.settings,
  ];
   int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[_currentIndex],
          style: Theme
              .of(context)
              .textTheme
              .titleSmall,),
      ),
      body: pages[_currentIndex],
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          boxShadow:[ BoxShadow(
              color: ColorManager.primary, spreadRadius: AppSize.s1)],
        ),
        child: BottomNavigationBar(
          selectedItemColor: ColorManager.primary,
          unselectedItemColor: ColorManager.gray,
          currentIndex: _currentIndex,
          onTap:onTap ,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.home),
              label: AppStrings.home
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.search),
              label: AppStrings.search
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.notifications),
              label: AppStrings.notification
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings),
              label: AppStrings.settings
            ),
          ],
        ),
      ),
    );
  }
  void onTap(int index){
    setState(() {
      _currentIndex=index;
    });
  }
}
