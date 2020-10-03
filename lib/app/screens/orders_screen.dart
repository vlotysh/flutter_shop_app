import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/app/providers/orders.dart';
import 'package:shop_app/app/widgets/side_drawer.dart';

import '../widgets/order_item.dart' as widget;

class OrdersScreen extends StatelessWidget {
  static const routeName = '/orders';

  @override
  Widget build(BuildContext context) {
    final Orders orders = Provider.of<Orders>(context, listen: false);
    final ordersList = orders.orders;
    return Scaffold(
      appBar: AppBar(title: Text('Orders')),
      body: Column(
        children: [
          Expanded(
            child: Container(
              child: ListView.builder(
                itemBuilder: (ctx, index) {
                  return widget.OrderItem(ordersList[index]);
                },
                itemCount: ordersList.length,
              ),
            ),
          )
        ],
      ),
      drawer: SideDrawer(),
    );
  }
}
