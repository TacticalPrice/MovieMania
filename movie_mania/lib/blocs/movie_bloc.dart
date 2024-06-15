import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_mania/models/movie.dart';
import 'package:movie_mania/services/movie_service.dart';

abstract class MovieEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchMovies extends MovieEvent {
  final int page;

  FetchMovies({this.page = 1});
  @override
  List<Object> get props => [page];
}

class FetchMoviesByGenre extends MovieEvent {
  final int page;
  final int genreId;

  FetchMoviesByGenre(this.genreId, this.page);

  @override
  List<Object?> get props => [genreId];
}

abstract class MovieState extends Equatable {
  @override
  List<Object?> get props => [];
}

class MovieInitial extends MovieState {}

class MovieLoading extends MovieState {}

class MovieLoaded extends MovieState {
  final List<dynamic> movies;
  final bool hasReachedMax;
  MovieLoaded({required this.movies, required, this.hasReachedMax = false});

  MovieLoaded copyWith({
    List<dynamic>? movies,
    bool? hasReachedMax,
  }) {
    return MovieLoaded(
      movies: movies ?? this.movies,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object?> get props => [movies, hasReachedMax];
}

class MovieError extends MovieState {
  final String message;
  MovieError(this.message);

  @override
  List<Object?> get props => [message];
}

class NavigateToMovieDetail extends MovieEvent {
  final int movieId;

  NavigateToMovieDetail({required this.movieId});

  @override
  List<Object?> get props => [movieId];
}

class MovieNavigateToDetail extends MovieState {
  final int movieId;

  MovieNavigateToDetail({required this.movieId});
}

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final MovieService movieService;

  MovieBloc({required this.movieService}) : super(MovieInitial()) {
    on<FetchMovies>(_onFetchMovies);
    on<FetchMoviesByGenre>(_onFetchMoviesByGenre);
    on<NavigateToMovieDetail>(_onNavigateToMovieDetail);
  }

  void _onFetchMovies(FetchMovies event, Emitter<MovieState> emit) async {
    final currentState = state;
    if (currentState is MovieLoaded && currentState.hasReachedMax) return;

    try {
      if (currentState is MovieInitial || currentState is MovieLoading) {
        final movies = await movieService.fetchAllMovies(page: event.page);
        emit(MovieLoaded(movies: movies, hasReachedMax: movies.isEmpty));
      } else if (currentState is MovieLoaded) {
        final movies = await movieService.fetchAllMovies(page: event.page);
        emit(movies.isEmpty
            ? currentState.copyWith(hasReachedMax: true)
            : MovieLoaded(
                movies: currentState.movies + movies,
                hasReachedMax: false,
              ));
      }
    } catch (e) {
      emit(MovieError(e.toString()));
    }
  }

  void _onFetchMoviesByGenre(
      FetchMoviesByGenre event, Emitter<MovieState> emit) async {
    emit(MovieLoading());

    try {
      final movies = await movieService.fetchMoviesByGenre(event.genreId,
          page: event.page);
      emit(MovieLoaded(movies: movies, hasReachedMax: movies.isEmpty));
    } catch (e) {
      emit(MovieError(e.toString()));
    }
  }

  void _onNavigateToMovieDetail(
      NavigateToMovieDetail event, Emitter<MovieState> emit) {
    try {
      emit(MovieNavigateToDetail(movieId: event.movieId));
    } catch (e) {
      print(e);
      emit(MovieError('Failed to navigate to movie detail: $e'));
    }
  }
}
