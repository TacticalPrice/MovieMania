part of 'search_bloc.dart';


abstract class MovieSearchEvent {}

class PerformSearch extends MovieSearchEvent {
  final String query;

  PerformSearch(this.query);
}

class ShowFilterDialog extends MovieSearchEvent {}

class ApplyFilters extends MovieSearchEvent {
  final String? language;
  final String? country;

  ApplyFilters({this.language , this.country});
}

class ChangeLanguage extends MovieSearchEvent {
  final String? language;

   ChangeLanguage(this.language);

  @override
  List<Object?> get props => [language];
}

class ChangeCountry extends MovieSearchEvent {
  final String? country;

   ChangeCountry(this.country);

  @override
  List<Object?> get props => [country];
}

class LoadMoreResults extends MovieSearchEvent {}