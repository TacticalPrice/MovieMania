import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:movie_mania/blocs/auth_bloc.dart';
import 'package:movie_mania/screens/home_screen.dart';
import 'package:movie_mania/widgets/bottom_navigation.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is Authenticated) {
            Future.delayed(Duration(seconds: 4), () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => BottomNavigation()));
            });
          } else if (state is AuthenticationFailed) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text('Authentication Failed')));
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
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
            return Center(child: Image.asset('assets/popcorn.png'));
          }
        },
      ),
    );
  }
}
