import 'dart:convert';
import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../config/constants/app_constants.dart' as constants;
import '../../config/config.dart' as config;

import '../../utils/http_exception.dart';

class Auth with ChangeNotifier {
  String _token;
  DateTime _expiryaDate;
  // String _userId;
  Timer _authTimer;

  bool get isAuth {
    return token != null;
  }

  String get token {
    if (_expiryaDate != null &&
        _expiryaDate.isAfter(DateTime.now()) &&
        _token != null) {
      return _token;
    }
    return null;
  }

  Future<void> signup(String email, String password) async {
    final url = Uri.http('moviesapi.ir', '/api/v1/register');
    final name = email.substring(0, email.indexOf('@'));

    final res = await http.post(
      url,
      body: {
        'name': name,
        'email': email,
        'password': password,
      },
    );

    print(json.decode(res.body));
  }

  Future<void> signin(String email, String password) async {
    final url = Uri.parse(config.APP.apiAddress + '/oauth/token');
    // final url = Uri.https('moviesapi.ir', '/oauth/token');

    print('url: $url');

    try {
      final res = await http.post(url, body: {
        'grant_type': 'password',
        'username': email,
        'password': password,
      });

      print('res: $res');

      final resData = json.decode(res.body);
      if (resData['error'] != null) {
        throw HttpException(resData['message']);
      }
      print(resData);
      _token = resData['access_token'];
      _expiryaDate =
          DateTime.now().add(Duration(seconds: resData['expires_in']));
      _autoSignOut();
      notifyListeners();
      final prefs = await SharedPreferences.getInstance();
      final userData = json.encode({
        'token': _token,
        'expiryaDate': _expiryaDate.toIso8601String(),
      });
      prefs.setString('userData', userData);
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) return false;

    final extractedUserData =
        json.decode(prefs.getString('userData')) as Map<String, Object>;
    final expiryDate = DateTime.parse(extractedUserData['expiryaDate']);

    if (expiryDate.isBefore(DateTime.now())) return false;

    _token = extractedUserData['token'];
    _expiryaDate = expiryDate;
    notifyListeners();
    _autoSignOut();
    return true;
  }

  Future<void> signout() async {
    _token = null;
    _expiryaDate = null;
    if (_authTimer != null) {
      _authTimer.cancel();
      _authTimer = null;
    }

    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
    // prefs.remove('expiryaDate');
  }

  void _autoSignOut() {
    if (_authTimer != null) _authTimer.cancel();
    final timeToExpiry = _expiryaDate.difference(DateTime.now()).inSeconds;
    Timer(Duration(seconds: timeToExpiry), signout);
  }
}
