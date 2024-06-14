import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_mania/blocs/auth_bloc.dart';
import 'package:movie_mania/screens/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc()..add(AppStarted()),
    child: Scaffold(
      body: Center(
        child: BlocListener<AuthBloc , AuthState>(
          listener: (context ,state){
            if(state is Authenticated){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
            }
            if(state is AuthenticationFailed){
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Authentication Failed'))
              );
            }
          },
          child: CircularProgressIndicator(),
        ),
      ),
    ),
    );
  }
}