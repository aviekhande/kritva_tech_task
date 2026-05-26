// import 'dart:async';
// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

// class NetworkService {
//   static Stream<bool> observeNetwork() {
//     return Connectivity().onConnectivityChanged.asyncMap((
//       List<ConnectivityResult> results,
//     ) async {
//       final ConnectivityResult result = results.first;
//       return result != ConnectivityResult.none &&
//           await InternetConnection().hasInternetAccess;
//     });
//   }
// }
