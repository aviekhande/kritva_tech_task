import 'package:flutter/material.dart';

import '../../../../core/theme/colors.dart';
import '../../../../core/theme/text_styles.dart';

/// Tab bar widget for home page with posts and users tabs
class HomeTabBar extends StatelessWidget {
  final TabController controller;
  final List<String> tabs;

  const HomeTabBar({
    super.key,
    required this.controller,
    required this.tabs,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: TabBar(
        controller: controller,
        labelColor: AppColors.kColorPrimary,
        unselectedLabelColor: AppColors.kColorTextMuted,
        labelStyle: kTextStylePublicSans700.copyWith(fontSize: 14),
        unselectedLabelStyle: kTextStylePublicSans500.copyWith(fontSize: 14),
        indicatorColor: AppColors.kColorPrimary,
        indicatorWeight: 3,
        indicatorSize: TabBarIndicatorSize.label,
        tabs: tabs.map((t) => Tab(text: t)).toList(),
      ),
    );
  }
}
