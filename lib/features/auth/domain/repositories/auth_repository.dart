abstract class AuthRepository {
  Future<void> register({required String phone, required String password});

  Future<void> login({required String phone, required String password});

  Future<void> logout();

  String? getCurrentUserPhone();

  bool get isLoggedIn;
}
