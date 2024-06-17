import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:movie_mania/blocs/data/data_bloc.dart';
import 'package:movie_mania/blocs/data/data_event.dart';
import 'package:movie_mania/blocs/data/data_state.dart';
import 'package:movie_mania/blocs/movie_bloc.dart';
import 'package:movie_mania/blocs/search/search_bloc.dart';
import 'package:movie_mania/screens/movie_detail_screen.dart';
import 'package:movie_mania/services/movie_service.dart';
import 'package:movie_mania/services/user_service.dart';
import 'package:movie_mania/widgets/movie_item.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  late MovieSearchBloc _movieSearchBloc;
  late DataBloc _dataBloc;
  final ScrollController _scrollController = ScrollController();
  final UserService userService = UserService();
  List<dynamic>? languages = [];
  List<dynamic>? countries = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _movieSearchBloc = MovieSearchBloc(movieService: MovieService());
    _dataBloc = DataBloc(UserService());

    _scrollController.addListener(_onScroll);
    _initializeData();
  }

  void _initializeData() async {
    languages = await userService.fetchLanguages();
    countries = await userService.fetchCountries();
  }

  @override
  void dispose() {
    _movieSearchBloc.close();
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      _movieSearchBloc.add(LoadMoreResults(_searchController.text));
    }
  }

  void _showFilterDialog(String? selectedLanguage, String? selectedCountry) {
    showDialog(
      context: context,
      builder: (context) {
        String? language = selectedLanguage;
        String? country = selectedCountry;

        return AlertDialog(
          title: Text('Filter Search'),
          content: SingleChildScrollView(
            child: Container(
              width:MediaQuery.of(context).size.width * 0.8,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  DropdownButtonFormField<dynamic>(
                    value: language,
                    decoration: InputDecoration(labelText: 'Language'),
                    items: languages!.map((lang) {
                      return DropdownMenuItem(
                        value: lang['id'].toString(),
                        child: Text(lang['name']),
                      );
                    }).toList(),
                    onChanged: (value) {
                      _movieSearchBloc.add(ChangeLanguage(value));
                      language = value;
                    },
                  ),
                  SizedBox(height: 15),
                  DropdownButtonFormField<dynamic>(
                    value: country,
                    decoration: InputDecoration(labelText: 'Country'),
                    items: countries!.map((country) {
                      return DropdownMenuItem(
                        value: country['id'].toString(),
                        child: Text(country['name']),
                      );
                    }).toList(),
                    onChanged: (value) {
                      _movieSearchBloc.add(ChangeCountry(value));
                      country = value;
                    },
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel' , style: TextStyle(color: Colors.red),),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _movieSearchBloc.add(ApplyFilters(
                  _searchController.text,
                  language,
                  country,
                ));
                if (_searchController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Please Enter Text in the Search Field'),
                  ));
                }
              },
              child: Text('Apply' ,style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{ 
       Navigator.of(context).pushNamedAndRemoveUntil('/bottomNavigation', (route) => false);
       return true;
       },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Search Movies'),
        ),
        body: BlocProvider(
          create: (context) => _movieSearchBloc,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      width: 330,
                      child: TextField(
                        cursorColor: Colors.red,
                        controller: _searchController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16)),
                          labelText: 'Search',
                          suffixIcon: IconButton(
                            onPressed: () {
                              final query = _searchController.text;
                              _movieSearchBloc.add(PerformSearch(query));
                            },
                            icon: Icon(Icons.search),
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.filter_alt),
                      onPressed: () {
                        _movieSearchBloc
                            .add(ShowFilterDialog(_searchController.text));
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: BlocBuilder<MovieSearchBloc, MovieSearchState>(
                      builder: (context, state) {
                    if (state is MovieSearchLoading) {
                      ThemeData theme = Theme.of(context);
      
                      if (theme.brightness == Brightness.light) {
                        return Center(
                          child: Lottie.asset(
                            "assets/loader.json",
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                        );
                      } else {
                        return Center(
                          child: Lottie.asset(
                            "assets/loader2.json",
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                        );
                      }
                    } else if (state is MovieSearchLoaded) {
                      return NotificationListener<ScrollNotification>(
                        onNotification: (notification) {
                          if (notification is ScrollEndNotification &&
                              _scrollController.position.extentAfter == 0) {
                            _movieSearchBloc
                                .add(LoadMoreResults(_searchController.text));
                          }
                          return false;
                        },
                        child: ListView.builder(
                            controller: _scrollController,
                            itemCount: state.searchResult.length +
                                (state.hasReachedEnd ? 0 : 1),
                            itemBuilder: (context, index) {
                              if (index >= state.searchResult.length) {
                                ThemeData theme = Theme.of(context);
      
                                if (theme.brightness == Brightness.light) {
                                  return Center(
                                    child: Lottie.asset(
                                      "assets/loader.json",
                                      width: 100,
                                      height: 100,
                                      fit: BoxFit.cover,
                                    ),
                                  );
                                } else {
                                  return Center(
                                    child: Lottie.asset(
                                      "assets/loader2.json",
                                      width: 100,
                                      height: 100,
                                      fit: BoxFit.cover,
                                    ),
                                  );
                                }
                              } else {
                                final movie = state.searchResult[index];
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                MovieDetailScreen(
                                                    movieId: movie['tvdb_id'])));
                                  },
                                  child: MovieItem(
                                    searchResult: movie,
                                  ),
                                );
                              }
                            }),
                      );
                    } else if (state is MovieSearchError) {
                      return Center(child: Text(state.message));
                      //Center(child: Text('No Result Found'));
                    } else if (state is MovieSearchShowFilterDialog) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        _showFilterDialog(state.language, state.country);
                      });
                      return Container();
                    } else {
                      return SizedBox();
                    }
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
