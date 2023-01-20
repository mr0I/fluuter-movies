import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../screens/movieDetail_screen.dart';
import '../movie/movie_model.dart';

class MovieItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final movie = Provider.of<Movie>(context, listen: false);
    // print('fav: ${movie.isFavorite}');

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context)
                .pushNamed(MovieDetailScreen.routeName, arguments: movie.id);
            // Navigator.of(context).push(
            //   MaterialPageRoute(
            //     builder: (ctx) => MovieDetailScreen(title),
            //   ),
            // );
          },
          child: Image.network(
            movie.poster,
            fit: BoxFit.cover,
          ),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black54,
          leading: Consumer<Movie>(
            builder: (ctx, movie, child) => IconButton(
              icon: Icon(
                movie.isFavorite ? Icons.favorite : Icons.favorite_border,
              ),
              // label: child,
              color: Theme.of(context).accentColor,
              onPressed: () {
                movie.toggleFavoriteStatus();
              },
            ),
            // child: Text('never changes!'),
          ),
          title: Text(
            movie.title,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
