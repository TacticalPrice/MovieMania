import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_mania/blocs/favorite/favorite_bloc.dart';
import 'package:movie_mania/blocs/favorite/favorite_event.dart';

class FavoriteContainer extends StatefulWidget {
  final Map<String, dynamic> movie;
  const FavoriteContainer({super.key, required this.movie});

  @override
  State<FavoriteContainer> createState() => _FavoriteContainerState();
}

class _FavoriteContainerState extends State<FavoriteContainer> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 100,
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.vertical(
                  top: Radius.circular(8), bottom: Radius.circular(8)),
              child: CachedNetworkImage(
                imageUrl: widget.movie['image'] ?? '',
                fit: BoxFit.cover,
                placeholder: (context, url) => Center(
                  child: SizedBox(),
                ),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.movie['name']),
                SizedBox(
                  height: 5,
                ),
                Text(widget.movie['year']),
              ],
            ),
            SizedBox(width: 30,),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                context
                    .read<FavoritesBloc>()
                    .add(RemoveFromFavorites(widget.movie));
              },
            ),
          ],
        ),
      ),
    );
  }
}
