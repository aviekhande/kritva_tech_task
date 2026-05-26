part of 'home_bloc.dart';

class HomeState {
  final List<PostModel> posts;
  final List<UserDataModel> users;
  final bool isLoadingPosts;
  final bool isLoadingUsers;
  final String? postsError;
  final String? usersError;
  final int currentTabIndex;

  const HomeState({
    this.posts = const [],
    this.users = const [],
    this.isLoadingPosts = false,
    this.isLoadingUsers = false,
    this.postsError,
    this.usersError,
    this.currentTabIndex = 0,
  });

  HomeState copyWith({
    List<PostModel>? posts,
    List<UserDataModel>? users,
    bool? isLoadingPosts,
    bool? isLoadingUsers,
    String? postsError,
    String? usersError,
    int? currentTabIndex,
    bool clearPostsError = false,
    bool clearUsersError = false,
  }) {
    return HomeState(
      posts: posts ?? this.posts,
      users: users ?? this.users,
      isLoadingPosts: isLoadingPosts ?? this.isLoadingPosts,
      isLoadingUsers: isLoadingUsers ?? this.isLoadingUsers,
      postsError: clearPostsError ? null : postsError ?? this.postsError,
      usersError: clearUsersError ? null : usersError ?? this.usersError,
      currentTabIndex: currentTabIndex ?? this.currentTabIndex,
    );
  }
}
