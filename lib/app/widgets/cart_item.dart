import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/app/providers/cart.dart';

class CartItem extends StatelessWidget {
  String id;
  String productId;
  double amount;
  int quantity;
  String title;

  CartItem({this.id, this.productId, this.amount, this.quantity, this.title});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        Provider.of<Cart>(context, listen: false).removeItem(productId);
      },
      background: Container(
        color: Theme.of(context).errorColor,
        alignment: Alignment.centerRight,
        child: Icon(Icons.delete, size: 40, color: Colors.white),
      ),
      key: ValueKey(id),
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        child: ListTile(
          leading: Padding(
            padding: const EdgeInsets.all(10.0),
            child: FittedBox(
              child: CircleAvatar(
                child: Text('\$$amount'),
              ),
            ),
          ),
          title: Text(title),
          subtitle: Text('Total: \$${(amount * quantity).toStringAsFixed(2)}'),
          trailing: Text('x$quantity'),
        ),
      ),
    );
  }
}
