import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class Auth with ChangeNotifier {
  String _token;
  DateTime _expiryaDate;
  String _userId;

  Future<void> signup(String email, String password) async {
    final url = Uri.http('moviesapi.ir', '/api/v1/register');
    final name = email.substring(0, email.indexOf('@'));

    // print(email + '---' + password + '---' + name);

    final res = await http.post(url,
        body: json.encode({
          'name': name,
          'email': email,
          'password': password,
        }));

    print(json.decode(res.body));
  }
}
