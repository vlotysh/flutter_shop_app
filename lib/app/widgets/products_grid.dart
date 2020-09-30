import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/app/providers/products.dart';
import 'package:shop_app/app/widgets/product_item.dart';

class ProductsGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Products productData = Provider.of<Products>(context);
    final products = productData.items;

    return GridView.builder(
      padding: const EdgeInsets.all(10.0),
      itemBuilder: (ctx, index) => ChangeNotifierProvider(
          create: (_) => products[index], child: ProductItem()),
      itemCount: products.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10),
    );
  }
}
