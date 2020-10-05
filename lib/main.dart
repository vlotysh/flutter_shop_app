import 'package:flutter/material.dart';
import 'package:shop_app/config/flavor_config.dart';

import 'app/ShopApp.dart';

void main() {
  FlavorConfig(
      flavor: Flavor.DEV,
      color: Colors.purple,
      values: FlavorValues(
          //https://medium.com/flutter-community/flutter-ready-to-go-e59873f9d7de#c38c
          baseStorageUrl: "https://app-mobile-app-c8573.firebaseio.com"));
  runApp(ShopApp());
}
