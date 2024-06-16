import 'package:equatable/equatable.dart';

abstract class LocalizationEvent extends Equatable {
  const LocalizationEvent();

  @override
  List<Object?> get props => [];
}

class ChangeLocalization extends LocalizationEvent {
  final String languageCode;

  const ChangeLocalization(this.languageCode);

  @override
  List<Object?> get props => [languageCode];
}
