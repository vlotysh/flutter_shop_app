import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/app/providers/auth.dart';
import 'package:shop_app/app/screens/auth_screen.dart';
import 'package:shop_app/app/screens/orders_screen.dart';
import 'package:shop_app/app/screens/products_overview_screen.dart';
import 'package:shop_app/app/screens/user_products_screen.dart';

class DrawerItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final Function onTap;

  DrawerItem(this.title, this.icon, this.onTap);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, size: 26),
      title: Text(title,
          style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              fontFamily: 'RobotCondensed')),
      onTap: onTap,
    );
  }
}

class SideDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Column(
      children: [
        /*Container(
          height: 120,
          width: double.infinity,
          padding: EdgeInsets.all(20),
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: Theme.of(context).accentColor,
          ),
          child: Text('Shop app',
              style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 30,
                  color: Theme.of(context).primaryColor)),
        ) */
        AppBar(
          title: Text('Hello friend!'),
          automaticallyImplyLeading: false,
        ),
        SizedBox(
          height: 20,
        ),
        DrawerItem(
            'Home',
            Icons.home,
            () => Navigator.of(context)
                .pushReplacementNamed(ProductsOverviewScreen.routeName)),
        Divider(),
        DrawerItem(
            'Payment',
            Icons.payment,
            () => Navigator.of(context)
                .pushReplacementNamed(OrdersScreen.routeName)),
        Divider(),
        DrawerItem(
            'User products',
            Icons.description,
            () => Navigator.of(context)
                .pushReplacementNamed(UserProductsScreen.routeName)),
        Divider(),
        Expanded(
            child: Align(
                alignment: Alignment.bottomCenter,
                child: DrawerItem('Logout', Icons.exit_to_app, () {
                  Navigator.of(context)
                      .pushReplacementNamed(AuthScreen.routeName);
                  Provider.of<Auth>(context, listen: false).logout();
                }))),
      ],
    ));
  }
}
