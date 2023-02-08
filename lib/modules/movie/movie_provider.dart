import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Movie with ChangeNotifier {
  final String id;
  final String title;
  final String poster;
  final double year;
  final String country;
  final String imdbRating;
  final Object genres;
  final Object images;
  bool isFavorite;

  Movie({
    @required this.id,
    @required this.title,
    @required this.poster,
    @required this.year,
    this.country = '',
    this.imdbRating = '',
    this.genres,
    this.images,
    this.isFavorite = false,
  });

  Map<String, dynamic> toJson() => {
        'title': title,
        'poster': poster,
        'year': year,
      };

  _setFavValue(bool newValue) {
    isFavorite = newValue;
    notifyListeners();
  }

  Future<void> toggleFavoriteStatus() async {
    final oldStatus = isFavorite;
    isFavorite = !isFavorite;
    notifyListeners();

    // final url = Uri.http('moviesapi.ir', '/api/v1/movies');
    // try {
    //   final res = await http.patch(
    //     url,
    //     body: json.encode({'isFavorite': isFavorite}),
    //   );
    //   if (res.statusCode >= 400) _setFavValue(oldStatus);
    // } catch (e) {
    //   _setFavValue(oldStatus);
    // }
  }
}

class Movies with ChangeNotifier {
  List<Movie> _items = [
    // Movie(
    //     id: '1',
    //     title: 'The Shawshank Redemption',
    //     poster: 'http:\/\/moviesapi.ir\/images\/tt0111161_poster.jpg',
    //     year: 1994,
    //     country: 'USA',
    //     imdbRating: '9.3',
    //     genres: [
    //       'Crime',
    //       'Drama'
    //     ],
    //     images: [
    //       'http:\/\/moviesapi.ir\/images\/tt0111161_screenshot1.jpg',
    //       'http:\/\/moviesapi.ir\/images\/tt0111161_screenshot2.jpg',
    //       'http:\/\/moviesapi.ir\/images\/tt0111161_screenshot3.jpg'
    //     ]),
    // Movie(
    //     id: '2',
    //     title: 'The Godfather',
    //     poster: 'http:\/\/moviesapi.ir\/images\/tt0068646_poster.jpg',
    //     year: 1972,
    //     country: 'USA',
    //     imdbRating: '9.2',
    //     genres: [
    //       'Crime',
    //       'Drama'
    //     ],
    //     images: [
    //       'http:\/\/moviesapi.ir\/images\/tt0068646_screenshot1.jpg',
    //       'http:\/\/moviesapi.ir\/images\/tt0068646_screenshot2.jpg',
    //       'http:\/\/moviesapi.ir\/images\/tt0068646_screenshot3.jpg'
    //     ]),
    // Movie(
    //     id: '3',
    //     title: 'The Godfather: Part II',
    //     poster: 'http:\/\/moviesapi.ir\/images\/tt0071562_poster.jpg',
    //     year: 1974,
    //     country: 'USA',
    //     imdbRating: '9.0',
    //     genres: [
    //       'Crime',
    //       'Drama'
    //     ],
    //     images: [
    //       'http:\/\/moviesapi.ir\/images\/tt0071562_screenshot1.jpg',
    //       'http:\/\/moviesapi.ir\/images\/tt0071562_screenshot1.jpg',
    //       'http:\/\/moviesapi.ir\/images\/tt0071562_screenshot1.jpg'
    //     ]),
    // Movie(
    //     id: '4',
    //     title: 'The Dark Knight',
    //     poster: 'http:\/\/moviesapi.ir\/images\/tt0468569_poster.jpg',
    //     year: 2008,
    //     country: 'USA, Uk',
    //     imdbRating: '9.0',
    //     genres: [
    //       'Action',
    //       'Crime',
    //       'Drama'
    //     ],
    //     images: [
    //       'http:\/\/moviesapi.ir\/images\/tt0050083_screenshot1.jpg',
    //       'http:\/\/moviesapi.ir\/images\/tt0050083_screenshot2.jpg',
    //       'http:\/\/moviesapi.ir\/images\/tt0050083_screenshot3.jpg'
    //     ]),
  ];

  final String authToken;

  Movies(this.authToken, this._items);

  List<Movie> get items {
    return [..._items];
  }

  Movie findById(String id) {
    return _items.firstWhere((movie) => movie.id == id);
  }

  List<Movie> get favoriteItems {
    return _items.where((movie) => movie.isFavorite).toList();
  }

  Future<void> addMovie(Movie movie) async {
    final url = Uri.http('moviesapi.ir', '/api/v1/movies');

    try {
      final response = await http.post(url,
          body: json.encode({
            'title': movie.title,
            'imdb_id': '1000',
            'country': 'US',
            'year': movie.year.toInt(),
            'poster': movie.poster
          }));
      final newMovie = Movie(
        id: (json.decode(response.body)['id']).toString(),
        title: movie.title,
        poster: movie.poster,
        year: movie.year,
      );
      _items.add(newMovie);
      // _items.insert(0, newMovie);
      notifyListeners();
    } catch (error) {
      print('Error: $error');
      throw (error);
    }
  }

  Future<void> fetchMovies() async {
    final url = Uri.http('moviesapi.ir', '/api/v1/movies');

    try {
      final response = await http
          .get(url, headers: {'Authorization': 'Bearer ' + authToken});

      final loadedData = json.decode(response.body) as Map<String, dynamic>;
      if (loadedData == null) return;
      final data = loadedData['data'];
      final List<Movie> loadedMovies = [];
      data.forEach((value) {
        loadedMovies.add(Movie(
          id: value['id'].toString(),
          title: value['title'],
          poster: value['poster'],
          year: double.parse(value['year']),
          isFavorite: false,
        ));
      });
      _items = loadedMovies;
      notifyListeners();
    } catch (e) {
      throw (e);
    }
  }

  Future<void> updateMovie(String id, Movie newMovie) async {
    final movieIndex = _items.indexWhere((movie) => movie.id == id);

    if (movieIndex >= 0) {
      // final url = Uri.http('moviesapi.ir', '/api/v1/movies');
      // try {
      //   await http.patch(url,
      //       body: json.encode({
      //         'title': newMovie.title,
      //         'imdb_id': '1000',
      //         'country': 'US',
      //         'year': newMovie.year.toInt(),
      //         'poster': newMovie.poster
      //       }));
      // } catch (error) {
      //   print('Error: $error');
      //   throw (error);
      // }
      _items[movieIndex] = newMovie;
      notifyListeners();
    } else {
      print('Error');
    }
  }

  Future<void> deleteMovie(String id) async {
    final existingMovieIndex = _items.indexWhere((movie) => movie.id == id);
    //var existingMovie = _items[existingMovieIndex];
    _items.removeAt(existingMovieIndex);
    notifyListeners();

    // final url = Uri.http('moviesapi.ir', '/api/v1/movies');
    // final res = await http.delete(url);
    // if (res.statusCode >= 400) {
    //   _items.insert(existingMovieIndex, existingMovie);
    //   notifyListeners();
    //   throw HttpException('Error in deleting!');
    // }
    // existingMovie = null;
  }
}
