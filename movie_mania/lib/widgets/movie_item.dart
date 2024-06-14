import 'package:flutter/material.dart';
import 'package:movie_mania/models/movie.dart';

class MovieItem extends StatefulWidget {
  final Movie movie;
  final VoidCallback onTap;

  MovieItem({required this.movie, required this.onTap});

  @override
  State<MovieItem> createState() => _MovieItemState();
}

class _MovieItemState extends State<MovieItem> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(widget.movie.poster),
      title: Text(widget.movie.title),
      onTap: widget.onTap,
    );
  }
}
