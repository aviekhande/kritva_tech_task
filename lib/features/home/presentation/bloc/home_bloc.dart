import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/post_model.dart';
import '../../data/models/user_data_model.dart';
import '../../domain/repositories/home_repository.dart';
import '../../../../core/exceptions/server_exception.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeRepository _homeRepository;

  HomeBloc(this._homeRepository) : super(const HomeState()) {
    on<HomeFetchPostsRequested>(_onFetchPosts);
    on<HomeFetchUsersRequested>(_onFetchUsers);
    on<HomeTabChanged>(_onTabChanged);
  }

  Future<void> _onFetchPosts(
    HomeFetchPostsRequested event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(isLoadingPosts: true, clearPostsError: true));
    try {
      final posts = await _homeRepository.getPosts();
      emit(state.copyWith(posts: posts, isLoadingPosts: false));
    } on ServerException catch (e) {
      emit(state.copyWith(isLoadingPosts: false, postsError: e.message));
    } catch (e) {
      log('HomeBloc fetchPosts error: $e');
      emit(state.copyWith(
        isLoadingPosts: false,
        postsError: 'Failed to load posts. Please try again.',
      ));
    }
  }

  Future<void> _onFetchUsers(
    HomeFetchUsersRequested event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(isLoadingUsers: true, clearUsersError: true));
    try {
      final users = await _homeRepository.getUsers();
      emit(state.copyWith(users: users, isLoadingUsers: false));
    } on ServerException catch (e) {
      emit(state.copyWith(isLoadingUsers: false, usersError: e.message));
    } catch (e) {
      log('HomeBloc fetchUsers error: $e');
      emit(state.copyWith(
        isLoadingUsers: false,
        usersError: 'Failed to load users. Please try again.',
      ));
    }
  }

  void _onTabChanged(HomeTabChanged event, Emitter<HomeState> emit) {
    emit(state.copyWith(currentTabIndex: event.tabIndex));
    // Lazy load: fetch data only when that tab is first opened
    if (event.tabIndex == 0 && state.posts.isEmpty) {
      add(const HomeFetchPostsRequested());
    } else if (event.tabIndex == 1 && state.users.isEmpty) {
      add(const HomeFetchUsersRequested());
    }
  }
}
