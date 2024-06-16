import 'package:equatable/equatable.dart';

abstract class LocalStorageEvent extends Equatable {
  const LocalStorageEvent();

  @override
  List<Object> get props => [];
}

class AddToFavorites extends LocalStorageEvent {
  final String movieId;

  AddToFavorites(this.movieId);

  @override
  List<Object> get props => [movieId];
}

class RemoveFromFavorites extends LocalStorageEvent {
  final String movieId;

  RemoveFromFavorites(this.movieId);

  @override
  List<Object> get props => [movieId];
}

class AddToWatchList extends LocalStorageEvent {
  final String movieId;

  AddToWatchList(this.movieId);

  @override
  List<Object> get props => [movieId];
}


class RemoveFromWatchList extends LocalStorageEvent {
  final String movieId;

  RemoveFromWatchList(this.movieId);

  @override
  List<Object> get props => [movieId];
}


class AddToWatched extends LocalStorageEvent {
  final String movieId;

  AddToWatched(this.movieId);

  @override
  List<Object> get props => [movieId];
}

class RemoveFromWatched extends LocalStorageEvent {
  final String movieId;

  RemoveFromWatched(this.movieId);

  @override
  List<Object> get props => [movieId];
}

class LoadLocalStorage extends LocalStorageEvent {}

