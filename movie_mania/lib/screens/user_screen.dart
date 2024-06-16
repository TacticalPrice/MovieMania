import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_mania/blocs/Theme/theme_bloc.dart';
import 'package:movie_mania/blocs/Theme/theme_event.dart';
import 'package:movie_mania/blocs/Theme/theme_state.dart';
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
        actions: [
          BlocBuilder<ThemeBloc, ThemeState>(
            builder: (context, themeState) {
              return IconButton(
                icon: Icon(themeState is LightTheme
                    ? Icons.nightlight_round
                    : Icons
                        .wb_sunny), // Icon for theme toggle based on current theme state
                onPressed: () {
                  BlocProvider.of<ThemeBloc>(context).add(ToggleTheme());
                },
              );
            },
          ),
        ],
      ),
      body: BlocBuilder<LocalizationBloc, LocalizationState>(
        builder: (context, localizationState) {
          return BlocProvider(
            create: (context) => _userBloc,
            child: BlocBuilder<UserBloc, UserState>(
              builder: (context, state) {
                if (state is UserLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is UserLoaded) {
                  final user = state.userDetail;
                  return Column(
                    children: [
                      ListTile(
                        leading: Text('Name'),
                        trailing: Text(user['name']),
                      ),
                      ListTile(
                        leading: Text('UserId'),
                        trailing: Text('${user['id']}'),
                      ),
                      // ListTile(
                      //   leading: Text('Language'),
                      //   trailing: DropdownButton<String>(
                      //     value: localizationState is LocalizationLoaded
                      //         ? localizationState.languageCode
                      //         : 'en', // Default to 'en' or your app's default language
                      //     items: [
                      //       DropdownMenuItem(
                      //           value: 'en', child: Text('English')),
                      //     ],
                      //     onChanged: (value) {
                      //       BlocProvider.of<LocalizationBloc>(context)
                      //           .add(ChangeLocalization(value!));
                      //     },
                      //   ),
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
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _userBloc.close();
    super.dispose();
  }
}
