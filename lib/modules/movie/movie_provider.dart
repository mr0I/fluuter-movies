import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import './movie_model.dart';

class Movies with ChangeNotifier {
  List<Movie> _items = [
    Movie(
        id: '1',
        title: 'The Shawshank Redemption',
        poster: 'http:\/\/moviesapi.ir\/images\/tt0111161_poster.jpg',
        year: 1994,
        country: 'USA',
        imdbRating: '9.3',
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
        year: 1972,
        country: 'USA',
        imdbRating: '9.2',
        genres: [
          'Crime',
          'Drama'
        ],
        images: [
          'http:\/\/moviesapi.ir\/images\/tt0068646_screenshot1.jpg',
          'http:\/\/moviesapi.ir\/images\/tt0068646_screenshot2.jpg',
          'http:\/\/moviesapi.ir\/images\/tt0068646_screenshot3.jpg'
        ]),
    Movie(
        id: '3',
        title: 'The Godfather: Part II',
        poster: 'http:\/\/moviesapi.ir\/images\/tt0071562_poster.jpg',
        year: 1974,
        country: 'USA',
        imdbRating: '9.0',
        genres: [
          'Crime',
          'Drama'
        ],
        images: [
          'http:\/\/moviesapi.ir\/images\/tt0071562_screenshot1.jpg',
          'http:\/\/moviesapi.ir\/images\/tt0071562_screenshot1.jpg',
          'http:\/\/moviesapi.ir\/images\/tt0071562_screenshot1.jpg'
        ]),
    Movie(
        id: '4',
        title: 'The Dark Knight',
        poster: 'http:\/\/moviesapi.ir\/images\/tt0468569_poster.jpg',
        year: 2008,
        country: 'USA, Uk',
        imdbRating: '9.0',
        genres: [
          'Action',
          'Crime',
          'Drama'
        ],
        images: [
          'http:\/\/moviesapi.ir\/images\/tt0050083_screenshot1.jpg',
          'http:\/\/moviesapi.ir\/images\/tt0050083_screenshot2.jpg',
          'http:\/\/moviesapi.ir\/images\/tt0050083_screenshot3.jpg'
        ]),
  ];

  List<Movie> get items {
    return [..._items];
  }

  Movie findById(String id) {
    return _items.firstWhere((movie) => movie.id == id);
  }

  List<Movie> get favoriteItems {
    return _items.where((movie) => movie.isFavorite).toList();
  }

  void addMovie() {
    // _items.add('value');
    notifyListeners();
  }
}
