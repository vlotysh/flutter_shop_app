import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/app/arguments/product_detail_argument.dart';
import 'package:shop_app/app/providers/product.dart';
import 'package:shop_app/app/screens/product_detail_screen.dart';

class ProductItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Product product = Provider.of<Product>(context);

    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      child: GridTile(
        child: GestureDetector(
          onTap: () => Navigator.of(context).pushNamed(
              ProductDetailScreen.routeName,
              arguments: ProductDetailArguments(product.id)),
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        footer: GridTileBar(
          leading: IconButton(
            icon: Icon(
                product.isFavorite ? Icons.favorite : Icons.favorite_border),
            color: Theme.of(context).accentColor,
            onPressed: () => product.toggleFavorite(),
          ),
          backgroundColor: Colors.black87,
          title: Text(
            product.title,
            textAlign: TextAlign.center,
          ),
          trailing: IconButton(
            icon:
                Icon(Icons.shopping_cart, color: Theme.of(context).accentColor),
            color: Theme.of(context).accentColor,
            onPressed: () => {},
          ),
        ),
      ),
    );
  }
}