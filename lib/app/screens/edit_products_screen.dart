import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/app/providers/product.dart';
import 'package:shop_app/app/providers/products.dart';

class EditProductsScreen extends StatefulWidget {
  static const routeName = '/edit-products';

  @override
  _EditProductsScreenState createState() => _EditProductsScreenState();
}

class _EditProductsScreenState extends State<EditProductsScreen> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageFocusNode = FocusNode();
  var _imageUrlController = TextEditingController();
  final _form = GlobalKey<FormState>();
  var _editedProduct =
      new Product(id: null, title: '', description: '', price: 0, imageUrl: '');
  var _initValues = {
    'title': '',
    'description': '',
    'price': '0',
    'imageUrl': '',
  };
  var _isInit = true;
  bool isInProgress = false;

  void _updateImageUrl() {
    if (!_imageFocusNode.hasFocus) {
      setState(() {});
    }
  }

  void _saveForm(context) {
    if (_form.currentState.validate()) {
      // trigger validation
      _form.currentState.save();

      if (_editedProduct.id == null) {
        setState(() {
          isInProgress = true;
        });

        Provider.of<Products>(context, listen: false)
            .addProduct(_editedProduct)
            .catchError((error) {
          return showDialog(
              context: context,
              builder: (ctx) => AlertDialog(
                    title: Text('Error on saving product'),
                    content: Text('Something went wrong'),
                    actions: [
                      FlatButton(
                          child: Text('Okay'),
                          onPressed: () {
                            Navigator.of(ctx).pop();
                          })
                    ],
                  ));
        }).then((_) {
          setState(() {
            isInProgress = false;
          });

          Navigator.of(context).pop();
        });
      } else {
        Provider.of<Products>(context, listen: false)
            .updateProduct(_editedProduct.id, _editedProduct);
        setState(() {
          isInProgress = false;
        });

        Navigator.of(context).pop();
      }
    }
  }

  @override
  void initState() {
    _imageFocusNode.addListener(_updateImageUrl);
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    _imageFocusNode.removeListener(_updateImageUrl);
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageFocusNode.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final productId = ModalRoute.of(context).settings.arguments;

      if (productId != null) {
        _editedProduct =
            Provider.of<Products>(context, listen: false).findById(productId);

        _initValues = {
          'title': _editedProduct.title,
          'description': _editedProduct.description,
          'price': _editedProduct.price.toString(),
          'imageUrl': '',
        };

        _imageUrlController.text = _editedProduct.imageUrl;
      }
    }

    _isInit = false;

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit product'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              _saveForm(context);
            },
          )
        ],
      ),
      body: isInProgress
          ? Center(
              child: SizedBox(
                child: CircularProgressIndicator(),
                height: 48,
                width: 48,
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _form,
                child: SingleChildScrollView(
                    child: Column(children: <Widget>[
                  TextFormField(
                    initialValue: _initValues['title'],
                    decoration: InputDecoration(labelText: 'Title'),
                    textInputAction:
                        TextInputAction.next, // go to next field button
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_priceFocusNode);
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Text is needed'; //return error
                      }

                      return null; // field is ok
                    },
                    onSaved: (value) {
                      _editedProduct = Product(
                          id: _editedProduct.id,
                          title: value,
                          description: _editedProduct.description,
                          price: _editedProduct.price,
                          isFavorite: _editedProduct.isFavorite,
                          imageUrl: _editedProduct.imageUrl);
                    },
                  ),
                  TextFormField(
                    initialValue: _initValues['price'],
                    decoration: InputDecoration(labelText: 'Price'),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Price is needed';
                      }

                      if (double.tryParse(value) == null) {
                        return 'Price must be number';
                      }

                      if (double.parse(value) <= 0) {
                        return 'Price must be more then 0';
                      }

                      return null;
                    },
                    textInputAction: TextInputAction.next, // go to next field
                    keyboardType: TextInputType.number,
                    focusNode: _priceFocusNode,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context)
                          .requestFocus(_descriptionFocusNode);
                    },
                    onSaved: (value) {
                      _editedProduct = Product(
                          id: _editedProduct.id,
                          title: _editedProduct.title,
                          description: _editedProduct.description,
                          price: double.parse(value),
                          isFavorite: _editedProduct.isFavorite,
                          imageUrl: _editedProduct.imageUrl);
                    },
                  ),
                  TextFormField(
                      initialValue: _initValues['description'],
                      decoration: InputDecoration(labelText: 'Description'),
                      maxLines: 3,
                      focusNode: _descriptionFocusNode,
                      keyboardType: TextInputType.multiline,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Description is needed'; //return error
                        }

                        if (value.length < 10) {
                          return 'Description must be longer then 10';
                        }

                        return null; // field is ok
                      },
                      onSaved: (value) {
                        _editedProduct = Product(
                            id: _editedProduct.id,
                            title: _editedProduct.title,
                            description: value,
                            price: _editedProduct.price,
                            isFavorite: _editedProduct.isFavorite,
                            imageUrl: _editedProduct.imageUrl);
                      } // go to next field button
                      ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        margin: EdgeInsets.only(top: 8, right: 8),
                        decoration: BoxDecoration(
                            border: Border.all(width: 1, color: Colors.grey)),
                        child: _imageUrlController.text.isEmpty
                            ? Text('Enter url')
                            : FittedBox(
                                child: Image.network(_imageUrlController.text),
                                fit: BoxFit.cover,
                              ),
                      ),
                      Expanded(
                        child: TextFormField(
                          decoration: InputDecoration(labelText: 'Image URL'),
                          keyboardType: TextInputType.url,
                          textInputAction: TextInputAction.done,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Image is needed'; //return error
                            }

                            return null; // field is ok
                          },
                          controller: _imageUrlController,
                          focusNode: _imageFocusNode,
                          onFieldSubmitted: (_) {
                            _saveForm(context);
                          },
                          onChanged: (value) {},
                          onEditingComplete: () {
                            setState(() {});
                          },
                          onSaved: (value) {
                            _editedProduct = Product(
                                id: _editedProduct.id,
                                title: _editedProduct.title,
                                description: _editedProduct.description,
                                price: _editedProduct.price,
                                isFavorite: _editedProduct.isFavorite,
                                imageUrl: value);
                          },
                        ),
                      )
                    ],
                  ),
                  FlatButton(
                    child: Text('Done',
                        style:
                            TextStyle(color: Theme.of(context).primaryColor)),
                    onPressed: () {
                      _saveForm(context);
                    },
                  )
                ])),
              ),
            ),
    );
  }
}
