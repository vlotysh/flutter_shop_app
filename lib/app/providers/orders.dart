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
  final DateTime dateTime;

  OrderItem(
      {@required this.id,
      @required this.amount,
      @required this.products,
      @required this.dateTime});
}

class Orders with ChangeNotifier {
  final String authToken;

  Orders(this.authToken, this._orders);

  List<OrderItem> _orders = [];

  List<OrderItem> get orders {
    return [..._orders];
  }

  Future<void> fetchOrders() async {
    final url =
        '${FlavorConfig.instance.values.baseStorageUrl}/orders.json?auth=$authToken';

    http.Response response = await http.get(url);
    final extractedDAta = json.decode(response.body) as Map<String, dynamic>;
    final List<OrderItem> loadedOrders = [];

    if (extractedDAta == null) {
      return;
    }

    extractedDAta.forEach((key, orderData) {
      final List<CartItem> cartItems = [];

      loadedOrders.add(OrderItem(
        id: key,
        amount: orderData['total'],
        products: (orderData['products'] as List<dynamic>).map((item) {
          return CartItem(
            id: item['id'],
            productId: item['productId'],
            title: item['title'],
            quantity: item['quantity'],
            price: item['price'],
          );
        }).toList(),
        dateTime: DateTime.parse('${orderData['dateTime']}'),
      ));
    });

    _orders = loadedOrders;
    notifyListeners();
  }

  Future<void> addOrder(List<CartItem> cartProducts, double total) async {
    final url =
        '${FlavorConfig.instance.values.baseStorageUrl}/orders.json?auth=$authToken';

    try {
      http.Response response = await http.post(url,
          body: json.encode({
            'total': total,
            'dateTime': DateTime.now().toIso8601String(),
            'products': cartProducts
                .map((CartItem cartItem) => {
                      'id': cartItem.id,
                      'title': cartItem.title,
                      'price': cartItem.price,
                      'productId': cartItem.productId,
                      'quantity': cartItem.quantity,
                    })
                .toList(),
          }));

      _orders.insert(
          0,
          OrderItem(
              amount: total, products: cartProducts, dateTime: DateTime.now()));
      print(_orders);
      notifyListeners();
    } catch (error) {
      throw HttpException(error.toString());
    }
  }
}
