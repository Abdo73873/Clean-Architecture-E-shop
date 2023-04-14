import 'package:flutter/material.dart';
import 'package:mena/persentation/resources/routes_manger.dart';

class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: IconButton(
        onPressed: (){
          Navigator.pushReplacementNamed(context, Routes.loginRoute);
        },
        icon: Icon(Icons.logout),
      ),
    );
  }
}
