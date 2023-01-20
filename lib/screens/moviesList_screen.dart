import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../modules/movie/movieItem_widget.dart';
import '../modules/movie/movie_provider.dart';

class MoviesListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Movies List'),
      ),
      body: MoviesGrid(),
    );
  }
}

class MoviesGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final movies = (Provider.of<Movies>(context)).items;

    return GridView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: movies.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10),
      itemBuilder: (ctx, i) =>
          MovieItem(movies[i].id, movies[i].title, movies[i].poster),
    );
  }
}
