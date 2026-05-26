// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class SharedPreferencesService {
//   final SharedPreferences _sharedPreferences;

//   SharedPreferencesService(this._sharedPreferences);

//   Future<void> saveToken(String accessToken) async {
//     await _sharedPreferences.setString("accessToken", accessToken);
//   }

//   Future<String?> getToken() async {
//     debugPrint("getting token");
//     return _sharedPreferences.getString("accessToken");
//   }

//   Future<bool?> deleteToken() async {
//     debugPrint("delete token");

//     return _sharedPreferences.remove("accessToken");
//   }

//    Future<void> setUserPreviouslyLoggedIn() async {
//     await _sharedPreferences.setBool('userPreviouslyLoggedIn', true);
//   }

//   Future<bool> isUserPreviouslyLoggedIn() async {
//     return _sharedPreferences.getBool('userPreviouslyLoggedIn') ?? false;
//   }
// }
