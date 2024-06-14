import 'dart:js_interop';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_mania/blocs/genre_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GenreBloc()..add(FetchGenres()),
        child: Scaffold(
          appBar: AppBar(
            title: Text('Genre Flicks'),
          ),
          body: BlocBuilder<GenreBloc ,GenreState>(
            builder: (context ,state){
              if(state is GenreLoading){
                return Center(child: CircularProgressIndicator(),);
              }
              if(state is GenreLoaded){
                return ListView.builder(
                  itemCount: state.genres.length,
                  itemBuilder: (context , index) {
                    final genre = state.genres[index];
                    return ListTile(
                      title: Text(genre.name),
                      onTap: (){
                        
                      },
                    );
                  }
                  );
              }
            },
          ),
        ),
      );
  }
}