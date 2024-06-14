import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_mania/blocs/movie_bloc.dart';
import 'package:movie_mania/models/genre.dart';
import 'package:movie_mania/screens/movie_detail_screen.dart';

class GenreMoviesScreen extends StatelessWidget {
  final Genre genre;

  GenreMoviesScreen({required this.genre});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MovieBloc()..add(FetchMoviesByGenre(genre.id)),
      child: Scaffold(
        appBar: AppBar(
          title: Text(genre.name),
        ),
        body: BlocBuilder<MovieBloc, MovieState>(
          builder: (context, state) {
            if (state is MovieLoading) {
              return Center(child: CircularProgressIndicator());
            }
            if (state is MovieLoaded) {
              return ListView.builder(
                itemCount: state.movies.length,
                itemBuilder: (context, index) {
                  final movie = state.movies[index];
                  return ListTile(
                    title: Text(movie.title),
                    leading: CachedNetworkImage(
                      imageUrl: movie.poster,
                      width: 50,
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MovieDetailScreen(movie: movie),
                        ),
                      );
                    },
                  );
                },
              );
            }
            return Center(child: Text('Failed to load movies'));
          },
        ),
      ),
    );
  }
}
