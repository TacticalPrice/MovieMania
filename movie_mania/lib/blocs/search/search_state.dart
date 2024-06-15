part of 'search_bloc.dart';


abstract class MovieSearchState {}

class MovieStartInitial extends MovieSearchState {}

class MovieSearchLoading extends MovieSearchState {}

class MovieSearchLoaded extends MovieSearchState {
  final List<SearchResult> searchResult;

  MovieSearchLoaded(this.searchResult);

}

class MovieSearchError extends MovieSearchState {
  final String message;

  MovieSearchError({required this.message});

}