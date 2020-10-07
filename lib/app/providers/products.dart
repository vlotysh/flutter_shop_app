import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shop_app/app/models/http_exception.dart';
import 'package:shop_app/config/flavor_config.dart';

import './product.dart';

class Products with ChangeNotifier {
  List<Product> _items = [
    /** Product(
      id: 'p1',
      title: 'Red Shirt',
      description: 'A red shirt - it is pretty red!',
      price: 29.99,
      imageUrl:
          'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    ),
    Product(
      id: 'p2',
      title: 'Trousers',
      description: 'A nice pair of trousers.',
      price: 59.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    ),
    Product(
      id: 'p3',
      title: 'Yellow Scarf',
      description: 'Warm and cozy - exactly what you need for the winter.',
      price: 19.99,
      imageUrl:
          'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    ),
    Product(
      id: 'p4',
      title: 'A Pan',
      description: 'Prepare any meal you want.',
      price: 49.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    ),*/
  ];

  List<Product> get items {
    return [..._items]; //prevent access by reference in memory
  }

  List<Product> get favoriteItems {
    return _items
        .where((product) => product.isFavorite)
        .toList(); //prevent access by reference in memory
  }

  Product findById(String id) {
    return _items.firstWhere((Product item) => item.id == id);
  }

  Future<void> fetchProducts() async {
    final url = '${FlavorConfig.instance.values.baseStorageUrl}/products.json';

    try {
      final http.Response response = await http.get(url);
      final extractedDAta = json.decode(response.body) as Map<String, dynamic>;

      if (extractedDAta == null) {
        return;
      }

      final List<Product> loadedProducts = [];

      extractedDAta.forEach((key, productData) {
        loadedProducts.add(Product(
            id: key,
            title: productData['title'],
            price: productData['price'],
            imageUrl: productData['imageUrl'],
            description: productData['description'],
            isFavorite: productData['isFavorite']));
      });

      _items = loadedProducts;
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> addProduct(Product value) async {
    final url = '${FlavorConfig.instance.values.baseStorageUrl}/products.json';

    try {
      http.Response response = await http.post(url,
          body: json.encode({
            'title': value.title,
            'description': value.description,
            'price': value.price,
            'imageUrl': value.imageUrl,
            'isFavorite': value.isFavorite
          }));

      Map responseBody = json.decode(response.body);
      final newProduct = Product(
          id: responseBody['name'],
          title: value.title,
          description: value.description,
          imageUrl: value.imageUrl,
          price: value.price,
          isFavorite: value.isFavorite);
      _items.add(newProduct);

      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> updateProduct(String id, Product product) async {
    final prodIndex = _items.indexWhere((prod) => prod.id == id);
    if (prodIndex >= 0) {
      try {
        final url =
            '${FlavorConfig.instance.values.baseStorageUrl}/products/${id}.json';
        await http.patch(url,
            body: json.encode({
              'title': product.title,
              'description': product.description,
              'price': product.price,
              'isFavorite': product.isFavorite,
              'imageUrl': product.imageUrl,
            }));
      } catch (error) {
        throw error;
      }
      _items[prodIndex] = product;
      notifyListeners();
    }
  }

  Future<void> removeProduct(String id) async {
    final url =
        '${FlavorConfig.instance.values.baseStorageUrl}/products/${id}.json';
    final existingProductIndex =
        _items.indexWhere((product) => product.id == id);
    var existingProduct = _items[existingProductIndex];

    http.Response response = await http.delete(url);
    _items.removeAt(existingProductIndex);
    notifyListeners();

    if (response.statusCode >= 400) {
      _items.insert(existingProductIndex, existingProduct);
      notifyListeners();
      throw HttpException('Could not delete product');
    }

    existingProduct = null;
  }
}
