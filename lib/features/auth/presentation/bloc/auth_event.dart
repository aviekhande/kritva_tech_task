part of 'auth_bloc.dart';

abstract class AuthEvent {
  const AuthEvent();
}

class AuthLoginRequested extends AuthEvent {
  final String phone;
  final String password;

  const AuthLoginRequested({required this.phone, required this.password});
}

class AuthRegisterRequested extends AuthEvent {
  final String phone;
  final String password;

  const AuthRegisterRequested({required this.phone, required this.password});
}

class AuthLogoutRequested extends AuthEvent {
  const AuthLogoutRequested();
}
