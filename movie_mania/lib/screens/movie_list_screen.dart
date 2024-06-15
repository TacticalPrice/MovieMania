// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:movie_mania/blocs/movie_bloc.dart';
// import 'package:movie_mania/screens/movie_detail_screen.dart';
// import 'package:movie_mania/widgets/movie_item.dart';

// class MovieListScreen extends StatefulWidget {
//   final int genreId;
//   const MovieListScreen({super.key, required this.genreId,});

//   @override
//   State<MovieListScreen> createState() => _MovieListScreenState();
// }

// class _MovieListScreenState extends State<MovieListScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Movies'),
//       ),
//       body: BlocProvider(
//         create: (context) =>
//             MovieBloc()..add(FetchMoviesByGenre(widget.genreId )),
//         child: BlocBuilder<MovieBloc, MovieState>(builder: (context, state) {
//           if (state is MovieLoading) {
//             return Center(
//               child: CircularProgressIndicator(),
//             );
//           } else if (state is MovieLoaded) {
//             return ListView.builder(
//                 itemCount: state.movies.length,
//                 itemBuilder: (context, index) {
//                   final movie = state.movies[index];
//                   return MovieItem(
//                       movie: movie,
//                       onTap: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) =>
//                                 MovieDetailScreen(movie: movie),
//                           ),
//                         );
//                       });
//                 });
//           } else if (state is MovieError) {
//             return Center(
//               child: Text('Failed to load Movies'),
//             );
//           } else {
//             return Center(
//               child: Text('Unknown state'),
//             );
//           }
//         }),
//       ),
//     );
//   }
// }
