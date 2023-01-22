import 'package:flutter/foundation.dart';

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
    @required this.country,
    @required this.imdbRating,
    @required this.genres,
    @required this.images,
    this.isFavorite = false,
  });

  void toggleFavoriteStatus() {
    isFavorite = !isFavorite;
    notifyListeners();
  }
}
