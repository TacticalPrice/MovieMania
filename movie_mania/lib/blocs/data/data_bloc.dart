import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_mania/blocs/data/data_event.dart';
import 'package:movie_mania/blocs/data/data_state.dart';
import 'package:movie_mania/services/user_service.dart';

class DataBloc extends Bloc<DataEvent , DataState> {
  final UserService userService;

  DataBloc(this.userService) : super(DataInitial()){
    on<FetchLanguages>(_onFetchLanguages);
    on<FetchCountries>(_onFetchCountries);
  }

  void _onFetchCountries (FetchCountries event ,Emitter<DataState> emit) async {
    emit(LanguageLoading());
    try{
      final result = await userService.fetchCountries();
      emit(CountriesLoaded(result));
    }catch(e){
      emit(DataError(e.toString()));
    }

  }

  void _onFetchLanguages (FetchLanguages event ,Emitter<DataState> emit) async {
    emit(CountriesLoading());
    try{
      final result = await userService.fetchLanguages();
      emit(LanguagesLoaded(result));
    }catch(e){
      emit(DataError(e.toString()));
    }

  }


  
}