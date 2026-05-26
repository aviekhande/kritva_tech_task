// import 'dart:io';
// import 'package:caesar_cipher/core/config/app_config.dart';
// import 'package:caesar_cipher/core/services/shared_preferences/shared_preferences_service.dart';
// import 'package:caesar_cipher/core/utils/utils.dart';
// import 'package:caesar_cipher/init_dependencies.dart';
// import 'package:flutter/material.dart';

// class AppHeaders {
//   final sharedPrefsService = serviceLocator<SharedPreferencesService>();
//   static String? applicationVersion;

//   Future<Map<String, String>> getHeaders({
//     String acceptType = 'application/json',
//   }) async {
//     String basicAuth = await Utils.authHeader();
//     String acceptedLanguages = AppConfig.acceptedLanguage;
//     String platform = Platform.operatingSystem;
//     applicationVersion = await Utils.getAppVersion();
//     String? accessToken = await sharedPrefsService.getToken();
//     dynamic deviceId = await Utils().getDeviceId();
//     debugPrint("deviceId:$deviceId");
//     // debugPrint("App Version: $applicationVersion");

//     return accessToken == null || accessToken.isEmpty
//         ? {
//             'authorization': basicAuth,
//             'Accept-Language': acceptedLanguages,
//             'platform': platform,
//             'uuid': deviceId ?? '1234',
//             'version': applicationVersion!,
//             'Accept': acceptType,
//           }
//         : {
//             'authorization': basicAuth,
//             'Accept-Language': acceptedLanguages,
//             'Bearer': "Bearer $accessToken",
//             'platform': platform,
//             'uuid': deviceId ?? '1234',
//             'version': applicationVersion!,
//             'Accept': acceptType,
//           };
//   }
// }
