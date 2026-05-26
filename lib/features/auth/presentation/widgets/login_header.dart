import 'package:flutter/material.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../core/theme/text_styles.dart';

/// Header section of the login page with icon and welcome text
class LoginHeaderWidget extends StatelessWidget {
  const LoginHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 52,
          height: 52,
          decoration: BoxDecoration(
            color: AppColors.kColorPrimary,
            borderRadius: BorderRadius.circular(16),
          ),
          child: const Icon(Icons.lock_rounded, color: Colors.white, size: 28),
        ),
        const SizedBox(height: AppDimens.p16),
        Text(
          AppStrings.welcomeBack,
          style: kTextStylePublicSans800.copyWith(
            fontSize: 30,
            color: AppColors.kColorTextDark,
            height: 1.1,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          AppStrings.loginSubtitle,
          style: kTextStylePublicSans400.copyWith(
            fontSize: 15,
            color: AppColors.kColorTextMuted,
          ),
        ),
      ],
    );
  }
}
