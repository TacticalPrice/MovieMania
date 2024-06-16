import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:movie_mania/blocs/Theme/theme_bloc.dart';
import 'package:movie_mania/blocs/Theme/theme_event.dart';
import 'package:movie_mania/blocs/Theme/theme_state.dart';
import 'package:movie_mania/blocs/local_strorage/local_storage_bloc.dart';
import 'package:movie_mania/blocs/local_strorage/local_storage_event.dart';
import 'package:movie_mania/blocs/local_strorage/local_storage_state.dart';
import 'package:movie_mania/blocs/localisation/localisation_bloc.dart';
import 'package:movie_mania/blocs/localisation/localisation_event.dart';
import 'package:movie_mania/blocs/localisation/localisation_state.dart';
import 'package:movie_mania/blocs/search/search_bloc.dart';
import 'package:movie_mania/blocs/user/user_bloc.dart';
import 'package:movie_mania/blocs/user/user_event.dart';
import 'package:movie_mania/blocs/user/user_state.dart';
import 'package:movie_mania/services/user_service.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  late UserBloc _userBloc;

  final UserService userService = UserService();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _userBloc = UserBloc(userService: userService);
    _userBloc.add(FetchUserDetail());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('User Profile'),
          centerTitle: true,
        ),
        body:
            // BlocBuilder<LocalizationBloc, LocalizationState>(
            //   builder: (context, localizationState) {
            //     return
            BlocProvider(
          create: (context) => _userBloc,
          child: BlocBuilder<UserBloc, UserState>(
            builder: (context, state) {
              if (state is UserLoading) {
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
              } else if (state is UserLoaded) {
                final user = state.userDetail;

                // return BlocBuilder<LocalStorageBloc, LocalStorageState>(
                //   builder: (context, localStorageState) {
                //     if (localStorageState is LocalStorageLoaded) {
                //       final favoriteMovies = localStorageState.favoriteMovies;
                //       final watchListMovies = localStorageState.watchListMovies;
                //       final watchedMovies = localStorageState.watchedMovies;

                return Column(
                  children: [
                    ListTile(
                      leading: Text(
                        'Name',
                        style: TextStyle(fontSize: 14),
                      ),
                      trailing:
                          Text(user['name'], style: TextStyle(fontSize: 14)),
                    ),
                    ListTile(
                      leading: Text('UserId', style: TextStyle(fontSize: 14)),
                      trailing:
                          Text('${user['id']}', style: TextStyle(fontSize: 14)),
                    ),
                    ListTile(
                      leading:
                          Text('Theme Change', style: TextStyle(fontSize: 14)),
                      trailing: BlocBuilder<ThemeBloc, ThemeState>(
                        builder: (context, themeState) {
                          return Switch(
                            value: themeState is DarkTheme,
                            onChanged: (value) {
                              BlocProvider.of<ThemeBloc>(context)
                                  .add(ToggleTheme());
                            },
                          );
                        },
                      ),
                    ),

                    BlocBuilder<LocalStorageBloc, LocalStorageState>(
                      builder: (context, localStorageState) {
                        List<String> favoriteMovies = [];
                        if (localStorageState is LocalStorageLoaded) {
                          favoriteMovies = localStorageState.favoriteMovies;
                        }
                        return Container(
                          height: 200,
                          child: ListView.builder(
                            itemCount: favoriteMovies.length,
                            itemBuilder: (context, index) {
                              final movieId = favoriteMovies[index];
                              return ListTile(
                                title: Text('Movie ID: $movieId'),
                                trailing: IconButton(
                                  icon: Icon(Icons.delete),
                                  onPressed: () {
                                    BlocProvider.of<LocalStorageBloc>(context)
                                        .add(RemoveFromFavorites(movieId));
                                  },
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
                    // ListTile(
                    //   leading: Text('Favorite Movies'),
                    //   trailing: IconButton(
                    //     icon: Icon(favoriteMovies.contains(user['id'])
                    //         ? Icons.favorite
                    //         : Icons.favorite_border),
                    //     onPressed: () {
                    //       if (favoriteMovies.contains(user['id'])) {
                    //         BlocProvider.of<LocalStorageBloc>(context)
                    //             .add(RemoveFromFavorites(user['id']));
                    //       } else {
                    //         BlocProvider.of<LocalStorageBloc>(context)
                    //             .add(AddToFavorites(user['id']));
                    //       }
                    //     },
                    //   ),
                    // ),
                    // ListTile(
                    //   leading: Text('Watch List'),
                    //   trailing: IconButton(
                    //     icon: Icon(watchListMovies.contains(user['id'])
                    //         ? Icons.check_box
                    //         : Icons.check_box_outline_blank),
                    //     onPressed: () {
                    //       if (watchListMovies.contains(user['id'])) {
                    //         BlocProvider.of<LocalStorageBloc>(context)
                    //             .add(RemoveFromWatchList(user['id']));
                    //       } else {
                    //         BlocProvider.of<LocalStorageBloc>(context)
                    //             .add(AddToWatchList(user['id']));
                    //       }
                    //     },
                    //   ),
                    // ),
                    // ListTile(
                    //   leading: Text('Watched Movies'),
                    //   trailing: IconButton(
                    //     icon: Icon(watchedMovies.contains(user['id'])
                    //         ? Icons.visibility
                    //         : Icons.visibility_off),
                    //     onPressed: () {
                    //       if (watchedMovies.contains(user['id'])) {
                    //         BlocProvider.of<LocalStorageBloc>(context)
                    //             .add(RemoveFromWatched(user['id']));
                    //       } else {
                    //         BlocProvider.of<LocalStorageBloc>(context)
                    //             .add(AddToWatched(user['id']));
                    //       }
                    //     },
                    //   ),
                    // ),
                  ],
                );
                //}
                // else{
                //   return Center(child: CircularProgressIndicator(),);
                // }
                //   },
                // );
              } else if (state is UserError) {
                return Text(state.message);
              } else {
                return Text('Unknown State');
              }
            },
          ),
        )
        //   },
        // ),
        );
  }

  @override
  void dispose() {
    _userBloc.close();
    super.dispose();
  }
}
