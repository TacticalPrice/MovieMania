import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_mania/models/movie.dart';
import 'package:movie_mania/models/search.dart';
import 'package:movie_mania/services/movie_service.dart';

part 'search_event.dart';
part 'search_state.dart';

class MovieSearchBloc extends Bloc<MovieSearchEvent, MovieSearchState> {
  final MovieService movieService;
  String? selectedLanguage;
  String? selectedCountry;
  String? currentQuery = '';
  int currentPage = 0;
  bool isLoadingMore = false;
  bool hasReachedEnd = false;

  MovieSearchBloc({required this.movieService}) : super(MovieStartInitial()) {
    on<PerformSearch>(_onPerformSearch);
    on<ShowFilterDialog>(_onShowFilterDialog);
    on<ApplyFilters>(_onApplyFilters);
    on<ChangeLanguage>(_onChangeLanguage);
    on<ChangeCountry>(_onChangeCountry);
    on<LoadMoreResults>(_onLoadMoreResults);
  }

  void _onPerformSearch(
      PerformSearch event, Emitter<MovieSearchState> emit) async {
    emit(MovieSearchLoading());
    try {
      final searchResult = await movieService.searchMovies( event.query,
        selectedLanguage!,
        selectedCountry!,
        0,
        10,);
      emit(MovieSearchLoaded(searchResult, event.query, hasReachedEnd));
    } catch (e) {
      emit(MovieSearchError(message: e.toString()));
      print(e.toString());
    }
  }

  void _onShowFilterDialog(
      ShowFilterDialog event, Emitter<MovieSearchState> emit) {
    emit(MovieSearchShowFilterDialog());
  }

  void _onApplyFilters(
      ApplyFilters event, Emitter<MovieSearchState> emit) async {
    selectedLanguage = event.language;
    selectedCountry = event.country;
    emit(MovieSearchLoading());

    try {
      final searchResult = await movieService.searchMovies(currentQuery!,
        selectedLanguage!,
        selectedCountry!,
        0,
        10,);
      emit(MovieSearchLoaded(searchResult, '',hasReachedEnd));
    } catch (e) {
      emit(MovieSearchError(message: e.toString()));
    }
  }

  void _onChangeLanguage(ChangeLanguage event, Emitter<MovieSearchState> emit) {
    selectedLanguage = event.language;
  }

  void _onChangeCountry(ChangeCountry event, Emitter<MovieSearchState> emit) {
    selectedCountry = event.country;
  }

  void _onLoadMoreResults(LoadMoreResults event , Emitter<MovieSearchState> emit) async {
   if (isLoadingMore || hasReachedEnd) return;

    isLoadingMore = true;
    currentPage += 10;
    try {
      final searchResult = await movieService.searchMovies(
        currentQuery!,
        selectedLanguage!,
        selectedCountry!,
        currentPage,
         10,
      );

      if (searchResult.isEmpty) {
        hasReachedEnd = true;
      }

      if (state is MovieSearchLoaded) {
        final currentState = state as MovieSearchLoaded;
        final List<SearchResult> updatedResults = List.from(currentState.searchResult)..addAll(searchResult);
        emit(MovieSearchLoaded(updatedResults, currentQuery!,hasReachedEnd));
      }
    } catch (e) {
      emit(MovieSearchError(message: e.toString()));
      print(e.toString());
    }
    isLoadingMore = false;
  }

  }

