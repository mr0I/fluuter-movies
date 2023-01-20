import 'package:flutter/material.dart';

class MovieDetailScreen extends StatelessWidget {
  // final String title;

  // MovieDetailScreen(this.title);

  static const routeName = '/movie-detail';

  @override
  Widget build(BuildContext context) {
    final movieId = ModalRoute.of(context).settings.arguments as String;

    return Scaffold(
      appBar: AppBar(
        title: Text('title'),
      ),
    );
  }
}
