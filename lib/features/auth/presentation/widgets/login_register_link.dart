import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/routes/app_router.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/text_styles.dart';

/// Register link widget that navigates to registration page
class LoginRegisterLink extends StatelessWidget {
  const LoginRegisterLink({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () => context.go(AppRoutes.register),
        child: RichText(
          text: TextSpan(
            text: AppStrings.noAccount,
            style: kTextStylePublicSans400.copyWith(
              color: AppColors.kColorTextMuted,
              fontSize: 14,
            ),
            children: [
              TextSpan(
                text: AppStrings.registerLink,
                style: kTextStylePublicSans700.copyWith(
                  color: AppColors.kColorPrimary,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
