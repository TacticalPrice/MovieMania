
import 'package:equatable/equatable.dart';

class WatchlistState extends Equatable {
  final List<dynamic> watchlist;

  const WatchlistState({required this.watchlist});

  factory WatchlistState.initial() {
    return WatchlistState(watchlist: []);
  }

  @override
  List<Object?> get props => [watchlist];
}
