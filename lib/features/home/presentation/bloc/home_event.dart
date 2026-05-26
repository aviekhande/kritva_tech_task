part of 'home_bloc.dart';

abstract class HomeEvent {
  const HomeEvent();
}

class HomeFetchPostsRequested extends HomeEvent {
  const HomeFetchPostsRequested();
}

class HomeFetchUsersRequested extends HomeEvent {
  const HomeFetchUsersRequested();
}

class HomeTabChanged extends HomeEvent {
  final int tabIndex;
  const HomeTabChanged(this.tabIndex);
}
