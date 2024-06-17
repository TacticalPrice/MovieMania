import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:movie_mania/blocs/favorite/favorite_bloc.dart';
import 'package:movie_mania/blocs/favorite/favorite_event.dart';
import 'package:movie_mania/blocs/favorite/favorite_state.dart';
import 'package:movie_mania/blocs/movie_detail/movie_detail_bloc.dart';
import 'package:movie_mania/blocs/movie_detail/movie_detail_event.dart';
import 'package:movie_mania/blocs/movie_detail/movie_detail_state.dart';
import 'package:movie_mania/blocs/watchlist/watchlist_bloc.dart';
import 'package:movie_mania/blocs/watchlist/watchlist_event.dart';
import 'package:movie_mania/blocs/watchlist/watchlist_state.dart';
import 'package:movie_mania/models/movie.dart';
import 'package:movie_mania/services/movie_service.dart';
import 'package:movie_mania/widgets/artwork_tab.dart';
import 'package:movie_mania/widgets/cast_and_crew_tab.dart';
import 'package:movie_mania/widgets/general_tab.dart';

class MovieDetailScreen extends StatefulWidget {
  final String movieId;

  MovieDetailScreen({required this.movieId});

  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen>
    with SingleTickerProviderStateMixin {
  late MovieDetailBloc _movieDetailBloc;
  final MovieService movieService = MovieService();
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _movieDetailBloc = MovieDetailBloc(movieService: movieService);
    _movieDetailBloc.add(FetchMovieDetail(movieId: widget.movieId));
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MovieDetailBloc>(
          create: (context) => _movieDetailBloc,
        ),
        BlocProvider<FavoritesBloc>(
          create: (context) => BlocProvider.of<FavoritesBloc>(context),
        ),
      ],
      child: BlocBuilder<MovieDetailBloc, MovieDetailState>(
        builder: (context, state) {
          if (state is MovieDetailLoading) {
               ThemeData theme = Theme.of(context);

                if (theme.brightness == Brightness.light) {
                  return Scaffold(
                    body: Center(
                      child: Lottie.asset(
                        "assets/loader.json",
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                } 
                else {
                  return Scaffold(
                    body: Center(
                      child: Lottie.asset(
                        "assets/loader2.json",
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                }
          } else if (state is MovieDetailLoaded) {
            final movieDetail = state.movieDetail;
            return Scaffold(
              appBar: AppBar(
                title: Text(movieDetail['name']),
              ),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 20),
                    Center(
                      child: Container(
                        height: 300,
                        width: 200,
                        child:  ClipRRect(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(8) , bottom: Radius.circular(8)),
                      child: CachedNetworkImage(
                        imageUrl:
                            movieDetail['image'],
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Center(
                          child: SizedBox(),
                        ),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        movieDetail['name'],
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        state.englishOverview,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        BlocBuilder<FavoritesBloc, FavoritesState>(
                          builder: (context, favoritesState) {
                        
                        
                            bool isFavorite = false;
                            for(var item in favoritesState.favorites){
                              if(movieDetail['id'] == item['id']){
                                isFavorite = true;
                              }
                        
                            }
                            return IconButton(
                              icon: Icon(
                                isFavorite
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: isFavorite ? Colors.red : null,
                              ),
                              onPressed: () {
                                if (isFavorite) {
                                  context
                                      .read<FavoritesBloc>()
                                      .add(RemoveFromFavorites(movieDetail));
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('Removed From Favorites')));
                                } else {
                                  context
                                      .read<FavoritesBloc>()
                                      .add(AddToFavorites(movieDetail));
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('Added to Favorites')));
                                }
                              },
                            );
                          },
                        ),

                        BlocBuilder<WatchlistBloc, WatchlistState>(
                          builder: (context, watchlistState) {
                        
                        
                            bool isFavorite = false;
                            for(var item in watchlistState.watchlist){
                              if(movieDetail['id'] == item['id']){
                                isFavorite = true;
                              }
                        
                            }
                            return IconButton(
                              icon: Icon(
                                isFavorite
                                    ? Icons.bookmark
                                    : Icons.bookmark_add_outlined,
                                color: isFavorite ? Colors.yellow : null,
                              ),
                              onPressed: () {
                                if (isFavorite) {
                                  context
                                      .read<WatchlistBloc>()
                                      .add(RemoveFromWatchList(movieDetail));
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('Removed From Favorites')));
                                } else {
                                  context
                                      .read<WatchlistBloc>()
                                      .add(AddToWatchList(movieDetail));
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('Added to Favorites')));
                                }
                              },
                            );
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 20,),
                    
                    Column(
                      children: [
                        TabBar(
                          controller: _tabController,
                          tabs: [
                            Tab(text: 'General'),
                            Container(
                              child: Tab(text: 'Cast & Crew')),
                            Tab(text: 'Artworks'),
                          ],
                        ),
                        Container(
                          height: 500,
                          child: TabBarView(
                            controller: _tabController,
                            children: [
                              buildGeneralTab(
                                movieDetail: movieDetail,
                              ),
                              CastAndCrewTab(
                                movieDetail: movieDetail,
                              ),
                              ArtWorkTab(
                                movieDetail: movieDetail,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );

          } else if (state is MovieDetailError) {
            print(state.message);
            return Center(child: Text(state.message));
          } else {
            return Center(child: Text('Unknown state'));
          }
        },
      ),
    );
  }
}
