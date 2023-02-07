import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

import '../../utils/http_exception.dart';

class Auth with ChangeNotifier {
  String _token;
  DateTime _expiryaDate;
  // String _userId;

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
    final url = Uri.http('moviesapi.ir', '/oauth/token');

    try {
      final res = await http.post(
        url,
        body: {
          'grant_type': 'password',
          'username': email,
          'password': password,
        },
      );

      final resData = json.decode(res.body);
      if (resData['error'] != null) {
        throw HttpException(resData['message']);
      }
      print(resData);
      _token = resData['access_token'];
      _expiryaDate =
          DateTime.now().add(Duration(seconds: resData['expires_in']));
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }
}
