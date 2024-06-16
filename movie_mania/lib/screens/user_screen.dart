import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
      body: BlocProvider(
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
                  )
                ],
              );
            } else if (state is UserError) {
              return Text(state.message);
            } else {
              return Text('Unknown State');
            }
          },
        ),
      ),
    );
  }
}
