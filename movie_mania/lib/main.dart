import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:movie_mania/blocs/Theme/theme_bloc.dart';
import 'package:movie_mania/blocs/Theme/theme_state.dart';
import 'package:movie_mania/blocs/auth_bloc.dart';
import 'package:movie_mania/blocs/favorite/favorite_bloc.dart';
import 'package:movie_mania/blocs/watchlist/watchlist_bloc.dart';
import 'package:movie_mania/constants/themes.dart';
import 'package:movie_mania/screens/home_screen.dart';
import 'package:movie_mania/screens/search_screen.dart';
import 'package:movie_mania/screens/splash_screen.dart';
import 'package:movie_mania/widgets/bottom_navigation.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('movies');
  final storage = await HydratedStorage.build(
      storageDirectory: await getApplicationDocumentsDirectory());

  HydratedBloc.storage = storage;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) {
            final authBloc = AuthBloc();
            authBloc.add(AppStarted());
            return authBloc;
          },
        ),
        BlocProvider<ThemeBloc>(
          create: (context) => ThemeBloc(),
        ),
        BlocProvider(create: (_) => FavoritesBloc()),
        BlocProvider(create: (_) => WatchlistBloc()),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, themeState) {
          // return BlocBuilder<LocalizationBloc, LocalizationState>(
          //   builder: (context, state) {
          return MaterialApp(
            title: 'Movie Mania',
            theme: themeState is LightTheme ? lightTheme : darkTheme,
            darkTheme: darkTheme,
            themeMode:
                themeState is LightTheme ? ThemeMode.light : ThemeMode.dark,
            home: SplashScreen(),
            routes: {
              '/home': (context) => HomeScreen(),
              '/search': (context) => SearchScreen(),
              '/bottomNavigation' : (context) => BottomNavigation()
            },
          );
          //   },
          // );
        },
      ),
    );
  }
}
