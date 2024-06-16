import 'package:equatable/equatable.dart';

abstract class UserEvent extends Equatable{
  @override 
  List<Object?> get props => [];

}

class FetchUserDetail extends UserEvent {

  FetchUserDetail();

  @override 
  List<Object?> get props => [];
}