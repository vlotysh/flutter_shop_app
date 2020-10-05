import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/app/providers/product.dart';
import 'package:shop_app/app/providers/products.dart';
import 'package:shop_app/app/screens/edit_products_screen.dart';
import 'package:shop_app/app/widgets/delete_product_button.dart';

class UserProductItem extends StatelessWidget {
  final Product product;

  UserProductItem({this.product});

  @override
  Widget build(BuildContext context) {
    final scaffold = Scaffold.of(context);

    return ListTile(
      title: Text(product.title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(product.imageUrl),
      ),
      trailing: Container(
        width: 100,
        child: Row(
          children: [
            IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  Navigator.of(context).pushNamed(EditProductsScreen.routeName,
                      arguments: product.id);
                },
                color: Theme.of(context).primaryColor),
            DeleteProductButton(
              deleteHandler: () async {
                try {
                  await Provider.of<Products>(context, listen: false)
                      .removeProduct(product.id);
                } catch (error) {
                  scaffold.showSnackBar(SnackBar(
                    content: Text('Error on delete: $error'),
                    duration: Duration(seconds: 2),
                  ));
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
