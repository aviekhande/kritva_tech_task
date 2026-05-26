import '../../domain/repositories/home_repository.dart';
import '../datasources/home_remote_datasource.dart';
import '../models/post_model.dart';
import '../models/user_data_model.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource _dataSource;

  const HomeRepositoryImpl(this._dataSource);

  @override
  Future<List<PostModel>> getPosts() async {
    return _dataSource.fetchPosts();
  }

  @override
  Future<List<UserDataModel>> getUsers() async {
    return _dataSource.fetchUsers();
  }
}
