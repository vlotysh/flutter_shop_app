import 'package:flutter/material.dart';
import 'package:shop_app/app/widgets/products_grid.dart';

class ProductsOverviewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shop app'),
      ),
      body: ProductsGrid(),
    );
  }
}
