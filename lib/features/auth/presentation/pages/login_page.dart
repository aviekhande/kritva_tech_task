import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/routes/app_router.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../core/utils/widgets/app_text_field.dart';
import '../../../../core/utils/widgets/primary_button.dart';
import '../bloc/auth_bloc.dart';

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
  bool _obscurePass = true;

  late AnimationController _animCtrl;
  late List<Animation<Offset>> _slideAnims;
  late List<Animation<double>> _fadeAnims;

  @override
  void initState() {
    super.initState();
    _animCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    _slideAnims = List.generate(5, (i) {
      final start = i * 0.12;
      final end = (start + 0.5).clamp(0.0, 1.0);
      return Tween<Offset>(
        begin: const Offset(0, 0.35),
        end: Offset.zero,
      ).animate(
        CurvedAnimation(
          parent: _animCtrl,
          curve: Interval(start, end, curve: Curves.easeOutCubic),
        ),
      );
    });

    _fadeAnims = List.generate(5, (i) {
      final start = i * 0.12;
      final end = (start + 0.4).clamp(0.0, 1.0);
      return Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: _animCtrl,
          curve: Interval(start, end, curve: Curves.easeOut),
        ),
      );
    });

    _animCtrl.forward();
  }

  @override
  void dispose() {
    _animCtrl.dispose();
    _phoneCtrl.dispose();
    _passCtrl.dispose();
    super.dispose();
  }

  Widget _animated(int index, Widget child) => SlideTransition(
    position: _slideAnims[index],
    child: FadeTransition(opacity: _fadeAnims[index], child: child),
  );

  void _onLogin() {
    if (!_formKey.currentState!.validate()) return;
    context.read<AuthBloc>().add(
      AuthLoginRequested(
        phone: _phoneCtrl.text.trim(),
        password: _passCtrl.text,
      ),
    );
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

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthLoginSuccess) {
          context.go(AppRoutes.home);
        } else if (state is AuthFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(
                  state.message,
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
      },
      child: Scaffold(
        backgroundColor: AppColors.kColorPrimaryBg,
        body: Stack(
          children: [
            SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppDimens.p24,
                  vertical: AppDimens.p24,
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: AppDimens.p40),

                      // Header
                      _animated(0, _buildHeader()),

                      const SizedBox(height: AppDimens.p48),

                      // Phone field
                      _animated(
                        1,
                        AppTextField(
                          controller: _phoneCtrl,
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
                      _animated(
                        2,
                        StatefulBuilder(
                          builder: (ctx, setLocal) => AppTextField(
                            controller: _passCtrl,
                            labelText: AppStrings.password,
                            hintText: AppStrings.passwordPlaceholder,
                            obscureText: _obscurePass,
                            validator: _validatePassword,
                            textInputAction: TextInputAction.done,
                            onFieldSubmitted: (_) => _onLogin(),
                            prefixIcon: const Icon(
                              Icons.lock_outline_rounded,
                              color: AppColors.kColorTextMuted,
                              size: 20,
                            ),
                            suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() => _obscurePass = !_obscurePass);
                              },
                              child: Icon(
                                _obscurePass
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility_outlined,
                                color: AppColors.kColorTextMuted,
                                size: 20,
                              ),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: AppDimens.p40),

                      // Login button
                      _animated(
                        3,
                        BlocBuilder<AuthBloc, AuthState>(
                          builder: (context, state) => PrimaryButton(
                            label: AppStrings.login,
                            isLoading: state is AuthLoading,
                            onTap: _onLogin,
                            icon: Icons.login_rounded,
                          ),
                        ),
                      ),

                      const SizedBox(height: AppDimens.p28),

                      // Register link
                      _animated(
                        4,
                        Center(
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
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
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

  Widget _buildGlowCircle(double size, {double opacity = 0.12}) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [
            AppColors.kColorPrimary.withOpacity(opacity),
            Colors.transparent,
          ],
        ),
      ),
    );
  }
}
