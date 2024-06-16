import 'package:equatable/equatable.dart';

abstract class MovieDetailEvent extends Equatable{
  @override 
  List<Object?> get props => [];

}

class FetchMovieDetail extends MovieDetailEvent {
  final String movieId;

  FetchMovieDetail({required this.movieId});

  @override 
  List<Object?> get props => [movieId];
}