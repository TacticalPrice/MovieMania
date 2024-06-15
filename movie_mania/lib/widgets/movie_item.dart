import 'package:flutter/material.dart';
import 'package:movie_mania/models/search.dart';

class MovieItem extends StatefulWidget {
  final SearchResult searchResult;
  final VoidCallback onTap;

  MovieItem({required this.searchResult, required this.onTap});

  @override
  State<MovieItem> createState() => _MovieItemState();
}

class _MovieItemState extends State<MovieItem> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(widget.searchResult.imageUrl),
      title: Text(widget.searchResult.name),
      onTap: widget.onTap,
    );
  }
}
