import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../../../core/exceptions/server_exception.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;

  AuthBloc(this._authRepository) : super(const AuthInitial()) {
    on<AuthLoginRequested>(_onLogin);
    on<AuthRegisterRequested>(_onRegister);
    on<AuthLogoutRequested>(_onLogout);
  }

  Future<void> _onLogin(
    AuthLoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());
    try {
      await _authRepository.login(
        phone: event.phone,
        password: event.password,
      );
      emit(AuthLoginSuccess(event.phone));
    } on ServerException catch (e) {
      emit(AuthFailure(e.message));
    } catch (e) {
      log('AuthBloc login error: $e');
      emit(const AuthFailure('Something went wrong. Please try again.'));
    }
  }

  Future<void> _onRegister(
    AuthRegisterRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());
    try {
      await _authRepository.register(
        phone: event.phone,
        password: event.password,
      );
      emit(const AuthRegisterSuccess());
    } on ServerException catch (e) {
      emit(AuthFailure(e.message));
    } catch (e) {
      log('AuthBloc register error: $e');
      emit(const AuthFailure('Something went wrong. Please try again.'));
    }
  }

  Future<void> _onLogout(
    AuthLogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());
    try {
      await _authRepository.logout();
      emit(const AuthLogoutSuccess());
    } catch (e) {
      log('AuthBloc logout error: $e');
      emit(const AuthLogoutSuccess()); // Always logout even on error
    }
  }
}
