part of 'search_bloc.dart';


abstract class MovieSearchState {}

class MovieStartInitial extends MovieSearchState {}

class MovieSearchLoading extends MovieSearchState {}

class MovieSearchLoaded extends MovieSearchState {
  final List<dynamic> searchResult;
  final String query;
  final bool hasReachedEnd;

  MovieSearchLoaded(this.searchResult, this.query, this.hasReachedEnd);

}

class MovieSearchError extends MovieSearchState {
  final String message;

  MovieSearchError({required this.message});

}

class MovieSearchShowFilterDialog extends MovieSearchState {
  final String query;
  final String? language;
  final String? country;

  MovieSearchShowFilterDialog(this.query, this.language, this.country);
}