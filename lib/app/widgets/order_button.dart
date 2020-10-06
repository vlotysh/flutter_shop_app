import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/app/providers/cart.dart';
import 'package:shop_app/app/providers/orders.dart';

class OrderButton extends StatefulWidget {
  @override
  _OrderButtonState createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
  bool _isOrderProcess = false;

  @override
  Widget build(BuildContext context) {
    final Cart cart = Provider.of<Cart>(context);

    return _isOrderProcess
        ? Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: CircularProgressIndicator(),
          )
        : FlatButton(
            child: const Text('Order now!'),
            onPressed: (cart.totalAmount <= 0 || _isOrderProcess)
                ? null
                : () async {
                    print('ORDER HANDLER');
                    setState(() {
                      _isOrderProcess = true;
                    });

                    await Provider.of<Orders>(context, listen: false)
                        .addOrder(cart.items.values.toList(), cart.totalAmount);

                    cart.clearCart();

                    setState(() {
                      _isOrderProcess = false;
                    });
                  },
            textColor: Theme.of(context).primaryColor,
          );
  }
}
