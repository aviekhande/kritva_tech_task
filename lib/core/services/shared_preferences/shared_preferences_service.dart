import 'dart:convert';
import 'dart:developer';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  final SharedPreferences _prefs;

  SharedPreferencesService(this._prefs);

  static const String _keyUsers = 'registered_users';
  static const String _keyCurrentUser = 'current_user';

  // ── User Registration ────────────────────────────────────────────────────

  Future<void> registerUser(String phone, String password) async {
    final users = getAllUsers();
    users[phone] = password;
    await _prefs.setString(_keyUsers, jsonEncode(users));
    log('User registered: $phone');
  }

  bool phoneExists(String phone) {
    return getAllUsers().containsKey(phone);
  }

  Map<String, String> getAllUsers() {
    final raw = _prefs.getString(_keyUsers);
    if (raw == null) return {};
    final decoded = jsonDecode(raw) as Map<String, dynamic>;
    return decoded.map((k, v) => MapEntry(k, v.toString()));
  }

  String? getPasswordForPhone(String phone) {
    return getAllUsers()[phone];
  }

  // ── Session ──────────────────────────────────────────────────────────────

  Future<void> saveCurrentUser(String phone) async {
    await _prefs.setString(_keyCurrentUser, phone);
    log('Session saved for: $phone');
  }

  String? getCurrentUser() {
    return _prefs.getString(_keyCurrentUser);
  }

  Future<void> clearCurrentUser() async {
    await _prefs.remove(_keyCurrentUser);
    log('Session cleared');
  }

  bool get isLoggedIn => getCurrentUser() != null;
}
