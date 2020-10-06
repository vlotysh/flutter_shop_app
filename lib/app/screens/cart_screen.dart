import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/app/providers/cart.dart';
import 'package:shop_app/app/widgets/cart_item.dart' as ci;
import 'package:shop_app/app/widgets/order_button.dart';

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
                  '\$${cart.totalAmount.toStringAsFixed(2)}',
                  style: TextStyle(
                      color: Theme.of(context).textTheme.headline1.color),
                ),
                backgroundColor: Theme.of(context).primaryColor,
              ),
              OrderButton()
            ],
          ),
        ),
        Divider(),
        Expanded(
          child: Container(
            // height: MediaQuery.of(context).size.height - 200,
            child: ListView.builder(
              itemCount: cart.items.length,
              itemBuilder: (ctx, index) {
                //  List keys = cart.items.keys.toList();
                //  String key = keys[index];
                //  CartItem cartItem = cart.items[key];

                CartItem cartItem = cart.items.values.toList()[index];
                String productId = cart.items.keys.toList()[index];

                return ci.CartItem(
                  id: cartItem.id,
                  productId: productId,
                  title: cartItem.title,
                  amount: cartItem.price,
                  quantity: cartItem.quantity,
                );
              },
            ),
          ),
        ),
      ]),
    );
  }
}
