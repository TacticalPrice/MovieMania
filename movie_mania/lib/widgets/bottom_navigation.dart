import 'package:flutter/material.dart';
import 'package:movie_mania/blocs/movie_bloc.dart';
import 'package:movie_mania/screens/home_screen.dart';
import 'package:movie_mania/screens/search_screen.dart';
import 'package:movie_mania/screens/user_screen.dart';
import 'package:movie_mania/services/movie_service.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _currentIndex = 0;
  late MovieBloc _movieBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _movieBloc = MovieBloc(movieService: MovieService());
  }

  final List<Widget> _screens = [
    HomeScreen(),
    SearchScreen(),
    UserScreen()
  ];

  void _onTap(int index){
    setState(() {
      _currentIndex = index;
    });
    if(_currentIndex == 0)
    {
      _movieBloc.add(FetchMovies());
      
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTap,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
           BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'User'),
        ],
      ),
    );
  }
}