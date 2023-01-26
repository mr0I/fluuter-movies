import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class CartItem {
  final String id;
  final String title;
  final int quantity;
  final double price;

  CartItem({
    @required this.id,
    @required this.title,
    @required this.quantity,
    @required this.price,
  });
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  void addItem(String movieId, double price, String title) {
    if (_items.containsKey(movieId)) {
      _items.update(
          movieId,
          (oldCartItem) => CartItem(
                id: oldCartItem.id,
                title: oldCartItem.title,
                price: oldCartItem.price,
                quantity: oldCartItem.quantity + 1,
              ));
    } else {
      _items.putIfAbsent(
          movieId,
          () => CartItem(
                id: DateTime.now().toString(),
                title: title,
                price: price,
                quantity: 1,
              ));
    }
    notifyListeners();
  }

  int get itemCount {
    return _items.length;
  }

  double get totalAmount {
    var total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });

    return total;
  }

  void removeItem(String movieId) {
    _items.remove(movieId);
    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }
}
