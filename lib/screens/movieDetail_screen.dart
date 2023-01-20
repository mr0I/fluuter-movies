import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../modules/movie/movie_provider.dart';

class MovieDetailScreen extends StatelessWidget {
  static const routeName = '/movie-detail';

  @override
  Widget build(BuildContext context) {
    final movieId = ModalRoute.of(context).settings.arguments as String;
    final loadedMovie =
        Provider.of<Movies>(context, listen: false).findById(movieId);

    return Scaffold(
      appBar: AppBar(
        title: Text(loadedMovie.title),
      ),
    );
  }
}
