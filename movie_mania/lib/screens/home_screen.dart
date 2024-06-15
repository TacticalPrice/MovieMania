import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:movie_mania/blocs/genre_bloc.dart';
import 'package:movie_mania/blocs/movie_bloc.dart';
import 'package:movie_mania/screens/genre_screen.dart';
import 'package:movie_mania/screens/movie_detail_screen.dart';
import 'package:movie_mania/screens/movie_list_screen.dart';
import 'package:movie_mania/screens/search_screen.dart';
import 'package:movie_mania/services/auth_service.dart';
import 'package:movie_mania/services/genre_service.dart';
import 'package:movie_mania/services/movie_service.dart';
import 'package:movie_mania/widgets/movie_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late MovieBloc _movieBloc;
  final MovieService movieService = MovieService();
  late GenreBloc _genreBloc;
  GenreService genreService = GenreService();
  int? selectedGenreId;
  int currentPage = 1;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _genreBloc = GenreBloc(genreService: genreService);
    _genreBloc.add(FetchGenres());

    _movieBloc = MovieBloc(movieService: movieService);
    _movieBloc.add(FetchMovies());
  }

  void _loadMoreMovies() {
    if (selectedGenreId != null) {
      _movieBloc.add(FetchMoviesByGenre(selectedGenreId!, currentPage + 1));
    } else {
      _movieBloc.add(FetchMovies(page: currentPage + 1));
    }
    setState(() {
      currentPage++;
    });
  }

  void _onScroll() {
    if (_isBottom) {
      _loadMoreMovies();
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _scrollController.addListener(_onScroll);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movie Mania'),
        centerTitle: true,
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => _genreBloc),
          BlocProvider(create: (context) => _movieBloc),
        ],
        child: Column(
          children: [
            BlocBuilder<GenreBloc, GenreState>(
              builder: (context, state) {
                if (state is GenreLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is GenreLoaded) {
                  return SizedBox(
                    height: 60,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: state.genres.length,
                        itemBuilder: (context, index) {
                          final genre = state.genres[index];
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedGenreId = genre.id;
                                  currentPage = 1;
                                });
                                print(genre.id);
                                _movieBloc.add(FetchMoviesByGenre(genre.id, 1));
                              },
                              child: Container(
                                constraints: BoxConstraints(
                                  minWidth: 30,
                                ),
                                height: 20,
                                decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Text(genre.name),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                  );
                } else if (state is GenreError) {
                  return Center(child: Text(state.message));
                } else {
                  return Center(child: Text('Unknown state'));
                }
              },
            ),
            Expanded(child:
                BlocBuilder<MovieBloc, MovieState>(builder: (context, state) {
              if (state is MovieLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is MovieLoaded) {
                return ListView.builder(
                  controller: _scrollController,
                  itemCount: state.hasReachedMax
                      ? state.movies.length
                      : state.movies.length + 1,
                  itemBuilder: (context, index) {
                    if (index >= state.movies.length) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    final movie = state.movies[index];
                    return GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder : (context) => MovieDetailScreen(movieId: movie.id,)));
                        //context.read<MovieBloc>().add(NavigateToMovieDetail(movieId: movie.id));
                      },
                      child: CachedNetworkImage(
                        imageUrl: movie.image,
                        placeholder: (context, url) => Container(
                          height: 100,
                          width: 100,
                          color: Colors.grey[300],
                          child: const Center(child: CircularProgressIndicator()),
                        ),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    );
                  },
                );
              } else if (state is MovieError) {
                return Center(
                  child: Text(state.message),
                );
              } else {
                return Center(
                  child: Text('Unknown State'),
                );
              }
            }))
          ],
        ),
      ),
    );
  }
}
