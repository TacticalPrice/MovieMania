import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_mania/models/movie.dart';
import 'package:movie_mania/services/movie_service.dart';

abstract class MovieEvent {}

class FetchMoviesByGenre extends MovieEvent {
  final int genreId;

  FetchMoviesByGenre(this.genreId);
}

abstract class MovieState {}

class MovieInitial extends MovieState {}

class MovieLoading extends MovieState {}

class MovieLoaded extends MovieState {
  final List<Movie> movies;

  MovieLoaded(this.movies);
}

class MovieError extends MovieState {}

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final MovieService _movieService = MovieService();

  MovieBloc() : super(MovieInitial());

  @override
  Stream<MovieState> mapEventToState(MovieEvent event) async* {
    if (event is FetchMoviesByGenre) {
      yield MovieLoading();
      try {
        final token = 'YOUR_BEARER_TOKEN'; // Replace with actual token logic
        final movies = await _movieService.fetchMoviesByGenre(token, event.genreId);
        yield MovieLoaded(movies);
      } catch (_) {
        yield MovieError();
      }
    }
  }
}