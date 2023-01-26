import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './modules/movie/moviesList_screen.dart';
import './modules/movie/movieDetail_screen.dart';
import './modules/cart/cart_screen.dart';
import './modules/movie/movie_provider.dart';
import './modules/cart/cart_provider.dart';
import './modules/order/order_provider.dart';
import './modules/order/orders_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => Movies(),
        ),
        ChangeNotifierProvider(
          create: (_) => Cart(),
        ),
        ChangeNotifierProvider(
          create: (_) => Orders(),
        ),
      ],
      child: MaterialApp(
        title: 'My Movies',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          accentColor: Colors.amber,
          fontFamily: 'Roboto',
        ),
        home: MoviesListScreen(),
        routes: {
          MovieDetailScreen.routeName: (ctx) => MovieDetailScreen(),
          CartScreen.routeName: (ctx) => CartScreen(),
          OrdersScreen.routeName: (ctx) => OrdersScreen(),
        },
      ),
    );
  }
}
