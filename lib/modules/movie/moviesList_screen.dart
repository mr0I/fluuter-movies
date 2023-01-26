import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'movieItem_widget.dart';
import 'movie_provider.dart';
import '../../widgets/badge.dart';
import '../cart/cart_provider.dart';
import '../cart/cart_screen.dart';
import '../../widgets/appDrawer.dart';

enum FilterOptions { Favorites, All }

class MoviesListScreen extends StatefulWidget {
  @override
  _MoviesListScreenState createState() => _MoviesListScreenState();
}

class _MoviesListScreenState extends State<MoviesListScreen> {
  var _showFavoritesOnly = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Movies List'),
        actions: <Widget>[
          PopupMenuButton(
            itemBuilder: (_) => [
              PopupMenuItem(
                  child: Text('فیلم های موردعلاقه'),
                  value: FilterOptions.Favorites),
              PopupMenuItem(
                  child: Text('همه فیلم ها'), value: FilterOptions.All),
            ],
            icon: Icon(Icons.more_vert),
            onSelected: (FilterOptions selectedValue) {
              setState(() {
                if (selectedValue == FilterOptions.Favorites)
                  _showFavoritesOnly = true;
                else
                  _showFavoritesOnly = false;
              });
            },
          ),
          Consumer<Cart>(
            builder: (_, cart, ch) => Badge(
              value: cart.itemCount.toString(),
              child: ch,
            ),
            child: IconButton(
                icon: Icon(Icons.shopping_bag),
                onPressed: () {
                  Navigator.of(context).pushNamed(CartScreen.routeName);
                }),
          )
        ],
      ),
      drawer: AppDrawer(),
      body: MoviesGrid(_showFavoritesOnly),
    );
  }
}

class MoviesGrid extends StatelessWidget {
  final bool showFavorites;

  MoviesGrid(this.showFavorites);

  @override
  Widget build(BuildContext context) {
    final moviesObj = Provider.of<Movies>(context);
    final movies = showFavorites ? moviesObj.favoriteItems : moviesObj.items;

    return GridView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: movies.length,
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
        value: movies[i],
        child: MovieItem(),
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10),
    );
  }
}
