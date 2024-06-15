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
    return Container(
      // leading: Image.network(widget.searchResult.imageUrl),
      // title: Text(widget.searchResult.name),
      // onTap: widget.onTap,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(6.0),
            child: Container(
              height: 150,
              width: 100,
              child: Image.network(
                widget.searchResult.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.searchResult.name,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
              Text(
                '${widget.searchResult.year} ,',
              )
            ],
          )
        ],
      ),
    );
  }
}
