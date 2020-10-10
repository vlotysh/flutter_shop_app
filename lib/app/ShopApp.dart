import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/app/providers/auth.dart';
import 'package:shop_app/app/providers/cart.dart';
import 'package:shop_app/app/providers/orders.dart';
import 'package:shop_app/app/providers/products.dart';
import 'package:shop_app/app/screens/auth_screen.dart';
import 'package:shop_app/app/screens/cart_screen.dart';
import 'package:shop_app/app/screens/edit_products_screen.dart';
import 'package:shop_app/app/screens/orders_screen.dart';
import 'package:shop_app/app/screens/product_detail_screen.dart';
import 'package:shop_app/app/screens/products_overview_screen.dart';
import 'package:shop_app/app/screens/splash_screen.dart';
import 'package:shop_app/app/screens/user_products_screen.dart';

class ShopApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, Products>(
            create: (_) => Products(null, null, []),
            update: (_, Auth auth, Products product) => Products(
                auth.token, auth.userId, product == null ? [] : product.items)),
        ChangeNotifierProvider(
          create: (_) => Cart(),
        ),
        ChangeNotifierProxyProvider<Auth, Orders>(create: (_) {
          return Orders(null, null, []);
        }, update: (_, Auth auth, Orders orders) {
          return Orders(
              auth.token, auth.userId, orders == null ? [] : orders.orders);
        }),
      ],
      child: Consumer<Auth>(
          builder: (ctx, authData, child) => MaterialApp(
                home: authData.isAuthenticated
                    ? ProductsOverviewScreen()
                    : FutureBuilder(
                        future: authData.tryAutoLogin(),
                        builder: (ctx, authResultSnapshot) {
                          if (authResultSnapshot.connectionState ==
                              ConnectionState.waiting) {
                            return SplashScreen();
                          }
                          return AuthScreen();
                        }),
                routes: {
                  ProductsOverviewScreen.routeName: (_) =>
                      ProductsOverviewScreen(),
                  AuthScreen.routeName: (_) => AuthScreen(),
                  ProductDetailScreen.routeName: (_) => ProductDetailScreen(),
                  CartScreen.routeName: (_) => CartScreen(),
                  OrdersScreen.routeName: (_) => OrdersScreen(),
                  UserProductsScreen.routeName: (_) => UserProductsScreen(),
                  EditProductsScreen.routeName: (_) => EditProductsScreen(),
                },
                title: 'Shop App',
                theme: ThemeData(
                    primarySwatch: Colors.purple,
                    primaryColor: Colors.purple,
                    accentColor: Colors.deepOrange,
                    fontFamily: 'Lato',
                    textTheme: TextTheme(
                        headline1: TextStyle(
                            fontFamily: 'Lato', color: Colors.white))),
              )),
    );
  }
}
