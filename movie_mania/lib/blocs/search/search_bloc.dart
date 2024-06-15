import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_mania/models/movie.dart';
import 'package:movie_mania/models/search.dart';
import 'package:movie_mania/services/movie_service.dart';

part 'search_event.dart';
part 'search_state.dart';

class MovieSearchBloc extends Bloc<MovieSearchEvent , MovieSearchState>{
  final MovieService movieService;

  MovieSearchBloc({required this.movieService}) : super(MovieStartInitial()){
    on<PerformSearch>(_onPerformSearch);
  }

  void _onPerformSearch(PerformSearch event , Emitter<MovieSearchState> emit) async{
    emit(MovieSearchLoading());
    try{
      final searchResult = await movieService.searchMovies(event.query);
      emit(MovieSearchLoaded(searchResult));
    }catch(e){
      emit(MovieSearchError(message: e.toString()));
      print(e.toString());
    }

  }  
}