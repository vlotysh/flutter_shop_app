import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shop_app/app/models/http_exception.dart';
import 'package:shop_app/app/providers/cart.dart';
import 'package:shop_app/config/flavor_config.dart';

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dataTime;

  OrderItem(
      {@required this.id,
      @required this.amount,
      @required this.products,
      @required this.dataTime});
}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];

  List<OrderItem> get orders {
    return [..._orders];
  }

  Future<void> addOrder(List<CartItem> cartProducts, double total) async {
    final url = '${FlavorConfig.instance.values.baseStorageUrl}/orders.json';

    try {
      http.Response response = await http.post(url,
          body: json.encode({
            'total': total,
            'dataTime': DateTime.now().toIso8601String(),
            'products': json.encode(cartProducts
                .map((CartItem cartItem) => {
                      'id': cartItem.id,
                      'title': cartItem.title,
                      'price': cartItem.price,
                      'productId': cartItem.productId,
                      'quantity': cartItem.quantity,
                    })
                .toList()),
          }));

      _orders.insert(
          0,
          OrderItem(
              amount: total, products: cartProducts, dataTime: DateTime.now()));
      print(_orders);
      notifyListeners();
    } catch (error) {
      throw HttpException(error.toString());
    }
  }
}
