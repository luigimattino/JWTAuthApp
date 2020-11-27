import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import '../../models/model.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AuthStarted extends AuthEvent {}

class AuthRefresh extends AuthEvent {}

class AuthLoggedIn extends AuthEvent {
  final AuthResponse authResponse;

  AuthLoggedIn({@required this.authResponse});

  @override
  List<Object> get props => [authResponse];
}

class AuthLoggedOut extends AuthEvent {}
