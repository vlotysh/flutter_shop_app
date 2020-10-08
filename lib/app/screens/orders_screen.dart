import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/app/providers/orders.dart';
import 'package:shop_app/app/widgets/loading_spinner.dart';
import 'package:shop_app/app/widgets/side_drawer.dart';

import '../widgets/order_item.dart' as widget;

class OrdersScreen extends StatefulWidget {
  static const routeName = '/orders';

  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  Future _orderFuture;

  Future _obtainOrderFuture() {
    return Provider.of<Orders>(context, listen: false).fetchOrders();
  }

  @override
  void initState() {
    _orderFuture = _obtainOrderFuture(); // For creating only one future
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //final Orders orders = Provider.of<Orders>(context, listen: false);  NOT NEEDED  because user Consumer
    // final ordersList = orders.orders;
    return Scaffold(
      appBar: AppBar(title: Text('Orders')),
      body: FutureBuilder(
        future: _orderFuture,
        builder: (ctx, dataSnapshot) {
          if (dataSnapshot.connectionState == ConnectionState.waiting)
            return LoadingSpinner();
          if (dataSnapshot.hasError) return Center(child: Text('Error!'));

          return Consumer<Orders>(
            builder: (BuildContext ctx, Orders orderData, child) =>
                ListView.builder(
              itemBuilder: (ctx, index) {
                return widget.OrderItem(orderData.orders[index]);
              },
              itemCount: orderData.orders.length,
            ),
          );
        },
      ),
      drawer: SideDrawer(),
    );
  }
}
