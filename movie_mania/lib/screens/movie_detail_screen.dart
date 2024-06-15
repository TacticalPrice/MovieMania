import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_mania/blocs/movie_detail/movie_detail_bloc.dart';
import 'package:movie_mania/blocs/movie_detail/movie_detail_event.dart';
import 'package:movie_mania/blocs/movie_detail/movie_detail_state.dart';
import 'package:movie_mania/models/movie.dart';
import 'package:movie_mania/services/movie_service.dart';
import 'package:movie_mania/widgets/artwork_tab.dart';
import 'package:movie_mania/widgets/cast_and_crew_tab.dart';
import 'package:movie_mania/widgets/general_tab.dart';

class MovieDetailScreen extends StatefulWidget {
  final int movieId;

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
    // TODO: implement initState
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
    return BlocProvider(
      create: (context) => _movieDetailBloc,
      child: BlocBuilder<MovieDetailBloc, MovieDetailState>(
        builder: (context, state) {
          if (state is MovieDetailLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is MovieDetailLoaded) {
            final movieDetail = state.movieDetail;
            print(state.movieDetail['overviewTranslations']);
            return Scaffold(
              appBar: AppBar(
                title: Text(movieDetail['name']),
              ),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 80,
                    ),
                    Center(
                        child: Container(
                            height: 300,
                            width: 200,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Image.network(movieDetail['image']))),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 16.0, right: 16, top: 10),
                      child: Text(
                        movieDetail['name'],
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 16.0, right: 16, top: 10),
                      child: Text(
                        state.englishOverview,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w400),
                      ),
                    ),
                    Column(
                      children: [
                        TabBar(
                          controller: _tabController,
                          tabs: [
                            Tab(text: 'General'),
                            Tab(text: 'Cast & Crew'),
                            Tab(text: 'Artworks'),
                          ],
                        ),
                        Container(
                          height: 600,
                          child:
                              TabBarView(controller: _tabController, children: [
                            buildGeneralTab(
                              movieDetail: movieDetail,
                            ),
                            CastAndCrewTab(
                              movieDetail: movieDetail,
                            ),
                            ArtWorkTab(movieDetail: movieDetail),
                          ]),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          } else if (state is MovieDetailError) {
            return Center(child: Text(state.message));
          } else {
            return Center(child: Text('Unknown state'));
          }
        },
      ),
    );
  }
}
