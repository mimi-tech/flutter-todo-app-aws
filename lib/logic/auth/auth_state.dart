import 'dart:convert';

import 'package:equatable/equatable.dart';



abstract class AuthState extends Equatable {
  const AuthState([List props = const []]): super();
}

class AuthInitial extends AuthState {
  @override
  List<Object> get props =>[];
}


class AuthGeneral extends AuthState {
  @override
  List<Object> get props =>[];
}

class AuthAuthenticated extends AuthState {
  @override
  List<Object> get props =>[];
}


class AuthLoading extends AuthState {
  @override
  List<Object> get props => [];
}

class AuthDenied extends AuthState {
  final String errors;
  const AuthDenied(this.errors);

  @override
  List<Object> get props => [errors];
}

class AuthSuccess extends AuthState {
  // final List<String> success;
  // const AuthSuccess(this.success);

  @override
  List<Object> get props => [];
}


