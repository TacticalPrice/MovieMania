import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_mania/models/genre.dart';
import 'package:movie_mania/services/genre_service.dart';

abstract class GenreEvent{}

class FetchGenres extends GenreEvent {}

abstract class GenreState {}

class GenreInitial extends GenreState {}

class GenreLoading extends GenreState {}

class GenreLoaded extends GenreState {
  final List<Genre> genres;

  GenreLoaded(this.genres);
}

class GenreError extends GenreState {}

class GenreBloc extends Bloc<GenreEvent , GenreState> {
  final GenreService _genreService = GenreService();

  GenreBloc() : super(GenreInitial());

  @override 
  Stream<GenreState> mapEventToState(GenreEvent event) async* {
    if(event is FetchGenres){
      yield GenreLoading();
      try{
        final token = 'YOUR_BEARER_TOKEN';
        final genres = await _genreService.fetchingGenres(token);
        yield GenreLoaded(genres);
      }catch(_){
        yield GenreError();
      }
    }
  }
  
}
