import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_mania/blocs/genre_bloc.dart';
import 'package:movie_mania/screens/genres_movie_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GenreBloc()..add(FetchGenres()),
      child: Scaffold(
        appBar: AppBar(
          title: Text('GenreFlicks'),
        ),
        body: BlocBuilder<GenreBloc, GenreState>(
          builder: (context, state) {
            if (state is GenreLoading) {
              return Center(child: CircularProgressIndicator());
            }
            if (state is GenreLoaded) {
              return ListView.builder(
                itemCount: state.genres.length,
                itemBuilder: (context, index) {
                  final genre = state.genres[index];
                  return ListTile(
                    title: Text(genre.name),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => GenreMoviesScreen(genre: genre),
                        ),
                      );
                    },
                  );
                },
              );
            }
            return Center(child: Text('Failed to load genres'));
          },
        ),
      ),
    );
  }
}
