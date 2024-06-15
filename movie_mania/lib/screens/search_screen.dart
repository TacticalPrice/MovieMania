import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_mania/blocs/movie_bloc.dart';
import 'package:movie_mania/screens/movie_detail_screen.dart';
import 'package:movie_mania/widgets/movie_item.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Movies'),
      ),
      body: Padding(
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
                  },
                  icon: Icon(Icons.search),
                ),
              ),
            ),
            Expanded(
              child:
                  BlocBuilder<MovieBloc, MovieState>(builder: (context, state) {
                if (state is MovieLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is MovieLoaded) {
                  return ListView.builder(
                      itemCount: state.movies.length,
                      itemBuilder: (context, index) {
                        final movie = state.movies[index];
                        return MovieItem(
                            movie: movie,
                            onTap: () {
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) =>
                              //             MovieDetailScreen(movie: movie)));
                            });
                      });
                } else if (state is MovieError) {
                  return Center(child: Text('Failed to load movies'));
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
    );
  }
}
