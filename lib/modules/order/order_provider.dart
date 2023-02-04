import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../cart/cart_provider.dart';

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> movies;
  final DateTime dateTime;

  OrderItem({
    @required this.id,
    @required this.amount,
    @required this.movies,
    @required this.dateTime,
  });
}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];

  List<OrderItem> get orders {
    return [..._orders];
  }

  Future<void> addOrder(List<CartItem> cartmovies, double total) async {
    final timestamp = DateTime.now();

    // final url = Uri.http('moviesapi.ir', '/api/v1/orders');
    // final res = await http.post(
    //   url,
    //   body: json.encode({
    //     'amount': total,
    //     'dateTime': timestamp.toIso8601String(),
    //     'movies': cartmovies
    //         .map((cm) => {
    //               'id': cm.id,
    //               'title': cm.title,
    //               'quantity': cm.quantity,
    //               'price': cm.price,
    //             })
    //         .toList()
    //   }),
    // );
    _orders.insert(
      0,
      OrderItem(
        id: timestamp.toString(),
        // id: (json.decode(res.body)['id']).toString(),
        amount: total,
        movies: cartmovies,
        dateTime: timestamp,
      ),
    );
    notifyListeners();
  }
}
