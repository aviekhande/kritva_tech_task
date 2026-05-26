import 'package:flutter/material.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../data/models/post_model.dart';

class PostCard extends StatelessWidget {
  final PostModel post;

  const PostCard({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppDimens.p12),
      decoration: BoxDecoration(
        color: AppColors.kColorCardBg,
        borderRadius: BorderRadius.circular(AppDimens.r16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppDimens.p16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: AppColors.kColorPrimary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      '#${post.id}',
                      style: kTextStylePublicSans700.copyWith(
                        fontSize: 11,
                        color: AppColors.kColorPrimary,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: AppColors.kColorBg1.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    'User ${post.userId}',
                    style: kTextStylePublicSans500.copyWith(
                      fontSize: 11,
                      color: AppColors.kColorTextSecondary,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppDimens.p12),
            Text(
              post.title.length > 1
                  ? '${post.title[0].toUpperCase()}${post.title.substring(1)}'
                  : post.title,
              style: kTextStylePublicSans700.copyWith(
                fontSize: 14,
                color: AppColors.kColorTextDark,
                height: 1.4,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: AppDimens.p8),
            Text(
              post.body,
              style: kTextStylePublicSans400.copyWith(
                fontSize: 13,
                color: AppColors.kColorTextMuted,
                height: 1.5,
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
