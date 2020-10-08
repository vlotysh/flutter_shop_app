import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('Loading...'),
          SizedBox(
            child: CircularProgressIndicator(),
            height: 48,
            width: 48,
          )
        ],
      ),
    );
  }
}
