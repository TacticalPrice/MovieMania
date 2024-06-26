part of 'search_bloc.dart';


abstract class MovieSearchEvent {}

class PerformSearch extends MovieSearchEvent {
  final String query;
  final String language;
  final String country;
  final int page;

  PerformSearch(this.language, this.country, {required this.query, required this.page});
}

class ShowFilterDialog extends MovieSearchEvent {
  final String query;
  ShowFilterDialog(this.query);
}

class ApplyFilters extends MovieSearchEvent {
  final String query;
  final String? language;
  final String? country;

  ApplyFilters(this.query, this.language , this.country,);
}

class ChangeLanguage extends MovieSearchEvent {
  final String? language;

   ChangeLanguage(this.language,);

  @override
  List<Object?> get props => [language];
}

class ChangeCountry extends MovieSearchEvent {
  final String? country;

   ChangeCountry(this.country,);

  @override
  List<Object?> get props => [country];
}

class LoadMoreResults extends MovieSearchEvent {
  final String query;
  LoadMoreResults(this.query);

   @override
  List<Object> get props => [query];
}