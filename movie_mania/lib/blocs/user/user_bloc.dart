import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_mania/blocs/user/user_event.dart';
import 'package:movie_mania/blocs/user/user_state.dart';
import 'package:movie_mania/services/user_service.dart';

class UserBloc extends Bloc<UserEvent , UserState>{
  final UserService userService;
   UserBloc({required this.userService}) : super(UserInitial()){
    on<FetchUserDetail>(_onFetchUserDetail);
  }

  void _onFetchUserDetail(FetchUserDetail event , Emitter<UserState> emit) async {
    emit(UserLoading());
    try{
      final userDetail = await userService.fetchUser();

      emit(UserLoaded(userDetail: userDetail));
    }catch(e){
      emit(UserError(e.toString()));
    }
  }

}