import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/app_dimens.dart';
import '../../../../core/theme/colors.dart';
import '../bloc/home_bloc.dart';
import '../widgets/user_card.dart';
import '../widgets/shimmer_loader.dart';
import '../widgets/error_view.dart';
import '../widgets/empty_view.dart';

/// Tab displaying users with pull-to-refresh capability
class UsersTab extends StatelessWidget {
  const UsersTab({super.key});

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
          return const EmptyView(message: 'No users found');
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
