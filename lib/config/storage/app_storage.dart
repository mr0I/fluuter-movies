import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../modules/movie/movie_provider.dart';
import '../../modules/cart/cart_provider.dart';
import '../../modules/order/order_provider.dart';
import '../../modules/auth/auth_provider.dart';

class AppStorage {
  static get providers => [
        ChangeNotifierProvider(create: (_) => Auth()),
        ChangeNotifierProxyProvider<Auth, Movies>(
            create: (BuildContext contextt) => Movies(
                  Provider.of<Auth>(contextt, listen: false).token,
                  [],
                ),
            update: (ctx, auth, oldMovies) =>
                Movies(auth.token, oldMovies != null ? oldMovies.items : [])),
        ChangeNotifierProvider(create: (_) => Cart()),
        ChangeNotifierProvider(create: (_) => Orders()),
      ];
}
