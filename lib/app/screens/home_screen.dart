import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shop app'),
      ),
      body: Center(
        child: Center(child: Text('Shop app')),
      ),
    );
  }
}
