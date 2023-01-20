import 'package:detailmanagement/main.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
abstract class User_state extends Equatable {}

class UserLoad extends User_state {
  @override
  List<Object?> get props => [];
}

class UserLoaded extends User_state {
  final List<Model> details;
  UserLoaded(this.details);
  @override
  List<Object?> get props => [details];
}

class UserSelected extends User_state {
  final Model details;
  UserSelected(this.details);
  @override
  List<Object?> get props => [details];
}

class UserError extends User_state {
  final String ErrorMsg;
  UserError(this.ErrorMsg);
  @override
  List<Object?> get props => [ErrorMsg];
}
