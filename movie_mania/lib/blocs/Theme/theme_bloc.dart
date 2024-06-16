import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:movie_mania/blocs/Theme/theme_event.dart';
import 'package:movie_mania/blocs/Theme/theme_state.dart';

class ThemeBloc extends HydratedBloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(LightTheme()) {
    on<ToggleTheme>(_onToggleTheme);
  }

  void _onToggleTheme(ToggleTheme event, Emitter<ThemeState> emit) {
    emit(state is LightTheme ? DarkTheme() : LightTheme());
  }

  @override
  ThemeState fromJson(Map<String, dynamic> json) {
    return json['isDarkTheme'] as bool ? DarkTheme() : LightTheme();
  }

  @override
  Map<String, dynamic> toJson(ThemeState state) {
    return {'isDarkTheme': state is DarkTheme};
  }
}
