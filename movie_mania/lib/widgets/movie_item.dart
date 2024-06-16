import 'package:flutter/material.dart';
import 'package:movie_mania/models/search.dart';

class MovieItem extends StatefulWidget {
  final Map<String , dynamic> searchResult;
  //final VoidCallback onTap;

  MovieItem({required this.searchResult});

  @override
  State<MovieItem> createState() => _MovieItemState();
}

class _MovieItemState extends State<MovieItem> {
  bool detail = false;
  @override
  Widget build(BuildContext context) {
    final result = widget.searchResult;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: Container(
                height: 150,
                width: 100,
                child: Image.network(
                  result['image_url'],
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(width: 10,),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 200,
                  child: Text(
                    result['name'],
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                ),
                Text(
                  '${result['year']} , ${result['status']}',
                ),
                result?['overviews']?['eng'] != null
                ? GestureDetector(
                  onTap: (){
                    setState(() {
                      detail = !detail;
                    });
                    
                  },
                  child: Text('View Details' , style: TextStyle(color: Colors.red),),
                )
                : SizedBox(),
      
                detail
                ? Container(
                  width: 240,
                  child: Text(result?['overviews']?['eng'] , maxLines: 6,))
                : SizedBox()
              ],
            )
          ],
        ),
      ),
    );
  }
}
