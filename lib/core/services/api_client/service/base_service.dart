import 'dart:developer';
import 'package:dio/dio.dart';
import '../../../config/app_config.dart';
import '../../../exceptions/server_exception.dart';

class BaseService {
  late final Dio _dio;

  BaseService() {
    _dio = Dio(
      BaseOptions(
        baseUrl: AppConfig.baseUrl,
        connectTimeout: const Duration(milliseconds: AppConfig.connectTimeout),
        receiveTimeout: const Duration(milliseconds: AppConfig.receiveTimeout),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    _dio.interceptors.add(
      LogInterceptor(
        request: true,
        responseBody: true,
        requestBody: true,
        error: true,
        logPrint: (obj) => log(obj.toString()),
      ),
    );
  }

  Dio get dio => _dio;

  Future<T> safeRequest<T>(Future<T> Function() request) async {
    try {
      return await request();
    } on DioException catch (e) {
      log('DioException: ${e.message}');
      log('Status: ${e.response?.statusCode}');

      if (e.type == DioExceptionType.connectionError ||
          e.type == DioExceptionType.connectionTimeout) {
        throw const ServerException('No internet connection. Please try again.');
      }

      if (e.response?.statusCode == 404) {
        throw const ServerException('Resource not found.');
      }

      if (e.response?.statusCode == 500) {
        throw const ServerException('Internal server error. Please try later.');
      }

      throw ServerException(e.message ?? 'An unexpected error occurred.');
    } catch (e, s) {
      log('Unexpected error: $e\n$s');
      throw const ServerException('Something went wrong. Please try again.');
    }
  }
}
