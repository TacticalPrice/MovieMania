import 'package:bloc/bloc.dart';
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
    emit(AuthLoading());
    try{
      await _authService.fetchBearerToken('455049ec-a1ac-4018-80d1-4a9c9008f053' , 'pin');
      emit(Authenticated());
    }catch(e){
      print(e);
      emit(AuthenticationFailed());
    }
  }
}
