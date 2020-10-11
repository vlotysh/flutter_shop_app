import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../providers/orders.dart' as orderData;

class OrderItem extends StatefulWidget {
  final orderData.OrderItem order;

  OrderItem(this.order);

  @override
  _OrderItemState createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  bool _showExpanded = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      height: _showExpanded
          ? min(widget.order.products.length * 20.0 + 120, 200)
          : 100,
      child: Card(
        margin: EdgeInsets.all(10),
        child: Column(
          children: [
            ListTile(
              title: Text('\$${widget.order.amount.toStringAsFixed(2)}'),
              subtitle: Text(DateFormat.yMMMd().format(widget.order.dateTime)),
              trailing: IconButton(
                icon:
                    Icon(_showExpanded ? Icons.expand_less : Icons.expand_more),
                onPressed: () {
                  setState(() {
                    _showExpanded = !_showExpanded;
                  });
                },
              ),
            ),
            Column(
              children: [
                AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  height: _showExpanded
                      ? min(widget.order.products.length * 20.0 + 10, 100)
                      : 0,
                  child: ListView.builder(
                    itemBuilder: (ctx, index) {
                      var product = widget.order.products[index];

                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 2, horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${product.title}',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Spacer(),
                            Text('${product.quantity}x \$${product.price}'),
                          ],
                        ),
                      );
                    },
                    itemCount: widget.order.products.length,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
