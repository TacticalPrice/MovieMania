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
      height: 600,
      child: Column(
        children: [
          listTile('STATUS', widget.movieDetail['status']['name']),
          listTile('RELEASED', 'WorldWide ${widget.movieDetail['first_release']['date']}'),
          listTile('RUNTIME', '${widget.movieDetail['runtime']} minutes'),
          ListTile(
            leading: Text('GENRES', style: TextStyle(fontSize: 14),),
            trailing: Column(
              children: [
                Text(widget.movieDetail['genres'][0]['name'], style: TextStyle(fontSize: 14),),
                Text(widget.movieDetail['genres'][1]['name'], style: TextStyle(fontSize: 14),),
              ],
            )
            
          ),
          listTile('ORIGINAL COUNTRY', widget.movieDetail['originalCountry']),
          listTile('ORIGINAL LANGUAGE',widget.movieDetail['originalLanguage']),
          listTile('PRODUCTION COMPANY', widget.movieDetail['companies']['production'][0]['name']),
          listTile('PRODUCTION COUNTRY', widget.movieDetail['production_countries'][0]['name']),
        ],
      ),
    );
  }

  Widget listTile(String leading , String trailing){
    return ListTile(
      leading: Text(leading, style: TextStyle(fontSize: 14, ),),
      trailing: Text(trailing,style : TextStyle(fontSize: 14,),),

    );

  }
}