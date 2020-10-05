import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/app/providers/product.dart';
import 'package:shop_app/app/providers/products.dart';
import 'package:shop_app/app/screens/edit_products_screen.dart';
import 'package:shop_app/app/widgets/side_drawer.dart';
import 'package:shop_app/app/widgets/user_product_item.dart';

class UserProductsScreen extends StatelessWidget {
  static const routeName = '/user-products';

  @override
  Widget build(BuildContext context) {
    final Products productsData = Provider.of<Products>(context);
    List<Product> products = productsData.items;

    Future<void> _refreshProducts(BuildContext context) async {
      Provider.of<Products>(context, listen: false).fetchProducts();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('User products'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () =>
                Navigator.of(context).pushNamed(EditProductsScreen.routeName),
          )
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => _refreshProducts(context),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
            itemBuilder: (ctx, index) => Column(
              children: [
                UserProductItem(product: products[index]),
                Divider(),
              ],
            ),
            itemCount: products.length,
          ),
        ),
      ),
      drawer: SideDrawer(),
    );
  }
}
