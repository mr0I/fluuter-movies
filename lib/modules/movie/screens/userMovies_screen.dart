import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../movie/movie_provider.dart';
import '../../movie/widgets/userMovieItem_widget.dart';
import '../../../widgets/appDrawer.dart';
import '../../movie/screens/editMovie_screen.dart';

class UserMoviesScreen extends StatelessWidget {
  static const routeName = '/user-movies';

  Future<void> _refreshMovies(BuildContext context) async {
    await Provider.of<Movies>(context, listen: false).fetchMovies();
  }

  @override
  Widget build(BuildContext context) {
    final moviesObj = Provider.of<Movies>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your movies'),
        actions: <Widget>[
          IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                Navigator.of(context).pushNamed(EditMovieScreen.routeName);
              })
        ],
      ),
      drawer: AppDrawer(),
      body: RefreshIndicator(
        onRefresh: () => _refreshMovies(context),
        child: Padding(
            padding: EdgeInsets.all(10),
            child: ListView.builder(
              itemBuilder: (_, i) => Column(
                children: [
                  UserMovieItem(
                    moviesObj.items[i].id,
                    moviesObj.items[i].title,
                    moviesObj.items[i].poster,
                  ),
                  Divider(),
                ],
              ),
              itemCount: moviesObj.items.length,
            )),
      ),
    );
  }
}
