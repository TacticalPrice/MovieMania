import 'package:equatable/equatable.dart';

abstract class UserState extends Equatable {
  @override 
  List<Object?> get props => [];
}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserLoaded extends UserState {
  final Map<String ,dynamic> userDetail;

  UserLoaded({required this.userDetail});

  @override 
  List<Object?>get props => [userDetail];
}

class UserError extends UserState {
  final String message;
  UserError(this.message);

  @override 
  List<Object?> get props => [message];
}