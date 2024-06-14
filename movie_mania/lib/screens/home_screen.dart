import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_mania/blocs/genre_bloc.dart';
import 'package:movie_mania/screens/genre_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Genre Flicks'),
      ),
      body: BlocProvider(
        create: (context) => GenreBloc()..add(FetchGenres()),
        child: GenreScreen(),
        ),
    );
  }
}