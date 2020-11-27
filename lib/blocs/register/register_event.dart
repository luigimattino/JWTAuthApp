import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class RegisterEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class RegisterWithEmailAndPasswordButtonPressed extends RegisterEvent {
  final String email;
  final String password;

  RegisterWithEmailAndPasswordButtonPressed(
      {@required this.email, @required this.password});

  @override
  List<Object> get props => [email, password];
}
