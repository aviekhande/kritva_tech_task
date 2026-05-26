// import 'dart:convert';
// import 'dart:developer';
// import 'dart:io';
// import 'dart:math' as math;
// import 'dart:typed_data';
// import 'package:caesar_cipher/core/config/app_config.dart';
// import 'package:caesar_cipher/core/services/network/bloc/network_bloc.dart';
// import 'package:caesar_cipher/core/theme/colors.dart';
// import 'package:caesar_cipher/core/theme/text_styles.dart';
// import 'package:device_info_plus/device_info_plus.dart';
// import 'package:dio/dio.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:intl/intl.dart';
// import 'package:mockito/mockito.dart';
// import 'package:package_info_plus/package_info_plus.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:permission_handler/permission_handler.dart' as AppSettings;
// import 'package:share_plus/share_plus.dart';
// import 'package:stomp_dart_client/stomp_dart_client.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:url_launcher/url_launcher_string.dart';
// import 'package:pointycastle/export.dart';

// import '../../features/chat_detail/presentation/bloc/chat_delete_bloc/chat_delete_bloc.dart';
// import '../../init_dependencies.dart';

// class Utils {
//   static Future<String> authHeader() async {
//     String basicAuth =
//         'Basic ${base64Encode(utf8.encode('${AppConfig.username}:${AppConfig.password}'))}';
//     return basicAuth;
//   }

//   static Future<String> getAppVersion() async {
//     PackageInfo? info = await PackageInfo.fromPlatform();
//     return info.version.toString();
//   }

//   Future<String?> getDeviceId() async {
//     DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
//     String? deviceId;
//     if (Platform.isAndroid) {
//       AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
//       deviceId = androidInfo.id.toString();
//     } else if (Platform.isIOS) {
//       IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
//       deviceId = iosInfo.identifierForVendor.toString();
//     }
//     return deviceId;
//   }

//   static Future<void> openDialer(String phoneNumber) async {
//     Uri callUrl = Uri.parse('tel:$phoneNumber');
//     if (await canLaunchUrl(callUrl)) {
//       await launchUrl(callUrl);
//     } else {
//       throw 'Could not open the dialler.';
//     }
//   }

//   static InterceptorsWrapper getLoggingInterceptor() {
//     int count = 0;
//     return InterceptorsWrapper(
//       onRequest: (options, handler) {
//         count++;

//         debugPrint(
//           '${AppColors.cyan}Request[${options.method}] => PATH: ${options.path}$reset',
//         );
//         debugPrint(
//           '${AppColors.white}Request HEADERS: ${options.headers}$reset',
//         );
//         debugPrint(
//           '${AppColors.orange}Request QUERY PARAMETERS: ${options.queryParameters}$reset',
//         );
//         debugPrint(
//           '${AppColors.orange}Request QUERY PARAMETERS: ${options.queryParameters}$reset',
//         );
//         debugPrint('${AppColors.yellow}Request DATA: ${options.data}$reset');
//         debugPrint('${AppColors.magenta}API call count: $count');
//         return handler.next(options);
//       },
//       onResponse: (response, handler) {
//         debugPrint(
//           '${AppColors.green}Response[${response.statusCode}] => DATA: ${response.data}$reset',
//         );
//         return handler.next(response);
//       },
//       onError: (DioException e, handler) {
//         debugPrint("test error:}");
//         debugPrint(
//           '${AppColors.red}Error[${e.response?.statusCode}] => MESSAGE: ${e.message}$reset',
//         );
//         debugPrint('${AppColors.red}Error DATA: ${e.response?.data}$reset');
//         return handler.next(e);
//       },
//     );
//   }

//   static startListeningForChatDeletion(BuildContext context) async {
//     await Future.delayed(Duration(seconds: 1));
//     print("before initialize");
//     StompClient stompClient = serviceLocator<StompClient>();
//     print("stompClient ${stompClient.connected}");

//     try {
//       // // Wait for connection with timeout
//       // if (!stompClient.connected) {
//       //   await _reConnectWithStomp();
//       // }
//       stompClient.subscribe(
//         destination: '/user/queue/chat_deletion',
//         callback: (StompFrame frame) {
//           debugPrint("📩 Chat delete status: ${frame.body}");
//           try {
//             final result = json.decode(frame.body!);
//             debugPrint('✅ Chat deletion parsed data : ${result}');
//             if (result != null && result['success'] == 1) {
//               context.read<ChatDeleteBloc>().add(
//                 ChatDeletionEvent(
//                   chatRoomId: result['data'],
//                   message: result['message'],
//                 ),
//               );
//             }
//           } catch (e) {
//             debugPrint('❌ Error parsing received chat list: $e');
//           }
//         },
//       );
//       debugPrint('🎧 Started listening to /user/queue/chat_deletion');
//     } catch (e) {
//       debugPrint('❌ Error subscribing to chat_list: $e');
//     }
//   }

//   static String maskPhoneNumber({
//     required String phoneNumber,
//     required int digitsToMask,
//   }) {
//     String maskedNum = '';
//     for (int i = 0; i < phoneNumber.length; i++) {
//       //     print(number[i]);
//       if (i <= digitsToMask - 1) {
//         maskedNum = '${maskedNum}x';
//       } else {
//         maskedNum = maskedNum + phoneNumber[i];
//       }
//     }

//     return maskedNum;
//   }

//   // FOR NORMAL
//   static DateTime? parseDate(String? dateStr) {
//     if (dateStr == null || dateStr.isEmpty) {
//       return null;
//     }
//     return DateFormat('dd-MM-yyyy').parse(dateStr);
//   }
//   // From UTC to local DD-MM-YYYY
//   // static DateTime? parseDate(String? dateStr) {
//   //   if (dateStr == null || dateStr.isEmpty) {
//   //     return null;
//   //   }

//   //   try {
//   //     // Parse the UTC date string into a DateTime
//   //     DateTime utcDate = DateTime.parse(dateStr).toUtc();

//   //     // Convert to local time
//   //     DateTime localDate = utcDate.toLocal();

//   //     // Format to 'dd-MM-yyyy' string
//   //     String formatted = DateFormat('dd-MM-yyyy').format(localDate);

//   //     // Parse the formatted string back to DateTime
//   //     return DateFormat('dd-MM-yyyy').parse(formatted);
//   //   } catch (e) {
//   //     // Handle invalid date formats
//   //     return null;
//   //   }
//   // }

//   static DateTime getDateOnly(DateTime? dateTime) {
//     if (dateTime == null) return DateTime(1970);
//     return DateTime(dateTime.year, dateTime.month, dateTime.day);
//   }

//   static String formatDateHeader(DateTime date, {String? dateFormat}) {
//     final now = DateTime.now();
//     final today = DateTime(now.year, now.month, now.day);
//     final yesterday = today.subtract(Duration(days: 1));

//     if (date == today) {
//       return "Today";
//     } else if (date == yesterday) {
//       return "Yesterday";
//     } else {
//       return DateFormat(dateFormat ?? 'dd MMM yyyy').format(date);
//     }
//   }

//   Future<String?> openDatePicker(
//     BuildContext context,
//     int isValue,
//     String startDate,
//     String endDate,
//   ) async {
//     String date = "";
//     DateTime? pickedDate = await showDatePicker(
//       context: context,
//       initialDate: (startDate == "Start date" || endDate == "End date")
//           ? DateTime.now()
//           : isValue == 0
//           ? parseDate(startDate)
//           : parseDate(endDate),
//       firstDate: DateTime(2000),
//       lastDate: DateTime(2101),
//     );

//     date = DateFormat('dd-MM-yyyy').format(pickedDate!);
//     return date;
//   }

//   // pick image from gallary

//   static Future<File?> pickImage(bool fromGallery) async {
//     final image = await ImagePicker().pickImage(
//       source: fromGallery ? ImageSource.gallery : ImageSource.camera,
//       requestFullMetadata: false,
//     );

//     return image != null ? File(image.path) : null;
//   }

//   // Check Permissions
//   static Future<void> checkCameraPermission({
//     required VoidCallback onPermissionGranted,
//     required VoidCallback onPermissionDenied,
//     required VoidCallback onPermissionPermanentlyDenied,
//     bool isCamera = true,
//   }) async {
//     debugPrint("isCamera:$isCamera");
//     var status = isCamera
//         ? await Permission.camera.request()
//         : await Permission.location.request();
//     debugPrint("status:$status");
//     if (status.isGranted) {
//       onPermissionGranted();
//     } else if (status.isDenied) {
//       onPermissionDenied();
//     } else if (status.isPermanentlyDenied) {
//       onPermissionPermanentlyDenied();
//     }
//   }

//   static Future<bool> ensureLocationPermission() async {
//     // Check current location permission status
//     LocationPermission permission = await Geolocator.checkPermission();

//     if (permission == LocationPermission.deniedForever) {
//       // Permission is permanently denied, open app settings
//       openAppSettings();
//       return false;
//     } else if (permission == LocationPermission.denied) {
//       // Permission is denied but not permanently, request permission
//       PermissionStatus status = await Permission.location.request();

//       if (status.isGranted) {
//         return true;
//       } else {
//         return false;
//       }
//     } else if (permission == LocationPermission.whileInUse ||
//         permission == LocationPermission.always) {
//       // Permission is already granted
//       return true;
//     } else {
//       return false; // If any other case, return false
//     }
//   }

//   static void showSnackBar(
//     BuildContext context,
//     String? message, {
//     bool? isSuccess,
//     SnackBarBehavior? snackBarBehavior = SnackBarBehavior.fixed,
//   }) {
//     if (message == null) return;

//     if (Platform.isIOS) {
//       final overlay = Overlay.of(context, rootOverlay: true);

//       final overlayEntry = OverlayEntry(
//         builder: (context) => Positioned(
//           bottom: 40.0,
//           left: 16.0,
//           right: 16.0,
//           child: Material(
//             color: Colors.transparent,
//             child: Container(
//               decoration: BoxDecoration(
//                 color: isSuccess == true
//                     ? CupertinoColors.systemGreen.withOpacity(1)
//                     : CupertinoColors.systemRed.withOpacity(1),
//                 borderRadius: BorderRadius.circular(12.0),
//               ),
//               padding: EdgeInsets.symmetric(
//                 horizontal: 12.0.sp,
//                 vertical: 12.0.sp,
//               ),
//               child: Text(
//                 message,
//                 style: kTextStyleDMSans500.copyWith(
//                   fontSize: 16.0.sp,
//                   color: CupertinoColors.white,
//                 ),
//                 // textAlign: TextAlign.center,
//               ),
//             ),
//           ),
//         ),
//       );

//       overlay.insert(overlayEntry);

//       Future.delayed(const Duration(milliseconds: 2000), () {
//         if (overlayEntry.mounted) overlayEntry.remove();
//       });
//     } else {
//       ScaffoldMessenger.of(context)
//         ..hideCurrentSnackBar()
//         ..showSnackBar(
//           SnackBar(
//             content: SizedBox(
//               child: Align(
//                 alignment: Alignment.centerLeft,
//                 child: Text(
//                   message,
//                   style: kTextStyleDMSans500.copyWith(fontSize: 16.sp),
//                 ),
//               ),
//             ),
//             backgroundColor: isSuccess == true ? Colors.green : Colors.red,
//             duration: const Duration(milliseconds: 2000),
//             behavior: SnackBarBehavior.fixed,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(10.r),
//             ),
//           ),
//         );
//     }
//   }

//   static String formatDate(String backendDate) {
//     final DateTime parsedDate = DateTime.parse(backendDate);
//     final String day = DateFormat('d').format(parsedDate);
//     final String suffix = getDaySuffix(parsedDate.day);
//     final String month = DateFormat('MMM').format(parsedDate);
//     final String year = DateFormat('y').format(parsedDate);
//     return '$day$suffix $month $year';
//   }

//   static String convertFromDDMMYYToReadableFormat(String inputDate) {
//     final DateTime date = DateFormat('dd/MM/yyyy').parse(inputDate);
//     final String day = date.day.toString();
//     final String suffix = getDaySuffix(date.day);
//     final String month = DateFormat('MMMM').format(date); // "May"
//     final String year = date.year.toString();
//     return '$day$suffix $month $year';
//   }

//   static String getDaySuffix(int day) {
//     if (day >= 11 && day <= 13) {
//       return 'th';
//     }
//     switch (day % 10) {
//       case 1:
//         return 'st';
//       case 2:
//         return 'nd';
//       case 3:
//         return 'rd';
//       default:
//         return 'th';
//     }
//   }

//   static Color getContactAvatarColor(String name) {
//     if (name.isEmpty) return Color(0xFFF1A481);
//     final firstAlphabet = name[0].toUpperCase();

//     if (firstAlphabet == 'A' ||
//         firstAlphabet == 'F' ||
//         firstAlphabet == 'K' ||
//         firstAlphabet == 'P' ||
//         firstAlphabet == 'U' ||
//         firstAlphabet == 'Z') {
//       return Color(0xFFF1A481);
//     } else if (firstAlphabet == 'A' ||
//         firstAlphabet == 'B' ||
//         firstAlphabet == 'G' ||
//         firstAlphabet == 'L' ||
//         firstAlphabet == 'Q' ||
//         firstAlphabet == 'V') {
//       return Color(0xFFB3F181);
//     } else if (firstAlphabet == 'A' ||
//         firstAlphabet == 'C' ||
//         firstAlphabet == 'H' ||
//         firstAlphabet == 'M' ||
//         firstAlphabet == 'R' ||
//         firstAlphabet == 'W') {
//       return Color(0xFF81F1E2);
//     } else if (firstAlphabet == 'D' ||
//         firstAlphabet == 'I' ||
//         firstAlphabet == 'N' ||
//         firstAlphabet == 'S' ||
//         firstAlphabet == 'X') {
//       return Color(0xFF81A4F1);
//     } else {
//       return Color(0xFFD681F1);
//     }
//   }

//   static Future<void> launchURL(String url) async {
//     if (await canLaunchUrlString(url)) {
//       await launchUrlString(url);
//     } else {
//       throw 'Could not launch $url';
//     }
//   }

//   static Future<void> sendSMS({
//     required String phoneNumber,
//     required String message,
//   }) async {
//     final Uri uri = Uri(
//       scheme: 'sms',
//       path: phoneNumber,
//       queryParameters: {'body': message},
//     );

//     if (await canLaunchUrl(uri)) {
//       await launchUrl(uri);
//     } else {
//       throw 'Could not launch SMS';
//     }
//   }

//   void shareAppLink({required String applicationUrl, required String title}) {
//     final Uri appUrl = Uri.parse(applicationUrl);
//     SharePlus.instance.share(ShareParams(title: title, uri: appUrl));
//   }

//   static Future<bool> checkInternet(BuildContext context) async {
//     final internetState = BlocProvider.of<NetworkBloc>(context).state;
//     log("$internetState");
//     if (internetState is! NetworkFailure) {
//       return true;
//     } else {
//       FToast fToast = FToast();
//       fToast.init(context);

//       // Remove any previous toasts before showing a new one
//       fToast.removeQueuedCustomToasts();
//       fToast.showToast(
//         child: Container(
//           padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(25.r),
//             color: AppColors.kColorWhite,
//             boxShadow: const [
//               BoxShadow(
//                 color: Colors.black26,
//                 blurRadius: 10.0,
//                 offset: Offset(0, 3),
//               ),
//             ],
//           ),
//           child: Row(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               SizedBox(width: 8.w),
//               Text(
//                 "No internet connection found.",
//                 style: kTextStyleDMSans500.copyWith(
//                   fontSize: 10.sp,
//                   color: AppColors.kColorPrimaryBg,
//                 ),
//               ),
//             ],
//           ),
//         ),
//         fadeDuration: const Duration(milliseconds: 200),
//         gravity: ToastGravity.BOTTOM,
//         toastDuration: const Duration(seconds: 2),
//       );
//       return false;
//     }
//   }

//   // FOR UTC
//   // static String extractTimeFromDateTime(String dateTimeString) {
//   //   try {
//   //     // Parse the UTC string
//   //     final utcDateTime = DateTime.parse(dateTimeString);

//   //     // Convert to local time
//   //     final localDateTime = utcDateTime.toLocal();

//   //     // Format as 12-hour time with AM/PM
//   //     final formattedTime = DateFormat(
//   //       'h:mm a',
//   //     ).format(localDateTime).toLowerCase();

//   //     return formattedTime;
//   //   } catch (e) {
//   //     print('Time extraction error: $e');
//   //     return '';
//   //   }
//   // }
//   // FOR NORMAL
//   static String extractTimeFromDateTime(String dateTimeString) {
//     try {
//       // Example input: "09-06-2025 02:55:06 pm"
//       // Step 1: Split date and time
//       final parts = dateTimeString.trim().split(' ');
//       if (parts.length < 3) return '';

//       // parts[1] = "02:55:06", parts[2] = "pm"
//       final timeParts = parts[1].split(':'); // ["02", "55", "06"]
//       if (timeParts.length < 2) return '';

//       final hour = int.parse(
//         timeParts[0],
//       ).toString(); // remove leading zero if any
//       final minute = timeParts[1];

//       return '$hour:$minute ${parts[2].toLowerCase()}'; // e.g., "2:55 pm"
//     } catch (e) {
//       print('Time extraction error: $e');
//       return '';
//     }
//   }

//   //   static void handleContactsImportPermissionDenied(BuildContext context) {
//   //     showDialog(
//   //       context: context,
//   //       builder: (BuildContext context) {
//   //         return AlertDialog(
//   //           backgroundColor: AppColors.kColorPrimaryBg,
//   //           title: Text(
//   //             'Permission Required',
//   //             style: kTextStyleDMSans600.copyWith(
//   //               fontSize: 14.sp,
//   //               color: AppColors.kColorWhite100,
//   //             ),
//   //           ),
//   //           content: Text(
//   //             'Contact access is required to import contacts.',
//   //             style: kTextStyleDMSans500.copyWith(
//   //               fontSize: 14.sp,
//   //               color: AppColors.kColorWhite100,
//   //             ),
//   //           ),
//   //           actions: <Widget>[
//   //             TextButton(
//   //               child: Text(
//   //                 'OK',
//   //                 style: kTextStyleDMSans600.copyWith(
//   //                   fontSize: 14.sp,
//   //                   color: AppColors.kColorWhite100,
//   //                 ),
//   //               ),
//   //               onPressed: () {
//   //                 // // Close the dialog
//   //                 context.router
//   //                     .maybePop()
//   //                     .then((_) {
//   //                       if (context.mounted) {
//   //                         context.router.pop();
//   //                       }
//   //                     })
//   //                     .then((_) => AppSettings.openAppSettings());
//   //               },
//   //             ),
//   //           ],
//   //         );
//   //       },
//   //     );
//   //   }
//   // }

//   static String decrypt(String cipherText) {
//     try {
//       // Convert secret key to bytes (16 bytes for AES-128)
//       final keyBytes = utf8.encode('1234567890123456');

//       // Decode base64 cipher text
//       final encryptedBytes = base64.decode(cipherText);

//       // Create AES cipher
//       final cipher = AESEngine();
//       final params = KeyParameter(Uint8List.fromList(keyBytes));
//       cipher.init(false, params); // false for decryption

//       // Process in 16-byte blocks (AES block size)
//       final decryptedBytes = <int>[];
//       for (int i = 0; i < encryptedBytes.length; i += 16) {
//         final block = encryptedBytes.sublist(i, i + 16);
//         final decryptedBlock = cipher.process(Uint8List.fromList(block));
//         decryptedBytes.addAll(decryptedBlock);
//       }

//       // Remove PKCS7 padding
//       final paddingLength = decryptedBytes.last;
//       final unpaddedBytes = decryptedBytes.sublist(
//         0,
//         decryptedBytes.length - paddingLength,
//       );

//       return utf8.decode(unpaddedBytes);
//     } catch (e) {
//       debugPrint('Error decrypting: $e');
//       return '';
//     }
//   }

//   static TextInputFormatter approxUnicodeLengthFormatter(int maxLength) {
//     return TextInputFormatter.withFunction((oldValue, newValue) {
//       final runes = newValue.text.runes.toList();
//       if (runes.length > maxLength) {
//         final newText = String.fromCharCodes(runes.take(maxLength));
//         return TextEditingValue(
//           text: newText,
//           selection: TextSelection.collapsed(offset: newText.length),
//         );
//       }
//       return newValue;
//     });
//   }

//   static String getPhoneDetail(
//     double screenWidth,
//     double screenHeight,
//     double pixelRatio,
//   ) {
//     double shortestSide = math.min(screenWidth, screenHeight);
//     double longestSide = math.max(screenWidth, screenHeight);
//     double aspectRatio = longestSide / shortestSide;

//     // log("Shortest: $shortestSide, Longest: $longestSide, Ratio: $aspectRatio");

//     // Foldable: wide screen with low aspect ratio when unfolded
//     if (shortestSide >= 600 && aspectRatio <= 1.4) {
//       return "fold";
//     }
//     // Tablet: shortest side >= 600dp
//     else if (shortestSide >= 600) {
//       return "tab";
//     }
//     // Phone
//     else {
//       return "phone";
//     }
//   }
// }
