import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/colors.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../init_dependencies.dart';
import '../../../../core/services/shared_preferences/shared_preferences_service.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';

/// App bar for the home page with user avatar and logout button
class HomeAppBar extends StatelessWidget {
  final VoidCallback onLogout;

  const HomeAppBar({
    super.key,
    required this.onLogout,
  });

  String get _currentUserPhone =>
      serviceLocator<SharedPreferencesService>().getCurrentUser() ?? 'User';

  @override
  Widget build(BuildContext context) {
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
          _buildUserAvatar(),
          const SizedBox(width: 12),
          _buildUserInfo(),
          _buildLogoutButton(context),
        ],
      ),
    );
  }

  Widget _buildUserAvatar() {
    return Container(
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
    );
  }

  Widget _buildUserInfo() {
    return Expanded(
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
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) => IconButton(
        onPressed: state is AuthLoading ? null : onLogout,
        icon: state is AuthLoading
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor:
                      AlwaysStoppedAnimation(AppColors.kColorError),
                ),
              )
            : const Icon(
                Icons.logout_rounded,
                color: AppColors.kColorError,
                size: 22,
              ),
        tooltip: 'Logout',
        style: IconButton.styleFrom(
          backgroundColor: AppColors.kColorError.withOpacity(0.08),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
