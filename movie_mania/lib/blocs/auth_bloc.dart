import 'package:bloc/bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:movie_mania/services/auth_service.dart';

abstract class AuthEvent {}

class AppStarted extends AuthEvent {}

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class Authenticated extends AuthState {}

class AuthenticationFailed extends AuthState {}

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthService _authService = AuthService();

  AuthBloc() : super(AuthInitial()){
    on<AppStarted>(_onAppStarted);
  }

  
  void _onAppStarted (AppStarted event , Emitter<AuthState> emit) async {
    final String apiKey = dotenv.env['API_KEY'] ?? '';
    print(apiKey);
    emit(AuthLoading());
    try{
      await _authService.fetchBearerToken(apiKey , 'pin');
      emit(Authenticated());
    }catch(e){
      print(e);
      emit(AuthenticationFailed());
    }
  }
}
