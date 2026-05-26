import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/routes/app_router.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../core/theme/text_styles.dart';
import '../bloc/auth_bloc.dart';
import '../utils/login_animations.dart';
import '../widgets/login_header.dart';
import '../widgets/login_form_section.dart';
import '../widgets/login_register_link.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _phoneCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  late final LoginAnimations _animations;

  @override
  void initState() {
    super.initState();
    _animations = LoginAnimations();
    _animations.init(this);
  }

  @override
  void dispose() {
    _animations.dispose();
    _phoneCtrl.dispose();
    _passCtrl.dispose();
    super.dispose();
  }

  void _onLogin() {
    if (!_formKey.currentState!.validate()) return;
    context.read<AuthBloc>().add(
      AuthLoginRequested(
        phone: _phoneCtrl.text.trim(),
        password: _passCtrl.text,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthLoginSuccess) {
          context.go(AppRoutes.home);
        } else if (state is AuthFailure) {
          _showErrorSnackBar(context, state.message);
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.kColorPrimaryBg,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimens.p24,
              vertical: AppDimens.p24,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: AppDimens.p40),
                // Header with animations
                _buildAnimatedWidget(
                  0,
                  const LoginHeaderWidget(),
                ),
                const SizedBox(height: AppDimens.p48),
                // Form fields
                LoginFormSection(
                  animations: _animations,
                  formKey: _formKey,
                  phoneController: _phoneCtrl,
                  passwordController: _passCtrl,
                  onLogin: _onLogin,
                ),
                const SizedBox(height: AppDimens.p28),
                // Register link
                _buildAnimatedWidget(
                  4,
                  const LoginRegisterLink(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAnimatedWidget(int index, Widget child) => SlideTransition(
    position: _animations.getSlideAnimation(index),
    child: FadeTransition(
      opacity: _animations.getFadeAnimation(index),
      child: child,
    ),
  );

  void _showErrorSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(
            message,
            style: kTextStylePublicSans500.copyWith(color: Colors.white),
          ),
          backgroundColor: AppColors.kColorError,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          margin: const EdgeInsets.all(16),
        ),
      );
  }
}
