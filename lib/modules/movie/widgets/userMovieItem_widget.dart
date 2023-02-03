import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../movie/screens/editMovie_screen.dart';
import '../../movie/movie_provider.dart';

class UserMovieItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;

  UserMovieItem(this.id, this.title, this.imageUrl);

  @override
  Widget build(BuildContext context) {
    final scaffold = Scaffold.of(context);
    return ListTile(
      title: Text(title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageUrl),
      ),
      trailing: Container(
        width: 100,
        child: Row(
          children: <Widget>[
            IconButton(
                icon: Icon(Icons.edit),
                color: Theme.of(context).primaryColor,
                onPressed: () {
                  Navigator.of(context).pushNamed(
                    EditMovieScreen.routeName,
                    arguments: id,
                  );
                }),
            IconButton(
                icon: Icon(Icons.delete),
                color: Theme.of(context).errorColor,
                onPressed: () async {
                  try {
                    await Provider.of<Movies>(context, listen: false)
                        .deleteMovie(id);
                  } catch (e) {
                    // ignore: deprecated_member_use
                    scaffold.showSnackBar(
                      SnackBar(
                        content: Text('Deleting failed!'),
                      ),
                    );
                  }
                }),
          ],
        ),
      ),
    );
  }
}
