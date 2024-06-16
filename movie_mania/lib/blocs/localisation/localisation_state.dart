import 'package:equatable/equatable.dart';

abstract class LocalizationState extends Equatable {
  @override
  List<Object?> get props => [];
}

class LocalizationLoaded extends LocalizationState {
  final String languageCode;

  LocalizationLoaded(this.languageCode);

  @override
  List<Object?> get props => [languageCode];
}