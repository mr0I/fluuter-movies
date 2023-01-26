import 'package:flutter/foundation.dart';

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

  void addOrder(List<CartItem> cartmovies, double total) {
    _orders.insert(
      0,
      OrderItem(
        id: DateTime.now().toString(),
        amount: total,
        movies: cartmovies,
        dateTime: DateTime.now(),
      ),
    );
    notifyListeners();
  }
}
