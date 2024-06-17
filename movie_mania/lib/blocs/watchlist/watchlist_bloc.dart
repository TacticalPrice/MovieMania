import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:movie_mania/blocs/favorite/favorite_event.dart';
import 'package:movie_mania/blocs/favorite/favorite_state.dart';
import 'package:movie_mania/blocs/watchlist/watchlist_event.dart';
import 'package:movie_mania/blocs/watchlist/watchlist_state.dart';
import 'package:movie_mania/models/movie.dart';

class WatchlistBloc extends HydratedBloc<WatchlistEvent, WatchlistState> {
  WatchlistBloc() : super(WatchlistState.initial()) {
    on<AddToWatchList>(_onAddToWatchlist);
    on<RemoveFromWatchList>(_onRemoveFromWatchlist);
  }

  void _onAddToWatchlist(AddToWatchList event, Emitter<WatchlistState> emit) {
    final updatedFavorites = List<dynamic>.from(state.watchlist)
      ..add(event.movie);
    emit(WatchlistState(watchlist: updatedFavorites));
  }

  void _onRemoveFromWatchlist(RemoveFromWatchList event, Emitter<WatchlistState> emit) {
    // final updatedFavorites = List<dynamic>.from(state.watchlist)
    //   ..remove(event.movie);
    final updatedFavorites = state.watchlist.where((movie) => movie['id'] != event.movie['id']).toList();
    emit(WatchlistState(watchlist: updatedFavorites));
  }

  @override
  WatchlistState fromJson(Map<String, dynamic> json) {
    final watchlist = List<dynamic>.from(json['watchlist']);
    return WatchlistState(watchlist: watchlist);
  }

  @override
  Map<String, dynamic> toJson(WatchlistState state) {
    return {'watchlist': state.watchlist};
  }
}
