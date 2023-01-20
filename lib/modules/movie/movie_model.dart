import 'package:flutter/foundation.dart';

class Movie {
  final String id;
  final String title;
  final String poster;
  final String year;
  final String country;
  final String imdb_rating;
  final Object genres;
  final Object images;
  bool is_favorite;

  Movie(
      {@required this.id,
      @required this.title,
      @required this.poster,
      @required this.year,
      @required this.country,
      @required this.imdb_rating,
      @required this.genres,
      @required this.images,
      this.is_favorite = false});
}
