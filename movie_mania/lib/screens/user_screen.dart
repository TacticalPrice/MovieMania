import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:movie_mania/blocs/Theme/theme_bloc.dart';
import 'package:movie_mania/blocs/Theme/theme_event.dart';
import 'package:movie_mania/blocs/Theme/theme_state.dart';
import 'package:movie_mania/blocs/search/search_bloc.dart';
import 'package:movie_mania/blocs/user/user_bloc.dart';
import 'package:movie_mania/blocs/user/user_event.dart';
import 'package:movie_mania/blocs/user/user_state.dart';
import 'package:movie_mania/screens/favorite_screen.dart';
import 'package:movie_mania/screens/language_change.dart';
import 'package:movie_mania/screens/watch_list_screen.dart';
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
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context)
            .pushNamedAndRemoveUntil('/bottomNavigation', (route) => false);
        return true;
      },
      child: Scaffold(
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
                        trailing: Text('${user['id']}',
                            style: TextStyle(fontSize: 14)),
                      ),
                      ListTile(
                        leading: Text('Theme Change',
                            style: TextStyle(fontSize: 14)),
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
                      ListTile(
                        leading: Text(
                          'Favorites Movies',
                          style: TextStyle(fontSize: 14),
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => FavoritesScreen()));
                        },
                      ),
                      ListTile(
                        leading: Text(
                          'WatchList',
                          style: TextStyle(fontSize: 14),
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => WatchListScreen()));
                        },
                      ),
                      // ListTile(
                      //   leading: Text(
                      //     'Langage Change',
                      //     style: TextStyle(fontSize: 14),
                      //   ),
                      //   onTap: () {
                      //     Navigator.push(
                      //         context,
                      //         MaterialPageRoute(
                      //             builder: (context) => LanguageChange()));
                      //   },
                      // ),
                    ],
                  );
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
          ),
    );
  }

  @override
  void dispose() {
    _userBloc.close();
    super.dispose();
  }
}
