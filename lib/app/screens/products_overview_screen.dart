import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/app/providers/cart.dart';
import 'package:shop_app/app/screens/cart_screen.dart';
import 'package:shop_app/app/widgets/badge.dart';
import 'package:shop_app/app/widgets/products_grid.dart';
import 'package:shop_app/app/widgets/side_drawer.dart';

enum FilterOptions { Favorite, All }

class ProductsOverviewScreen extends StatefulWidget {
  @override
  _ProductsOverviewScreenState createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  bool _showOnlyFavorites = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shop app'),
        actions: [
          PopupMenuButton(
            onSelected: (FilterOptions selectedValue) {
              setState(() {
                // use only for local state
                if (selectedValue == FilterOptions.Favorite) {
                  _showOnlyFavorites = true;
                } else {
                  _showOnlyFavorites = false;
                }
              });
            },
            icon: Icon(Icons.more_vert),
            itemBuilder: (_) => [
              PopupMenuItem(
                  child: Text('Only favorites'), value: FilterOptions.Favorite),
              PopupMenuItem(child: Text('Show all'), value: FilterOptions.All)
            ],
          ),
          Consumer<Cart>(
            builder: (_, cart, ch) => Badge(
              child: ch, // child from Consumer method
              value: '${cart.itemCount}',
            ),
            child: IconButton(
                icon: Icon(
                  Icons.shopping_cart,
                  color: Colors.white,
                ),
                onPressed: () =>
                    Navigator.of(context).pushNamed(CartScreen.routeName)),
          )
        ],
      ),
      body: ProductsGrid(showOnlyFavorites: _showOnlyFavorites),
      drawer: SideDrawer(),
    );
  }
}
