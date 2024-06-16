import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'local_storage_event.dart';
import 'local_storage_state.dart';

class LocalStorageBloc extends Bloc<LocalStorageEvent, LocalStorageState> {
  final Box box;

  LocalStorageBloc() : box = Hive.box('movies'), super(LocalStorageInitial()) {
    on<LoadLocalStorage>(_onLoadLocalStorage);
    on<AddToFavorites>(_onAddToFavorites);
    on<RemoveFromFavorites>(_onRemoveFromFavorites);
    on<AddToWatchList>(_onAddToWatchList);
    on<RemoveFromWatchList>(_onRemoveFromWatchList);
    on<AddToWatched>(_onAddToWatched);
    on<RemoveFromWatched>(_onRemoveFromWatched);
  }

  Future<void> _onLoadLocalStorage(LoadLocalStorage event, Emitter<LocalStorageState> emit) async {
    final favoriteMovies = box.get('favoriteMovies', defaultValue: <String>[]);
    final watchListMovies = box.get('watchListMovies', defaultValue: <String>[]);
    final watchedMovies = box.get('watchedMovies', defaultValue: <String>[]);

    emit(LocalStorageLoaded(
      favoriteMovies: List<String>.from(favoriteMovies),
      watchListMovies: List<String>.from(watchListMovies),
      watchedMovies: List<String>.from(watchedMovies),
    ));
  }

  Future<void> _onAddToFavorites(AddToFavorites event, Emitter<LocalStorageState> emit) async {
    final favoriteMovies = box.get('favoriteMovies', defaultValue: <String>[]);
    favoriteMovies.add(event.movieId);
    await box.put('favoriteMovies', favoriteMovies);
    add(LoadLocalStorage());
  }

  Future<void> _onRemoveFromFavorites(RemoveFromFavorites event, Emitter<LocalStorageState> emit) async {
    final favoriteMovies = box.get('favoriteMovies', defaultValue: <String>[]);
    favoriteMovies.remove(event.movieId);
    await box.put('favoriteMovies', favoriteMovies);
    add(LoadLocalStorage());
  }

  Future<void> _onAddToWatchList(AddToWatchList event, Emitter<LocalStorageState> emit) async {
    final watchListMovies = box.get('watchListMovies', defaultValue: <String>[]);
    watchListMovies.add(event.movieId);
    await box.put('watchListMovies', watchListMovies);
    add(LoadLocalStorage());
  }

  Future<void> _onRemoveFromWatchList(RemoveFromWatchList event, Emitter<LocalStorageState> emit) async {
    final watchListMovies = box.get('watchListMovies', defaultValue: <String>[]);
    watchListMovies.remove(event.movieId);
    await box.put('watchListMovies', watchListMovies);
    add(LoadLocalStorage());
  }

  Future<void> _onAddToWatched(AddToWatched event, Emitter<LocalStorageState> emit) async {
    final watchedMovies = box.get('watchedMovies', defaultValue: <String>[]);
    watchedMovies.add(event.movieId);
    await box.put('watchedMovies', watchedMovies);
    add(LoadLocalStorage());
  }

  Future<void> _onRemoveFromWatched(RemoveFromWatched event, Emitter<LocalStorageState> emit) async {
    final watchedMovies = box.get('watchedMovies', defaultValue: <String>[]);
    watchedMovies.remove(event.movieId);
    await box.put('watchedMovies', watchedMovies);
    add(LoadLocalStorage());
  }
}
