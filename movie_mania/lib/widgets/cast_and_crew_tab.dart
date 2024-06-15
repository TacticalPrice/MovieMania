import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CastAndCrewTab extends StatefulWidget {
  final Map<String, dynamic> movieDetail;
  const CastAndCrewTab({super.key, required this.movieDetail});

  @override
  State<CastAndCrewTab> createState() => _CastAndCrewTabState();
}

class _CastAndCrewTabState extends State<CastAndCrewTab> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: 0.7),
        itemCount: widget.movieDetail['characters'].length,
        itemBuilder: (context, index) {
          final castOrCrew = widget.movieDetail['characters'][index];
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
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    children: [
                      Text(
                        '${castOrCrew['personName']}  ${castOrCrew['name'] ?? ''}',
                        style: TextStyle(fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 4.0),
                      Text(
                        castOrCrew['peopleType']!,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }
}
