
import 'package:equatable/equatable.dart';

abstract class FavoritesEvent extends Equatable {
  const FavoritesEvent();

  @override
  List<Object?> get props => [];
}

class AddToFavorites extends FavoritesEvent {
  final Map<String , dynamic> movie;

  const AddToFavorites(this.movie);

  @override
  List<Object?> get props => [movie];
}

class RemoveFromFavorites extends FavoritesEvent {
  final Map<String,dynamic> movie;

  const RemoveFromFavorites(this.movie);

  @override
  List<Object?> get props => [movie];
}
