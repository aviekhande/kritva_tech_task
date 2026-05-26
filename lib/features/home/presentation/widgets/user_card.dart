import 'package:flutter/material.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../data/models/user_data_model.dart';

class UserCard extends StatelessWidget {
  final UserDataModel user;

  const UserCard({super.key, required this.user});

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
        child: Row(
          children: [
            // Avatar
            Container(
              width: 48,
              height: 48,
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
                  user.name.isNotEmpty ? user.name[0].toUpperCase() : '?',
                  style: kTextStylePublicSans800.copyWith(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(width: AppDimens.p12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.name,
                    style: kTextStylePublicSans700.copyWith(
                      fontSize: 15,
                      color: AppColors.kColorTextDark,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '@${user.username}',
                    style: kTextStylePublicSans500.copyWith(
                      fontSize: 12,
                      color: AppColors.kColorPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.email_outlined,
                          size: 13, color: AppColors.kColorTextMuted),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          user.email,
                          style: kTextStylePublicSans400.copyWith(
                            fontSize: 12,
                            color: AppColors.kColorTextMuted,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      const Icon(Icons.language_outlined,
                          size: 13, color: AppColors.kColorTextMuted),
                      const SizedBox(width: 4),
                      Text(
                        user.website,
                        style: kTextStylePublicSans400.copyWith(
                          fontSize: 12,
                          color: AppColors.kColorTextSecondary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
