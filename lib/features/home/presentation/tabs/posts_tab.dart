import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/app_dimens.dart';
import '../../../../core/theme/colors.dart';
import '../bloc/home_bloc.dart';
import '../widgets/post_card.dart';
import '../widgets/shimmer_loader.dart';
import '../widgets/error_view.dart';
import '../widgets/empty_view.dart';

/// Tab displaying user posts with pull-to-refresh capability
class PostsTab extends StatelessWidget {
  const PostsTab({super.key});

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
          return const EmptyView(message: 'No posts found');
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
