abstract class DataState {}

class DataInitial extends DataState {}

class LanguageLoading extends DataState {}
class CountriesLoading extends DataState {}

class LanguagesLoaded extends DataState {
  final List<dynamic> languages;

  LanguagesLoaded(this.languages);
}

class CountriesLoaded extends DataState {
  final List<dynamic> countries;

  CountriesLoaded(this.countries);
}

class DataError extends DataState {
  final String error;

  DataError(this.error);
}