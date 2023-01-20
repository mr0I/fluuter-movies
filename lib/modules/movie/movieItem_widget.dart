import 'package:flutter/material.dart';
import '../../screens/movieDetail_screen.dart';

class MovieItem extends StatelessWidget {
  final String id;
  final String title;
  final String poster;

  MovieItem(
    this.id,
    this.title,
    this.poster,
  );

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context)
                .pushNamed(MovieDetailScreen.routeName, arguments: id);
            // Navigator.of(context).push(
            //   MaterialPageRoute(
            //     builder: (ctx) => MovieDetailScreen(title),
            //   ),
            // );
          },
          child: Image.network(
            poster,
            fit: BoxFit.cover,
          ),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black54,
          leading: IconButton(
            icon: Icon(Icons.favorite),
            color: Theme.of(context).accentColor,
            onPressed: () {},
          ),
          title: Text(
            title,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
