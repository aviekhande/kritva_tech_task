import '../../data/models/post_model.dart';
import '../../data/models/user_data_model.dart';

abstract class HomeRepository {
  Future<List<PostModel>> getPosts();
  Future<List<UserDataModel>> getUsers();
}
