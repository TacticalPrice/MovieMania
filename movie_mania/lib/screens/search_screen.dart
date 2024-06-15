import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_mania/blocs/movie_bloc.dart';
import 'package:movie_mania/blocs/search/search_bloc.dart';
import 'package:movie_mania/screens/movie_detail_screen.dart';
import 'package:movie_mania/services/movie_service.dart';
import 'package:movie_mania/widgets/movie_item.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  late MovieSearchBloc _movieSearchBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _movieSearchBloc = MovieSearchBloc(movieService: MovieService());
  }

  @override
  void dispose() {
    _movieSearchBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Movies'),
      ),
      body: BlocProvider(
        create: (context) => _movieSearchBloc,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  labelText: 'Search',
                  suffixIcon: IconButton(
                    onPressed: () {
                      final query = _searchController.text;
                      _movieSearchBloc.add(PerformSearch(query));
                    },
                    icon: Icon(Icons.search),
                  ),
                ),
              ),
              Expanded(
                child: BlocBuilder<MovieSearchBloc, MovieSearchState>(
                    builder: (context, state) {
                  if (state is MovieSearchLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is MovieSearchLoaded) {
                    return ListView.builder(
                        itemCount: state.searchResult.length,
                        itemBuilder: (context, index) {
                          final movie = state.searchResult[index];
                          return MovieItem(
                              searchResult: movie,
                              onTap: () {
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (context) =>
                                //             MovieDetailScreen(movie: movie)));
                              });
                        });
                  } else if (state is MovieSearchError) {
                    return Center(child: Text(state.message));
                  } else {
                    return Center(
                      child: Text('Unknown State'),
                    );
                  }
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
