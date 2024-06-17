import 'package:flutter/material.dart';

class buildGeneralTab extends StatefulWidget {
  final Map<String , dynamic>movieDetail;
  const buildGeneralTab({required this.movieDetail});

  @override
  State<buildGeneralTab> createState() => _buildGeneralTabState();
}

class _buildGeneralTabState extends State<buildGeneralTab> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      child: Column(
        children: [
          listTile('STATUS', widget.movieDetail['status']['name'] ?? "Not Available"),
          listTile('RELEASED', 'WorldWide ${widget.movieDetail['first_release']['date'] ?? 'Not Available'}'),
          listTile('RUNTIME', '${widget.movieDetail['runtime']?? 'Not Available'} minutes'),
          ListTile(
            leading: Text('GENRES', style: TextStyle(fontSize: 14),),
            trailing: Column(
              children: [
                Text(widget.movieDetail['genres']?[0]?['name'] ?? 'Not Available', style: TextStyle(fontSize: 14),),
                widget.movieDetail['genres'].length > 1
                ? 
                Text(widget.movieDetail['genres']?[1]?['name'] ?? " ", style: TextStyle(fontSize: 14),)
                : SizedBox()
              ],
            )
            
          ),
          listTile('ORIGINAL COUNTRY', widget.movieDetail['originalCountry']?? 'Not Available'),
          listTile('ORIGINAL LANGUAGE',widget.movieDetail['originalLanguage'] ?? 'Not Available'),
          listTile('PRODUCTION COMPANY', widget.movieDetail['companies']?['production']?[0]?['name'] ?? 'Not Available'),
          listTile('PRODUCTION COUNTRY', widget.movieDetail['production_countries']?[0]?['name'] ?? 'Not Available'),
        ],
      ),
    );
  }

  Widget listTile(String leading , String trailing){
    return ListTile(
      leading: Text(leading, style: TextStyle(fontSize: 14, ),),
      trailing: Container(
        width: 150,
        child: Text(trailing,style : TextStyle(fontSize: 14,), textAlign: TextAlign.end,) ,),

    );

  }
}