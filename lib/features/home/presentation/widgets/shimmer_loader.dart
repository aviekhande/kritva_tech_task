import 'package:flutter/material.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/app_dimens.dart';

class ShimmerLoader extends StatefulWidget {
  final int itemCount;

  const ShimmerLoader({super.key, this.itemCount = 6});

  @override
  State<ShimmerLoader> createState() => _ShimmerLoaderState();
}

class _ShimmerLoaderState extends State<ShimmerLoader>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _anim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat();
    _anim = Tween<double>(begin: -1.0, end: 2.0).animate(
      CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.itemCount,
      padding: const EdgeInsets.symmetric(horizontal: AppDimens.p16),
      itemBuilder: (_, __) => AnimatedBuilder(
        animation: _anim,
        builder: (_, __) => _ShimmerCard(shimmerValue: _anim.value),
      ),
    );
  }
}

class _ShimmerCard extends StatelessWidget {
  final double shimmerValue;

  const _ShimmerCard({required this.shimmerValue});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppDimens.p12),
      padding: const EdgeInsets.all(AppDimens.p16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppDimens.r16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _shimmerBox(36, 36, radius: 10),
              const SizedBox(width: 10),
              _shimmerBox(60, 20, radius: 6),
            ],
          ),
          const SizedBox(height: 12),
          _shimmerBox(double.infinity, 16, radius: 6),
          const SizedBox(height: 6),
          _shimmerBox(200, 16, radius: 6),
          const SizedBox(height: 10),
          _shimmerBox(double.infinity, 12, radius: 4),
          const SizedBox(height: 4),
          _shimmerBox(double.infinity, 12, radius: 4),
          const SizedBox(height: 4),
          _shimmerBox(150, 12, radius: 4),
        ],
      ),
    );
  }

  Widget _shimmerBox(double width, double height, {double radius = 4}) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          stops: const [0.0, 0.5, 1.0],
          colors: [
            AppColors.kColorShimmerBase,
            AppColors.kColorShimmerHighlight,
            AppColors.kColorShimmerBase,
          ],
          transform: _SlideGradientTransform(shimmerValue),
        ),
      ),
    );
  }
}

class _SlideGradientTransform extends GradientTransform {
  final double slidePercent;
  const _SlideGradientTransform(this.slidePercent);

  @override
  Matrix4? transform(Rect bounds, {TextDirection? textDirection}) {
    return Matrix4.translationValues(
        bounds.width * slidePercent, 0.0, 0.0);
  }
}
