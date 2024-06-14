import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_mania/services/genre_service.dart'; // Replace with actual service
import 'package:movie_mania/models/genre.dart'; // Replace with actual model

// Define GenreEvent
abstract class GenreEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchGenres extends GenreEvent {

  @override
  List<Object?> get props => [];
}

// Define GenreState
abstract class GenreState extends Equatable {
  @override
  List<Object?> get props => [];
}

class GenreInitial extends GenreState {}

class GenreLoading extends GenreState {}

class GenreLoaded extends GenreState {
  final List<Genre> genres;

  GenreLoaded(this.genres);

  @override
  List<Object?> get props => [genres];
}

class GenreError extends GenreState {
  final String message;

  GenreError(this.message);

  @override
  List<Object?> get props => [message];
}

// Define GenreBloc
class GenreBloc extends Bloc<GenreEvent, GenreState> {
  GenreBloc() : super(GenreInitial()){
    on<FetchGenres>(_onFetchGenres);
  }

  void _onFetchGenres(FetchGenres event , Emitter<GenreState> emit) async{
    emit(GenreLoading());
    try{
      List<Genre> genres = await GenreService().fetchingGenres();
      print(genres);
      emit(GenreLoaded(genres));
    }catch(e){
      emit(GenreError(e.toString()));
    }
  }
  
}
