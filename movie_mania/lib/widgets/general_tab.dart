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
          ListTile(
            leading: Text('STATUS'),
            trailing: Text(widget.movieDetail['status']['name']),
            
          ),
          ListTile(
            leading: Text('RELEASED'),
            trailing: Column(
              children: [
                Text('WorldWide ${widget.movieDetail['first_release']['date']}'),
                Text('WorldWide ${widget.movieDetail['first_release']['date']}'),
              ],
            )
            
          ),
          ListTile(
            leading: Text('RUNTIME'),
            trailing: Text('${widget.movieDetail['runtime']} minutes'),
            
          ),
          ListTile(
            leading: Text('GENRES'),
            trailing: Column(
              children: [
                Text(widget.movieDetail['genres'][0]['name']),
                Text(widget.movieDetail['genres'][1]['name']),
              ],
            )
            
          ),
          ListTile(
            leading: Text('ORIGINAL COUNTRY'),
            trailing: Text(widget.movieDetail['originalCountry']),
            
          ),
          ListTile(
            leading: Text('STATUS'),
            trailing: Text(widget.movieDetail['originalLanguage']),
            
          ),
          ListTile(
            leading: Text('STATUS'),
            trailing: Text(widget.movieDetail['status']['name']),
            
          ),
        ],
      ),
    );
  }
}