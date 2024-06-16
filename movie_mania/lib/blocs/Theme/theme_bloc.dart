import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_mania/blocs/Theme/theme_event.dart';
import 'package:movie_mania/blocs/Theme/theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent , ThemeState>{
  ThemeBloc() : super(LightTheme()){
    on<ToggleTheme>(_onToggleTheme);
  }
  
   void _onToggleTheme(ToggleTheme event, Emitter<ThemeState> emit) {
    emit(state is LightTheme ? DarkTheme() : LightTheme());
  }

}