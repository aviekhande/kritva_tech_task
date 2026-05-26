import 'package:flutter/material.dart';

import '../../../../core/theme/colors.dart';
import '../../../../core/theme/text_styles.dart';

/// Empty state view displayed when no data is available
class EmptyView extends StatelessWidget {
  final String message;

  const EmptyView({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.inbox_rounded,
            size: 56,
            color: AppColors.kColorTextMuted,
          ),
          const SizedBox(height: 12),
          Text(
            message,
            style: kTextStylePublicSans500.copyWith(
              fontSize: 15,
              color: AppColors.kColorTextMuted,
            ),
          ),
        ],
      ),
    );
  }
}
