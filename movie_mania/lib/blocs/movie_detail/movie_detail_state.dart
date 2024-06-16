import 'package:equatable/equatable.dart';

abstract class MovieDetailState extends Equatable {
  @override 
  List<Object?> get props => [];
}

class MovieDetailInitial extends MovieDetailState {}

class MovieDetailLoading extends MovieDetailState {}

class MovieDetailLoaded extends MovieDetailState {
  final Map<String ,dynamic> movieDetail;
  final String englishOverview;

  MovieDetailLoaded({required this.englishOverview, required this.movieDetail});

  @override 
  List<Object?>get props => [movieDetail];
}

class MovieDetailError extends MovieDetailState {
  final String message;
  MovieDetailError(this.message);

  @override 
  List<Object?> get props => [message];
}