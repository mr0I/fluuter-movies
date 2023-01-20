import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './screens/moviesList_screen.dart';
import './screens/movieDetail_screen.dart';
import './modules/movie/movie_provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => Movies(),
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
        },
      ),
    );
  }
}
