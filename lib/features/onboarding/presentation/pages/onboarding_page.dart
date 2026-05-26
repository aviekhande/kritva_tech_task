import 'package:kritva_tech_task/core/theme/colors.dart';
import 'package:flutter/material.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kColorPrimary,
      body: Column(children: [Expanded(child: Text("Onboarding"))]),
    );
  }
}
