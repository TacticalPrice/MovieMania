
import 'package:equatable/equatable.dart';

abstract class WatchlistEvent extends Equatable {
  const WatchlistEvent();

  @override
  List<Object?> get props => [];
}

class AddToWatchList extends WatchlistEvent {
  final Map<String , dynamic> movie;

  const AddToWatchList(this.movie);

  @override
  List<Object?> get props => [movie];
}

class RemoveFromWatchList extends WatchlistEvent {
  final Map<String,dynamic> movie;

  const RemoveFromWatchList(this.movie);

  @override
  List<Object?> get props => [movie];
}
