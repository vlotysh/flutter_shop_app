import 'package:flutter/material.dart';

class DeleteProductButton extends StatefulWidget {
  final Function deleteHandler;

  DeleteProductButton({this.deleteHandler});

  @override
  _DeleteProductButtonState createState() => _DeleteProductButtonState();
}

class _DeleteProductButtonState extends State<DeleteProductButton> {
  bool _isDeleteProcess = false;

  @override
  Widget build(BuildContext context) {
    return _isDeleteProcess
        ? CircularProgressIndicator()
        : IconButton(
            icon: Icon(Icons.delete),
            onPressed: () async {
              setState(() {
                _isDeleteProcess = true;
              });

              await widget.deleteHandler();

              setState(() {
                _isDeleteProcess = false;
              });
            },
            color: Theme.of(context).errorColor,
          );
  }
}
