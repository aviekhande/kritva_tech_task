import '../../domain/repositories/auth_repository.dart';
import '../../../../core/exceptions/server_exception.dart';
import '../../../../core/services/shared_preferences/shared_preferences_service.dart';

class AuthRepositoryImpl implements AuthRepository {
  final SharedPreferencesService _prefs;

  const AuthRepositoryImpl(this._prefs);

  @override
  Future<void> register({
    required String phone,
    required String password,
  }) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 600));

    if (_prefs.phoneExists(phone)) {
      throw const ServerException('Phone number already registered.');
    }

    await _prefs.registerUser(phone, password);
  }

  @override
  Future<void> login({
    required String phone,
    required String password,
  }) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 600));

    final storedPassword = _prefs.getPasswordForPhone(phone);

    if (storedPassword == null || storedPassword != password) {
      throw const ServerException('Invalid phone number or password.');
    }

    await _prefs.saveCurrentUser(phone);
  }

  @override
  Future<void> logout() async {
    await _prefs.clearCurrentUser();
  }

  @override
  String? getCurrentUserPhone() => _prefs.getCurrentUser();

  @override
  bool get isLoggedIn => _prefs.isLoggedIn;
}
