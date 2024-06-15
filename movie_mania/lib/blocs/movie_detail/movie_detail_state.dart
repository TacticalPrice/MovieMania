import 'package:equatable/equatable.dart';
import 'package:movie_mania/models/movie_detail.dart';

abstract class MovieDetailState extends Equatable {
  @override 
  List<Object?> get props => [];
}

class MovieDetailInitial extends MovieDetailState {}

class MovieDetailLoading extends MovieDetailState {}

class MovieDetailLoaded extends MovieDetailState {
  final MovieDetail movieDetail;

  MovieDetailLoaded({required this.movieDetail});

  @override 
  List<Object?>get props => [movieDetail];
}

class MovieDetailError extends MovieDetailState {
  final String message;
  MovieDetailError(this.message);

  @override 
  List<Object?> get props => [message];
}