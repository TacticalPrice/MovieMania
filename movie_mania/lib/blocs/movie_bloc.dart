import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_mania/models/genre.dart';
import 'package:movie_mania/models/movie.dart';
import 'package:movie_mania/services/movie_service.dart';

abstract class MovieEvent {}

class FetchGenres extends MovieEvent {
}

class FetchMoviesByGenre extends MovieEvent {
  final int genreId;

  FetchMoviesByGenre(this.genreId);
}

class SearchMovies extends MovieEvent {
  final String query;
  final String? language;
  final String? country;

  SearchMovies(this.query, {this.language, this.country});
}

abstract class MovieState {}

class MovieInitial extends MovieState {}

class MovieLoading extends MovieState {}

class GenresLoaded extends MovieState {
  final List<Genre> genres;

  GenresLoaded(this.genres);
}

class MovieLoaded extends MovieState {
  final List<Movie> movies;

  MovieLoaded(this.movies);
}

class MovieError extends MovieState {
  final String message;

  MovieError(this.message);

  @override 
  String toString() => 'MovieErro : $message';
}

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final MovieService _movieService = MovieService();

  MovieBloc() : super(MovieInitial()){
    on<FetchGenres>(_onFetchGenres);
    on<FetchMoviesByGenre>(_onFetchMoviesByGenre);
    on<SearchMovies>(_onSearchMovies);
  }

  void _onFetchGenres(FetchGenres event , Emitter<MovieState>emit) async{
    emit(MovieLoading());
    try{
      final genres = await _movieService.fetchGenres();
      emit(GenresLoaded(genres));
    }catch(e){
      emit(MovieError(e.toString()));
    }
  }

  void _onFetchMoviesByGenre(FetchMoviesByGenre event, Emitter<MovieState> emit) async {
    emit(MovieLoading());
    try {
      final movies = await _movieService.fetchMoviesByGenre(event.genreId);
      emit(MovieLoaded(movies));
    } catch (e) {
      emit(MovieError(e.toString()));
    }
  }

  void _onSearchMovies(SearchMovies event, Emitter<MovieState> emit) async {
    emit(MovieLoading());
    try {
      final movies = await _movieService.searchMovies(
        event.query,
        language: event.language,
        country: event.country,
      );
      emit(MovieLoaded(movies));
    } catch (e) {
      emit(MovieError(e.toString()));
    }
  }


}