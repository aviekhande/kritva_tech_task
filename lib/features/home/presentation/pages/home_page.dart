import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/routes/app_router.dart';
import '../../../../core/theme/colors.dart';
import '../bloc/home_bloc.dart';
import '../tabs/posts_tab.dart';
import '../tabs/users_tab.dart';
import '../widgets/home_app_bar.dart';
import '../widgets/home_tab_bar.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';

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
            HomeAppBar(onLogout: _onLogout),
            HomeTabBar(controller: _tabController, tabs: _tabs),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: const [
                  PostsTab(),
                  UsersTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
