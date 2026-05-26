import 'package:dio/dio.dart';
import '../../../../core/config/app_config.dart';
import '../../../../core/exceptions/server_exception.dart';
import '../../../../core/services/api_client/service/base_service.dart';
import '../models/post_model.dart';
import '../models/user_data_model.dart';

class HomeRemoteDataSource {
  final BaseService _baseService;

  const HomeRemoteDataSource(this._baseService);

  Future<List<PostModel>> fetchPosts() async {
    return _baseService.safeRequest(() async {
      final Response response =
          await _baseService.dio.get(AppConfig.postsEndpoint);

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data as List<dynamic>;
        return data
            .map((e) => PostModel.fromJson(e as Map<String, dynamic>))
            .toList();
      }

      throw ServerException(
          'Failed to fetch posts (${response.statusCode})');
    });
  }

  Future<List<UserDataModel>> fetchUsers() async {
    return _baseService.safeRequest(() async {
      final Response response =
          await _baseService.dio.get(AppConfig.usersEndpoint);

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data as List<dynamic>;
        return data
            .map((e) => UserDataModel.fromJson(e as Map<String, dynamic>))
            .toList();
      }

      throw ServerException(
          'Failed to fetch users (${response.statusCode})');
    });
  }
}
