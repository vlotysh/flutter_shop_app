import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/app/providers/cart.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';

  @override
  Widget build(BuildContext context) {
    final Cart cart = Provider.of<Cart>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Cart')),
      body: Column(children: [
        Card(
          margin: EdgeInsets.all(15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total',
                style: TextStyle(fontSize: 20),
              ),
              Spacer(),
              Chip(
                label: Text(
                  '\$${cart.totalAmount}',
                  style: TextStyle(
                      color: Theme.of(context).textTheme.headline1.color),
                ),
                backgroundColor: Theme.of(context).primaryColor,
              ),
              FlatButton(
                child: Text('Order now!'),
                onPressed: () {},
                textColor: Theme.of(context).primaryColor,
              )
            ],
          ),
        )
      ]),
    );
  }
}
