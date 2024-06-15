import 'package:flutter/material.dart';

class GenreContainer extends StatefulWidget {
  final String genre;
  const GenreContainer({super.key, required this.genre});

  @override
  State<GenreContainer> createState() => _GenreContainerState();
}

class _GenreContainerState extends State<GenreContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      width: 120,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Text(widget.genre ,textAlign: TextAlign.center,),
        ),
      ),
    );
  }
}
