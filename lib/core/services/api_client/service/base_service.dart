// import 'dart:convert';
// import 'dart:developer';

// import 'package:caesar_cipher/core/services/chunked_upload/cubit/cubit/uploading_files_cubit.dart';
// import 'package:caesar_cipher/core/services/chunked_upload/presentation/bloc/chunked_upload_bloc.dart';
// import 'package:caesar_cipher/core/services/shared_preferences/shared_preferences_service.dart';
// import 'package:caesar_cipher/init_dependencies.dart';
// import 'package:dio/dio.dart';
// import '../../../config/app_headers.dart';
// import '../../../routes/app_router.dart';
// import '../../../routes/app_router.gr.dart';
// import '../../../utils/utils.dart';

// abstract class BaseService {
//   final Dio dio;

//   BaseService(this.dio);

//   Future<void> setupHeaders() async {
//     final headers = await AppHeaders().getHeaders();
//     dio.options.headers = headers;

//     if (!dio.interceptors.any((i) => i.runtimeType == LogInterceptor)) {
//       dio.interceptors.add(Utils.getLoggingInterceptor());
//     }
//   }

//   Future<T> safeRequest<T>(
//     Future<T> Function() request, {
//     required T Function(Map<String, dynamic>)? fromJson,
//   }) async {
//     try {
//       await setupHeaders();
//       final result = await request();
//       if (jsonDecode(jsonEncode(result))['success'] == 4) {
//         await serviceLocator<SharedPreferencesService>().deleteToken();
//         serviceLocator<AppRouter>().replaceAll([const LoginRoute()]);
//         deactivateStompChat();
//         final uploadingFilesCubit = serviceLocator<UploadingFilesCubit>();
//         final chunkedUploadBloc = serviceLocator<ChunkedUploadBloc>();
//         uploadingFilesCubit.abortAllUploadsOnLogout(chunkedUploadBloc);
//       }
//       log("BASE SERVICE API RESULT JSON: ${jsonEncode(result)}");
//       return result;
//     } on DioException catch (e) {
//       log("DioException caught in safeRequest:$e");
//       log("Status Code: ${e.response?.statusCode}");
//       log("Response Data: ${e.response?.data}");
//       // Handle connection error (no internet, DNS fail, etc.)
//       if (e.type == DioExceptionType.connectionError) {
//         if (fromJson != null) {
//           log("Connection error occurred");
//           return fromJson({
//             'data': null,
//             'success': 99,
//             'message':
//                 'Unable to connect to the server. Please check your internet connection or try again later.',
//           });
//         }
//       }
//       if (e.response?.statusCode == 401) {
//         await serviceLocator<SharedPreferencesService>().deleteToken();
//         serviceLocator<AppRouter>().replaceAll([const LoginRoute()]);
//         deactivateStompChat();
//         final uploadingFilesCubit = serviceLocator<UploadingFilesCubit>();
//         final chunkedUploadBloc = serviceLocator<ChunkedUploadBloc>();
//         uploadingFilesCubit.abortAllUploadsOnLogout(chunkedUploadBloc);
//       }
//       if (e.response?.data is Map<String, dynamic> && fromJson != null) {
//         return fromJson(e.response!.data);
//       }
//       throw Exception("API Error: ${e.message}");
//     } catch (e, stackTrace) {
//       log("Unexpected error in safeRequest: $e\n$stackTrace");
//       throw Exception("Something went wrong: $e");
//     }
//   }
// }
