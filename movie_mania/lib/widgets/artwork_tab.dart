import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ArtWorkTab extends StatefulWidget {
  final Map<String , dynamic>movieDetail;
  const ArtWorkTab({super.key, required this.movieDetail});

  @override
  State<ArtWorkTab> createState() => _ArtWorkTabState();
}

class _ArtWorkTabState extends State<ArtWorkTab> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: 0.7),
        itemCount: widget.movieDetail['artworks'].length,
        itemBuilder: (context, index) {
          final castOrCrew = widget.movieDetail['artworks'][index];
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(8)),
                    child: CachedNetworkImage(
                      imageUrl: castOrCrew['image'],
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Center(
                        child: CircularProgressIndicator(),
                      ),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  ),
                ),
               
              ],
            ),
          );
        });
  }
}