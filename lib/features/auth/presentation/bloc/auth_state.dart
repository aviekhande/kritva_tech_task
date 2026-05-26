part of 'auth_bloc.dart';

abstract class AuthState {
  const AuthState();
}

class AuthInitial extends AuthState {
  const AuthInitial();
}

class AuthLoading extends AuthState {
  const AuthLoading();
}

class AuthLoginSuccess extends AuthState {
  final String phone;
  const AuthLoginSuccess(this.phone);
}

class AuthRegisterSuccess extends AuthState {
  const AuthRegisterSuccess();
}

class AuthLogoutSuccess extends AuthState {
  const AuthLogoutSuccess();
}

class AuthFailure extends AuthState {
  final String message;
  const AuthFailure(this.message);
}
