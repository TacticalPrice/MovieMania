import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_mania/blocs/movie_detail/movie_detail_event.dart';
import 'package:movie_mania/blocs/movie_detail/movie_detail_state.dart';
import 'package:movie_mania/services/movie_service.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent , MovieDetailState>{
  final MovieService movieService;
  MovieDetailBloc({required this.movieService}) : super(MovieDetailInitial()){
    on<FetchMovieDetail>(_onFetchMovieDetail);
  }

  void _onFetchMovieDetail(FetchMovieDetail event , Emitter<MovieDetailState> emit) async {
    emit(MovieDetailLoading());
    try{
      final movieDetail = await movieService.movieDetail(event.movieId);
      emit(MovieDetailLoaded(movieDetail: movieDetail));
    }catch(e){
      emit(MovieDetailError(e.toString()));
    }
  }
  
}