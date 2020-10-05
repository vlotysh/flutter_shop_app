import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shop_app/config/flavor_config.dart';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite = false;

  Product(
      {@required this.id,
      @required this.title,
      @required this.description,
      @required this.price,
      @required this.imageUrl,
      this.isFavorite = false});

  void _revertFavorite(oldStatus) {
    isFavorite = oldStatus;
    notifyListeners();
  }

  void toggleFavorite() async {
    bool oldIsFavorite = isFavorite;
    isFavorite = !oldIsFavorite;
    notifyListeners();

    final url =
        '${FlavorConfig.instance.values.baseStorageUrl}/products/$id.json';

    try {
      http.Response response =
          await http.patch(url, body: json.encode({'isFavorite': isFavorite}));

      if (response.statusCode >= 400) {
        _revertFavorite(oldIsFavorite);
      }
    } catch (error) {
      _revertFavorite(oldIsFavorite);
    }
  }
}
