import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shop_app/config/flavor_config.dart';

enum AuthType { LOGIN, SIGNUP }

class Auth with ChangeNotifier {
  final _apiKey = FlavorConfig.instance.values.fireBaseApiKey;
  String _token;
  DateTime _expiryDate;
  String _userId;

  Future<void> _authentication(
      String email, String password, AuthType type) async {
    String method = type == AuthType.LOGIN ? 'signInWithPassword' : 'signUp';

    String url =
        'https://identitytoolkit.googleapis.com/v1/accounts:$method?key=$_apiKey';

    try {
      http.Response response = await http.post(url,
          body: json.encode({
            'email': email,
            'password': password,
            'returnSecureToken': true,
          }));

      print(json.decode(response.body));

      //idToken, refreshToken, expiresIn, localI
      //notifyListeners();
    } catch (error) {
      print(error);
    }
  }

  Future<void> signup(String email, String password) async {
    return _authentication(email, password, AuthType.SIGNUP);
    //idToken, refreshToken, expiresIn, localI
  }

  Future<void> login(String email, String password) async {
    return _authentication(email, password, AuthType.LOGIN);
    /*idToken	string	A Firebase Auth ID token for the authenticated user.
email	string	The email for the authenticated user.
refreshToken	string	A Firebase Auth refresh token for the authenticated user.
expiresIn	string	The number of seconds in which the ID token expires.
localId	string	The uid of the authenticated user.
registered	boolean	Whether the email is for an existing account.*/
    //idToken, refreshToken, expiresIn, localI
    //notifyListeners();
  }
}
