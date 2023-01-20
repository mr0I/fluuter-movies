import 'package:flutter/material.dart';
import '../modules/movie/movie_model.dart';
import '../modules/movie/movieItem_widget.dart';

class MoviesListScreen extends StatelessWidget {
  final List<Movie> loadedMovies = [
    Movie(
        id: '1',
        title: 'The Shawshank Redemption',
        poster: 'http:\/\/moviesapi.ir\/images\/tt0111161_poster.jpg',
        year: '1994',
        country: 'USA',
        imdb_rating: '9.3',
        genres: [
          'Crime',
          'Drama'
        ],
        images: [
          'http:\/\/moviesapi.ir\/images\/tt0111161_screenshot1.jpg',
          'http:\/\/moviesapi.ir\/images\/tt0111161_screenshot2.jpg',
          'http:\/\/moviesapi.ir\/images\/tt0111161_screenshot3.jpg'
        ]),
    Movie(
        id: '2',
        title: 'The Godfather',
        poster: 'http:\/\/moviesapi.ir\/images\/tt0068646_poster.jpg',
        year: '1972',
        country: 'USA',
        imdb_rating: '9.2',
        genres: [
          'Crime',
          'Drama'
        ],
        images: [
          'http:\/\/moviesapi.ir\/images\/tt0068646_screenshot1.jpg',
          'http:\/\/moviesapi.ir\/images\/tt0068646_screenshot2.jpg',
          'http:\/\/moviesapi.ir\/images\/tt0068646_screenshot3.jpg'
        ]),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Movies List'),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: loadedMovies.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10),
        itemBuilder: (ctx, i) => MovieItem(
            loadedMovies[i].id, loadedMovies[i].title, loadedMovies[i].poster),
      ),
    );
  }
}
