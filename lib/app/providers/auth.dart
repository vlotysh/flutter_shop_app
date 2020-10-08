import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app/app/models/auth_exception.dart';
import 'package:shop_app/config/flavor_config.dart';

enum AuthType { LOGIN, SIGNUP }

class Auth with ChangeNotifier {
  final _apiKey = FlavorConfig.instance.values.fireBaseApiKey;
  String _token;
  DateTime _expiryDate;
  String _userId;
  Timer _authTimer;

  bool get isAuthenticated {
    return token != null;
  }

  String get token {
    if (_token != null &&
        _expiryDate != null &&
        _expiryDate.isAfter(DateTime.now())) {
      return _token;
    }

    return null;
  }

  String get userId {
    return _userId;
  }

  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {
      return false;
    }
    final extractedUserData =
        json.decode(prefs.getString('userData')) as Map<String, Object>;
    final expiryDate = DateTime.parse(extractedUserData['expiryDate']);

    if (expiryDate.isBefore(DateTime.now())) {
      return false;
    }
    _token = extractedUserData['token'];
    _userId = extractedUserData['userId'];
    _expiryDate = expiryDate;
    notifyListeners();
    _autoLogout();
    return true;
  }

  Future<void> _authentication(
      String email, String password, AuthType type) async {
    String method = type == AuthType.LOGIN ? 'signInWithPassword' : 'signUp';
    String url =
        'https://identitytoolkit.googleapis.com/v1/accounts:$method?key=$_apiKey';

    try {
      http.Response response = await http
          .post(url,
              body: json.encode({
                'email': email,
                'password': password,
                'returnSecureToken': true,
              }))
          .timeout(const Duration(seconds: 10));

      final responseBody = json.decode(response.body);
      print(responseBody);
      if (responseBody['error'] != null) {
        throw AuthException(responseBody['error']['message']);
      }

      _token = responseBody['idToken'];
      _userId = responseBody['localId'];
      _expiryDate = DateTime.now()
          .add(Duration(seconds: int.parse(responseBody['expiresIn'])));

      // _autoLogout();
      notifyListeners();
      final prefs = await SharedPreferences.getInstance();
      final userData = json.encode(
        {
          'token': _token,
          'userId': _userId,
          'expiryDate': _expiryDate.toIso8601String(),
        },
      );
      prefs.setString('userData', userData);
    } catch (error) {
      throw error;
    }
  }

  Future<void> signup(String email, String password) async {
    return _authentication(email, password, AuthType.SIGNUP);
  }

  Future<void> login(String email, String password) async {
    return _authentication(email, password, AuthType.LOGIN);
  }

  void logout() {
    _token = null;
    _userId = null;
    _expiryDate = null;
    if (_authTimer != null) {
      _authTimer.cancel();
      _authTimer = null;
    }

    notifyListeners();
  }

  void _autoLogout() {
    if (_authTimer != null) {
      _authTimer.cancel();
    }

    final tineToExp = _expiryDate.difference(DateTime.now()).inSeconds;
    _authTimer = Timer(Duration(seconds: 10), logout);
  }
}
