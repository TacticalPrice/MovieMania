import 'package:bloc/bloc.dart';
import 'package:movie_mania/services/auth_service.dart';

abstract class AuthEvent{}

class AppStarted extends AuthEvent {}

abstract class AuthState {}

class AuthInitial extends AuthState {}

class Authenticated extends AuthState {}

class AuthenticationFailed extends AuthState {}

class AuthBloc extends Bloc<AuthEvent , AuthState>{
  final AuthService _authService = AuthService();

  AuthBloc() : super(AuthInitial());

  @override 
  Stream<AuthState>mapEventToState(AuthEvent event) async* {
    if(event is AppStarted)
    {
      try{
        final token = await _authService.fetchBearerToken('Api_key');
        yield Authenticated();
      }catch(_){
        yield AuthenticationFailed();
      }
    }
  }
}