import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_mania/blocs/genre_bloc.dart';
import 'package:movie_mania/screens/movie_list_screen.dart';

class GenreScreen extends StatefulWidget {
  const GenreScreen({super.key});

  @override
  State<GenreScreen> createState() => _GenreScreenState();
}

class _GenreScreenState extends State<GenreScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<GenreBloc, GenreState>(
        builder: (context, state) {
          if (state is GenreLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is GenreLoaded) {
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
                              builder: (context) => MovieListScreen(
                                    genreId: genre.id,
                                  )));
                    },
                  );
                });
          } else if (state is GenreError) {
            return Center(child: Text('Failed to load genres'));
          } else {
            return Center(child: Text('Unknown state'));
          }
        },
      ),
    );
  }
}
