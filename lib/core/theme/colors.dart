import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Primary / Brand Accents
  static const kColorPrimary = Color(
    0xFFE00073,
  ); // P - 500 / Deep Magenta (Buttons & Main Brand Color)
  static const kColorDeepMagenta = Color(
    0xFFE00073,
  ); // Alternative naming from your Figma style tokens
  // Backgrounds
  static const kColorBg1 = Color(
    0xFF2C1C4D,
  ); // BG1 (Deep Indigo/Purple Onboarding Background)
  // Typography & Content
  static const kColorText = Color(
    0xFFFFFFFF,
  ); // Headings, Core Body Text, and Buttons
  static const kColorPrimaryBg = Color(0xFFF6F6F6); // BG2 (Light Background)
  //Logging
  static const String reset = '\x1B[0m';
  static const String red = '\x1B[31m';
  static const String green = '\x1B[32m';
  static const String yellow = '\x1B[33m';
  static const String orange = '\x1B[38;5;208m';
  static const String blue = '\x1B[34m';
  static const String magenta = '\x1B[35m';
  static const String cyan = '\x1B[36m';
  static const String white = '\x1B[37m';

  static const String pinkNeon = '\x1B[38;5;213m'; // Light Pink / Neon Pink
  static const String brightCyan = '\x1B[38;5;51m'; // Very bright Cyan
  static const String electricPurple = '\x1B[38;5;93m'; // Electric Purple
  static const String limeGreen = '\x1B[38;5;118m'; // Vibrant Lime Green
}
