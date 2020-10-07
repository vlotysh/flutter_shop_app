import 'package:flutter/material.dart';
import 'package:shop_app/config/EnvConfig.dart';
import 'package:shop_app/config/flavor_config.dart';

import 'app/ShopApp.dart';

void main() {
  FlavorConfig(
      flavor: Flavor.DEV,
      color: Colors.purple,
      values: FlavorValues(
          //https://medium.com/flutter-community/flutter-ready-to-go-e59873f9d7de#c38c
          fireBaseApiKey: EnvConfig.FIREBASE_API_KEY,
          baseStorageUrl: EnvConfig.BASE_STORAGE_URL));
  runApp(ShopApp());
}
