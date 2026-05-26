import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../core/utils/widgets/app_text_field.dart';
import '../../../../core/utils/widgets/primary_button.dart';
import '../bloc/auth_bloc.dart';
import '../utils/login_animations.dart';

/// Form section for login with email and password fields
class LoginFormSection extends StatefulWidget {
  final LoginAnimations animations;
  final GlobalKey<FormState> formKey;
  final TextEditingController phoneController;
  final TextEditingController passwordController;
  final VoidCallback onLogin;

  const LoginFormSection({
    super.key,
    required this.animations,
    required this.formKey,
    required this.phoneController,
    required this.passwordController,
    required this.onLogin,
  });

  @override
  State<LoginFormSection> createState() => _LoginFormSectionState();
}

class _LoginFormSectionState extends State<LoginFormSection> {
  bool _obscurePassword = true;

  @override
  void dispose() {
    super.dispose();
  }

  String? _validatePhone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppStrings.phoneRequired;
    }
    if (!RegExp(r'^[6-9]\d{9}$').hasMatch(value.trim())) {
      return AppStrings.phoneInvalid;
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) return AppStrings.passwordRequired;
    if (value.length < 6) return AppStrings.passwordMin;
    return null;
  }

  Widget _buildAnimatedChild(int index, Widget child) => SlideTransition(
    position: widget.animations.getSlideAnimation(index),
    child: FadeTransition(
      opacity: widget.animations.getFadeAnimation(index),
      child: child,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Phone field
          _buildAnimatedChild(
            1,
            AppTextField(
              controller: widget.phoneController,
              labelText: AppStrings.phoneNumber,
              hintText: AppStrings.phonePlaceholder,
              keyboardType: TextInputType.phone,
              validator: _validatePhone,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(10),
              ],
              prefixIcon: const Icon(
                Icons.phone_outlined,
                color: AppColors.kColorTextMuted,
                size: 20,
              ),
            ),
          ),
          const SizedBox(height: AppDimens.p20),

          // Password field
          _buildAnimatedChild(
            2,
            AppTextField(
              controller: widget.passwordController,
              labelText: AppStrings.password,
              hintText: AppStrings.passwordPlaceholder,
              obscureText: _obscurePassword,
              validator: _validatePassword,
              textInputAction: TextInputAction.done,
              onFieldSubmitted: (_) => widget.onLogin(),
              prefixIcon: const Icon(
                Icons.lock_outline_rounded,
                color: AppColors.kColorTextMuted,
                size: 20,
              ),
              suffixIcon: GestureDetector(
                onTap: () {
                  setState(() => _obscurePassword = !_obscurePassword);
                },
                child: Icon(
                  _obscurePassword
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  color: AppColors.kColorTextMuted,
                  size: 20,
                ),
              ),
            ),
          ),
          const SizedBox(height: AppDimens.p40),

          // Login button
          _buildAnimatedChild(
            3,
            BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) => PrimaryButton(
                label: AppStrings.login,
                isLoading: state is AuthLoading,
                onTap: widget.onLogin,
                icon: Icons.login_rounded,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
