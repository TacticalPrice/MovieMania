import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_mania/blocs/favorite/favorite_bloc.dart';
import 'package:movie_mania/blocs/favorite/favorite_state.dart';
import 'package:movie_mania/widgets/movie_item.dart';

class FavoritesScreen extends StatefulWidget {
  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  late FavoritesBloc _favoritesBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _favoritesBloc = FavoritesBloc();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite Movies'),
      ),
      body: BlocProvider(
        create: (context) => _favoritesBloc,
        child: BlocBuilder<FavoritesBloc, FavoritesState>(
          builder: (context, state) {
            if (state.favorites.isEmpty) {
              return Center(
                child: Text('No favorite movies added.'),
              );
            }

            return ListView.builder(
              itemCount: state.favorites.length,
              itemBuilder: (context, index) {
                final movie = state.favorites[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 100,
                    child: Row(
                      children: [
                        Image.network(movie['image']),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(movie['name']),
                            Text(movie['year']),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
