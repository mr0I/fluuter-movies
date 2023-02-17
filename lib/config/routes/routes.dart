import 'package:flutter/material.dart';
import '../../modules/movie/screens/movieDetail_screen.dart';
import '../../modules/movie/screens/userMovies_screen.dart';
import '../../modules/movie/screens/editMovie_screen.dart';
import '../../modules/cart/cart_screen.dart';
import '../../modules/order/orders_screen.dart';

class Routes {
  static Map<String, WidgetBuilder> get routes => {
        MovieDetailScreen.routeName: (ctx) => MovieDetailScreen(),
        CartScreen.routeName: (ctx) => CartScreen(),
        OrdersScreen.routeName: (ctx) => OrdersScreen(),
        UserMoviesScreen.routeName: (ctx) => UserMoviesScreen(),
        EditMovieScreen.routeName: (ctx) => EditMovieScreen(),
      };
}
