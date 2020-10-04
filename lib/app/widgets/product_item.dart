import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/app/arguments/product_detail_argument.dart';
import 'package:shop_app/app/providers/cart.dart';
import 'package:shop_app/app/providers/product.dart';
import 'package:shop_app/app/screens/product_detail_screen.dart';

class ProductItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Product product = Provider.of<Product>(context, listen: false);
    final Cart cart = Provider.of<Cart>(context,
        listen:
            false); // listen false for do not rebuild on change but make some actions with cart

    //listen: false is deny of rebuild by event listener
    // Consumer can wrap part of widget tree that need to by re build
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
          leading: Consumer<Product>(
            // ONLY this par of widget listen to entity change
            builder: (ctx, product, child) => IconButton(
              icon: Icon(
                  product.isFavorite ? Icons.favorite : Icons.favorite_border),
              color: Theme.of(context).accentColor,
              onPressed: () => product.toggleFavorite(),
            ),
            child: Text('NEVER CHANGES!'), //passing throw 3 argument `child`
          ),
          backgroundColor: Colors.black87,
          title: Text(
            product.title,
            textAlign: TextAlign.center,
          ),
          trailing: IconButton(
              icon: Icon(Icons.shopping_cart,
                  color: Theme.of(context).accentColor),
              color: Theme.of(context).accentColor,
              onPressed: () {
                Scaffold.of(context).hideCurrentSnackBar();
                cart.addItem(product.id, product.price, product.title);
                Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text('${product.title} added to cart'),
                  action: SnackBarAction(
                    label: 'UNDO',
                    onPressed: () => cart.removeSingleItem(product.id),
                  ),
                  duration: Duration(seconds: 2),
                ));
              }),
        ),
      ),
    );
  }
}
