import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/routes/app_router.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../init_dependencies.dart';
import '../../../../core/services/shared_preferences/shared_preferences_service.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../bloc/home_bloc.dart';
import '../widgets/post_card.dart';
import '../widgets/user_card.dart';
import '../widgets/shimmer_loader.dart';
import '../widgets/error_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<String> _tabs = [AppStrings.posts, AppStrings.users];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        context.read<HomeBloc>().add(HomeTabChanged(_tabController.index));
      }
    });

    // Load posts on initial open
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HomeBloc>().add(const HomeFetchPostsRequested());
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  String get _currentUserPhone =>
      serviceLocator<SharedPreferencesService>().getCurrentUser() ?? 'User';

  void _onLogout() {
    context.read<AuthBloc>().add(const AuthLogoutRequested());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthLogoutSuccess) {
          context.go(AppRoutes.login);
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.kColorPrimaryBg,
        body: Column(
          children: [
            _buildAppBar(),
            _buildTabBar(),
            Expanded(child: _buildTabContent()),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 12,
        left: AppDimens.p24,
        right: AppDimens.p24,
        bottom: 16,
      ),
      child: Row(
        children: [
          // Avatar
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [AppColors.kColorPrimary, AppColors.kColorBg1],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Center(
              child: Text(
                _currentUserPhone.isNotEmpty
                    ? _currentUserPhone[0].toUpperCase()
                    : 'U',
                style: kTextStylePublicSans800.copyWith(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome back!',
                  style: kTextStylePublicSans400.copyWith(
                    fontSize: 12,
                    color: AppColors.kColorTextMuted,
                  ),
                ),
                Text(
                  _currentUserPhone,
                  style: kTextStylePublicSans700.copyWith(
                    fontSize: 15,
                    color: AppColors.kColorTextDark,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          // Logout button
          BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) => IconButton(
              onPressed: state is AuthLoading ? null : _onLogout,
              icon: state is AuthLoading
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation(AppColors.kColorError),
                      ),
                    )
                  : const Icon(
                      Icons.logout_rounded,
                      color: AppColors.kColorError,
                      size: 22,
                    ),
              tooltip: AppStrings.logout,
              style: IconButton.styleFrom(
                backgroundColor: AppColors.kColorError.withOpacity(0.08),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      color: Colors.white,
      child: TabBar(
        controller: _tabController,
        labelColor: AppColors.kColorPrimary,
        unselectedLabelColor: AppColors.kColorTextMuted,
        labelStyle: kTextStylePublicSans700.copyWith(fontSize: 14),
        unselectedLabelStyle: kTextStylePublicSans500.copyWith(fontSize: 14),
        indicatorColor: AppColors.kColorPrimary,
        indicatorWeight: 3,
        indicatorSize: TabBarIndicatorSize.label,
        tabs: _tabs.map((t) => Tab(text: t)).toList(),
      ),
    );
  }

  Widget _buildTabContent() {
    return TabBarView(
      controller: _tabController,
      children: [
        _PostsTab(),
        _UsersTab(),
      ],
    );
  }
}

// ── Posts Tab ───────────────────────────────────────────────────────────────

class _PostsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      buildWhen: (prev, curr) =>
          prev.isLoadingPosts != curr.isLoadingPosts ||
          prev.posts != curr.posts ||
          prev.postsError != curr.postsError,
      builder: (context, state) {
        if (state.isLoadingPosts) {
          return const ShimmerLoader();
        }

        if (state.postsError != null) {
          return ErrorView(
            message: state.postsError!,
            onRetry: () =>
                context.read<HomeBloc>().add(const HomeFetchPostsRequested()),
          );
        }

        if (state.posts.isEmpty) {
          return const _EmptyView(message: 'No posts found');
        }

        return RefreshIndicator(
          color: AppColors.kColorPrimary,
          onRefresh: () async {
            context.read<HomeBloc>().add(const HomeFetchPostsRequested());
          },
          child: ListView.builder(
            padding: const EdgeInsets.all(AppDimens.p16),
            itemCount: state.posts.length,
            itemBuilder: (_, index) => PostCard(post: state.posts[index]),
          ),
        );
      },
    );
  }
}

// ── Users Tab ───────────────────────────────────────────────────────────────

class _UsersTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      buildWhen: (prev, curr) =>
          prev.isLoadingUsers != curr.isLoadingUsers ||
          prev.users != curr.users ||
          prev.usersError != curr.usersError,
      builder: (context, state) {
        if (state.isLoadingUsers) {
          return const ShimmerLoader();
        }

        if (state.usersError != null) {
          return ErrorView(
            message: state.usersError!,
            onRetry: () =>
                context.read<HomeBloc>().add(const HomeFetchUsersRequested()),
          );
        }

        if (state.users.isEmpty) {
          return const _EmptyView(message: 'No users found');
        }

        return RefreshIndicator(
          color: AppColors.kColorPrimary,
          onRefresh: () async {
            context.read<HomeBloc>().add(const HomeFetchUsersRequested());
          },
          child: ListView.builder(
            padding: const EdgeInsets.all(AppDimens.p16),
            itemCount: state.users.length,
            itemBuilder: (_, index) => UserCard(user: state.users[index]),
          ),
        );
      },
    );
  }
}

// ── Empty View ───────────────────────────────────────────────────────────────

class _EmptyView extends StatelessWidget {
  final String message;
  const _EmptyView({required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.inbox_rounded,
              size: 56, color: AppColors.kColorTextMuted),
          const SizedBox(height: 12),
          Text(
            message,
            style: kTextStylePublicSans500.copyWith(
              fontSize: 15,
              color: AppColors.kColorTextMuted,
            ),
          ),
        ],
      ),
    );
  }
}
