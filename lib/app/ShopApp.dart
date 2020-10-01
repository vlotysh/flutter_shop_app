import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/app/providers/cart.dart';
import 'package:shop_app/app/providers/products.dart';
import 'package:shop_app/app/screens/cart_screen.dart';
import 'package:shop_app/app/screens/home_screen.dart';
import 'package:shop_app/app/screens/product_detail_screen.dart';
import 'package:shop_app/app/screens/products_overview_screen.dart';

class ShopApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Products(),
        ),
        ChangeNotifierProvider.value(
          value: Cart(),
        ),
      ],
      child: MaterialApp(
        initialRoute: HomeScreen.routeName,
        routes: {
          '/': (_) => ProductsOverviewScreen(),
          ProductDetailScreen.routeName: (_) => ProductDetailScreen(),
          CartScreen.routeName: (_) => CartScreen(),
        },
        title: 'Shop App',
        theme: ThemeData(
            primarySwatch: Colors.purple,
            primaryColor: Colors.purple,
            accentColor: Colors.deepOrange,
            fontFamily: 'Lato',
            textTheme: TextTheme(
                headline1: TextStyle(fontFamily: 'Lato', color: Colors.white))),
      ),
    );
  }
}
