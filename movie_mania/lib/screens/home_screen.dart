import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:movie_mania/blocs/genre_bloc.dart';
import 'package:movie_mania/blocs/movie_bloc.dart';
import 'package:movie_mania/services/genre_service.dart';
import 'package:movie_mania/services/movie_service.dart';
import 'package:movie_mania/widgets/genre_container.dart';
import 'package:movie_mania/widgets/movie_home.dart';

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
  bool isSelected = false;

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
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
              height: 50, width: 50, child: Image.asset('assets/popcorn.png')),
        ),
        centerTitle: true,
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => _genreBloc),
          BlocProvider(create: (context) => _movieBloc),
        ],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Genres',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                textAlign: TextAlign.left,
              ),
            ),
            BlocBuilder<GenreBloc, GenreState>(
              builder: (context, state) {
                if (state is GenreLoading) {
                  ThemeData theme = Theme.of(context);
                  Color containerColor;

                  if (theme.brightness == Brightness.light) {
                    containerColor = Colors.grey[300]!;
                  } else {
                    containerColor = theme.primaryColor;
                  }
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 60,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: containerColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  );
                } else if (state is GenreLoaded) {
                  return SizedBox(
                    height: 70,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: state.genres.length,
                        itemBuilder: (context, index) {
                          final genre = state.genres[index];
                          bool isSelected = selectedGenreId == genre.id;
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedGenreId = genre.id;
                                  currentPage = 1;
                                });
                                _movieBloc.add(FetchMoviesByGenre(genre.id, 1));
                              },
                              child: GenreContainer(
                                  genre: genre.name, isSelected: isSelected),
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
                return MovieHome(
                  movies: state.movies,
                );
              } else if (state is MovieError) {
                return Center(
                  child: Text(state.message),
                );
              } else {
                ThemeData theme = Theme.of(context);

                if (theme.brightness == Brightness.light) {
                  return Center(
                    child: Lottie.asset(
                      "assets/loader.json",
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  );
                } 
                else {
                  return Center(
                    child: Lottie.asset(
                      "assets/loader2.json",
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  );
                }
              }
            }))
          ],
        ),
      ),
    );
  }
}
