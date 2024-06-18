import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:movie_mania/blocs/favorite/favorite_event.dart';
import 'package:movie_mania/blocs/favorite/favorite_state.dart';
import 'package:movie_mania/models/movie.dart';

class FavoritesBloc extends HydratedBloc<FavoritesEvent, FavoritesState> {
  FavoritesBloc() : super(FavoritesState.initial()) {
    on<AddToFavorites>(_onAddToFavorites);
    on<RemoveFromFavorites>(_onRemoveFromFavorites);
  }

  void _onAddToFavorites(AddToFavorites event, Emitter<FavoritesState> emit) {
    final updatedFavorites = List<Map<String, dynamic>>.from(state.favorites)
      ..add(event.movie);
    emit(FavoritesState(favorites: updatedFavorites));
  }

  void _onRemoveFromFavorites(RemoveFromFavorites event, Emitter<FavoritesState> emit) {
    // final updatedFavorites = List<dynamic>.from(state.favorites)
    //   ..remove(event.movie);
    final updatedFavorites = state.favorites.where((movie) => movie['id'] != event.movie['id']).toList();
    emit(FavoritesState(favorites: updatedFavorites));
  }

  @override
  FavoritesState fromJson(Map<String, dynamic> json) {
    final favorites = List<Map<String,dynamic>>.from(json['favorites']);
    return FavoritesState(favorites: favorites);
  }

  @override
  Map<String, dynamic> toJson(FavoritesState state) {
    return {'favorites': state.favorites};
  }
}
