import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/app/providers/products.dart';
import 'package:shop_app/app/screens/edit_products_screen.dart';
import 'package:shop_app/app/widgets/loading_spinner.dart';
import 'package:shop_app/app/widgets/side_drawer.dart';
import 'package:shop_app/app/widgets/user_product_item.dart';

class UserProductsScreen extends StatelessWidget {
  static const routeName = '/user-products';

  @override
  Widget build(BuildContext context) {
    Future<void> _refreshProducts(BuildContext context) async {
      await Provider.of<Products>(context, listen: false).fetchProducts(true);
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
      drawer: SideDrawer(),
      body: FutureBuilder(
        future: _refreshProducts(context),
        builder: (ctx, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? LoadingSpinner()
            : RefreshIndicator(
                onRefresh: () => _refreshProducts(context),
                child: Consumer<Products>(
                  builder: (ctx, productsData, child) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                      itemBuilder: (ctx, index) => Column(
                        children: [
                          UserProductItem(product: productsData.items[index]),
                          Divider(),
                        ],
                      ),
                      itemCount: productsData.items.length,
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
