import 'package:flutter/material.dart';

/// Manages animations for the login page
class LoginAnimations {
  late AnimationController controller;
  late List<Animation<Offset>> slideAnimations;
  late List<Animation<double>> fadeAnimations;

  /// Initialize animations with the provided controller
  void init(TickerProvider vsync) {
    controller = AnimationController(
      vsync: vsync,
      duration: const Duration(milliseconds: 900),
    );

    slideAnimations = List.generate(5, (i) {
      final start = i * 0.12;
      final end = (start + 0.5).clamp(0.0, 1.0);
      return Tween<Offset>(
        begin: const Offset(0, 0.35),
        end: Offset.zero,
      ).animate(
        CurvedAnimation(
          parent: controller,
          curve: Interval(start, end, curve: Curves.easeOutCubic),
        ),
      );
    });

    fadeAnimations = List.generate(5, (i) {
      final start = i * 0.12;
      final end = (start + 0.4).clamp(0.0, 1.0);
      return Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: controller,
          curve: Interval(start, end, curve: Curves.easeOut),
        ),
      );
    });

    controller.forward();
  }

  /// Get animation for a specific index
  Animation<Offset> getSlideAnimation(int index) => slideAnimations[index];

  Animation<double> getFadeAnimation(int index) => fadeAnimations[index];

  /// Dispose animations
  void dispose() => controller.dispose();
}
