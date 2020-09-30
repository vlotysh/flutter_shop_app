import 'package:flutter/material.dart';
import 'package:shop_app/app/screens/home_screen.dart';

class ShopApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        HomeScreen.routeName: (_) => HomeScreen(),
      },
      title: 'Shop App',
      //home: Categories(title: 'Meals App'),
    );
  }
}
