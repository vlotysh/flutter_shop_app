import 'package:flutter/material.dart';

class CartProductItem extends StatelessWidget {
  double amount;
  int quantity;
  String title;

  CartProductItem({this.amount, this.quantity, this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Spacer(),
              Text('x${quantity}'),
              Chip(
                label: Text(
                  '\$${amount * quantity}',
                  style: TextStyle(
                      color: Theme.of(context).textTheme.headline1.color),
                ),
                backgroundColor: Theme.of(context).primaryColor,
              ),
            ],
          ),
        ),
        Divider()
      ],
    );
  }
}
