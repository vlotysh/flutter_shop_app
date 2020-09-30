import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/app/arguments/product_detail_argument.dart';
import 'package:shop_app/app/providers/product.dart';
import 'package:shop_app/app/providers/products.dart';

class ProductDetailScreen extends StatelessWidget {
  static const routeName = '/product-detail';

  @override
  Widget build(BuildContext context) {
    ProductDetailArguments arguments =
        ModalRoute.of(context).settings.arguments;

    String id = arguments.productId;

    final Product product =
        Provider.of<Products>(context, listen: false).findById(id);
    //listen: false false is disable re run build method on every change provider

    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
      ),
      body: Center(
        child: Center(child: Text(product.title)),
      ),
    );
  }
}
