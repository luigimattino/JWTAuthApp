import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {
  AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthSuccess extends AuthState {}

class AuthRefreshed extends AuthState {}

class AuthFailure extends AuthState {}
