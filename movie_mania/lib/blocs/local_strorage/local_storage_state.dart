import 'package:equatable/equatable.dart';

abstract class LocalStorageState extends Equatable {
  const LocalStorageState();

  @override
  List<Object> get props => [];
}

class LocalStorageInitial extends LocalStorageState {}

class LocalStorageLoaded extends LocalStorageState {
  final List<String> favoriteMovies;
  final List<String> watchListMovies;
  final List<String> watchedMovies;

  LocalStorageLoaded({
    required this.favoriteMovies,
    required this.watchListMovies,
    required this.watchedMovies,
  });

  @override
  List<Object> get props => [favoriteMovies, watchListMovies, watchedMovies];
}
