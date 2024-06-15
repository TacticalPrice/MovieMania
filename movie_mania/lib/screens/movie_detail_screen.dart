import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_mania/blocs/movie_detail/movie_detail_bloc.dart';
import 'package:movie_mania/blocs/movie_detail/movie_detail_event.dart';
import 'package:movie_mania/blocs/movie_detail/movie_detail_state.dart';
import 'package:movie_mania/models/movie.dart';
import 'package:movie_mania/services/movie_service.dart';

class MovieDetailScreen extends StatefulWidget {
  final int movieId;

  MovieDetailScreen({required this.movieId});

  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  late MovieDetailBloc _movieDetailBloc;
  final MovieService movieService = MovieService();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _movieDetailBloc = MovieDetailBloc(movieService: movieService);
    _movieDetailBloc.add(FetchMovieDetail(movieId: widget.movieId));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _movieDetailBloc,
      child: BlocBuilder<MovieDetailBloc, MovieDetailState>(
        builder: (context, state) {
          if (state is MovieDetailLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is MovieDetailLoaded) {
            final movieDetail = state.movieDetail;
            print(state.movieDetail);
            return Scaffold(
              appBar: AppBar(
                title: Text(movieDetail.name),
              ),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    Image.network(movieDetail.image),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        movieDetail.name,
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                    ),
                    
                  ],
                ),
              ),
            );
          } else if (state is MovieDetailError){
            return Center(child: Text(state.message));
          }else{
            return Center(child: Text('Unknown state'));
          }
        },
      ),
    );
  }
}
