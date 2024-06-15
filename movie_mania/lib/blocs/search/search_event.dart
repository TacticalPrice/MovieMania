part of 'search_bloc.dart';


abstract class MovieSearchEvent {}

class PerformSearch extends MovieSearchEvent {
  final String query;

  PerformSearch(this.query);
}