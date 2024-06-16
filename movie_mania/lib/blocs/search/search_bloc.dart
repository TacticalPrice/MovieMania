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
        selectedLanguage ?? '',
        selectedCountry ?? '',
        0,
        10,);
      emit(MovieSearchLoaded(searchResult, event.query, searchResult.isEmpty));
    } catch (e) {
      emit(MovieSearchError(message: e.toString()));
      print(e.toString());
    }
  }

  void _onShowFilterDialog(
      ShowFilterDialog event, Emitter<MovieSearchState> emit) {
    emit(MovieSearchShowFilterDialog(event.query, selectedLanguage, selectedCountry));
  }

  void _onApplyFilters(
      ApplyFilters event, Emitter<MovieSearchState> emit) async {
    selectedLanguage = event.language;
    selectedCountry = event.country;
    emit(MovieSearchLoading());

    try {
      final searchResult = await movieService.searchMovies(event.query,
        selectedLanguage ?? '',
        selectedCountry ?? '',
        0,
        10,);
      emit(MovieSearchLoaded(searchResult, event.query,searchResult.isEmpty));
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
    try {
      final int nextPage = currentPage +1;
      final newSearchResult = await movieService.searchMovies(
        event.query,
        selectedLanguage ?? '',
        selectedCountry ?? '',
        nextPage*10,
        30,
      );

      if (newSearchResult.isEmpty) {
        hasReachedEnd = true;
      }else{
        currentPage = nextPage;
      

      if (state is MovieSearchLoaded) {
        final currentState = state as MovieSearchLoaded;
        final List<dynamic> updatedResults = List.from(currentState.searchResult)..addAll(newSearchResult);
        final uniqueResults = updatedResults.toSet().toList();

         if (updatedResults == uniqueResults) {
          hasReachedEnd = true;
          emit(MovieSearchLoaded([], event.query, true)); // Empty result example
        } else {
          emit(MovieSearchLoaded(uniqueResults, event.query, hasReachedEnd));
        }
      }
      }
    } catch (e) {
      emit(MovieSearchError(message: e.toString()));
      print(e.toString());
    }
    isLoadingMore = false;
  }

  }

