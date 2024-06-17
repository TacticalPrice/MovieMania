import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';


abstract class LocalizationEvent extends Equatable {
  const LocalizationEvent();

  @override
  List<Object> get props => [];
}

class LocaleChanged extends LocalizationEvent {
  final Locale locale;

  const LocaleChanged(this.locale);

  @override
  List<Object> get props => [locale];
}

class LocalizationState extends Equatable {
  final Locale locale;

  const LocalizationState(this.locale);

  @override
  List<Object> get props => [locale];
}


class LocalizationBloc extends Bloc<LocalizationEvent, LocalizationState> {
  LocalizationBloc() : super(LocalizationState(Locale(dotenv.env['DEFAULT_LOCALE'] ?? 'en'))) {
    on<LocaleChanged>(_onLocaleChanged);
  }

  void _onLocaleChanged(LocaleChanged event, Emitter<LocalizationState> emit) {
    emit(LocalizationState(event.locale));
  }
}
