
import 'package:equatable/equatable.dart';

class FavoritesState extends Equatable {
  final List<dynamic> favorites;

  const FavoritesState({required this.favorites});

  factory FavoritesState.initial() {
    return FavoritesState(favorites: []);
    
  }

  @override
  List<Object?> get props => [favorites];

   FavoritesState copyWith({List<Map<String, dynamic>>? favorites}) {
    return FavoritesState(favorites: favorites ?? this.favorites);
  }

  
}
