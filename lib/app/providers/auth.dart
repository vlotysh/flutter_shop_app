import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Auth with ChangeNotifier {
  String _token;
  DateTime _expiryDate;
  String _userId;

  Future<void> signup(String email, String password) async {
    String url =
        'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyDb9lufDkkkjtYokXY0zxU07afnyU5FYXc';

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

  Future<void> login(String email, String password) async {
    String url =
        'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyDb9lufDkkkjtYokXY0zxU07afnyU5FYXc';

    try {
      http.Response response = await http.post(url,
          body: json.encode({
            'email': email,
            'password': password,
            'returnSecureToken': true,
          }));

      print(json.decode(response.body));

      /*idToken	string	A Firebase Auth ID token for the authenticated user.
email	string	The email for the authenticated user.
refreshToken	string	A Firebase Auth refresh token for the authenticated user.
expiresIn	string	The number of seconds in which the ID token expires.
localId	string	The uid of the authenticated user.
registered	boolean	Whether the email is for an existing account.*/
      //idToken, refreshToken, expiresIn, localI
      //notifyListeners();
    } catch (error) {
      print(error);
    }
  }
}
