import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_mania/blocs/localisation/localisation_event.dart';
import 'package:movie_mania/blocs/localisation/localisation_state.dart';

class LocalizationBloc extends Bloc<LocalizationEvent, LocalizationState> {
  LocalizationBloc() : super(LocalizationLoaded('en')){
    on<ChangeLocalization>(_onChangeLanguage);
  }


   void _onChangeLanguage(ChangeLocalization event, Emitter<LocalizationState> emit) {
     emit(LocalizationLoaded(event.languageCode));
  }
  
}