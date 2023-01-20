import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
abstract class User_Event extends Equatable {
  const User_Event();
}

class Load_Event extends User_Event {
  @override
  List<Object> get props => [];
}
