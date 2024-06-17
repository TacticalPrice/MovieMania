
import 'package:equatable/equatable.dart';

class FavoritesState extends Equatable {
  final List<dynamic> favorites;

  const FavoritesState({required this.favorites});

  factory FavoritesState.initial() {
    return FavoritesState(favorites: []);
  }

  @override
  List<Object?> get props => [favorites];
}
