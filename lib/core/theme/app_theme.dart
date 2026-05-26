import 'package:flutter/material.dart';
import 'colors.dart';
import 'text_styles.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get lightTheme => ThemeData(
        scaffoldBackgroundColor: AppColors.kColorPrimaryBg,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.kColorPrimary,
          primary: AppColors.kColorPrimary,
        ),
        textTheme: const TextTheme(
          displayLarge: TextStyle(),
          bodyLarge: TextStyle(),
          bodyMedium: TextStyle(),
        ).apply(
          fontFamily: 'PublicSans-Regular',
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColors.kColorBorder),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColors.kColorBorder),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColors.kColorPrimary, width: 1.5),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColors.kColorError),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColors.kColorError, width: 1.5),
          ),
          labelStyle: kTextStylePublicSans500.copyWith(
            color: AppColors.kColorTextMuted,
            fontSize: 14,
          ),
          hintStyle: kTextStylePublicSans400.copyWith(
            color: AppColors.kColorTextMuted,
            fontSize: 14,
          ),
          errorStyle: kTextStylePublicSans400.copyWith(
            color: AppColors.kColorError,
            fontSize: 12,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.kColorPrimary,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            padding: const EdgeInsets.symmetric(vertical: 16),
            textStyle: kTextStylePublicSans700.copyWith(fontSize: 16),
            elevation: 0,
          ),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(color: AppColors.kColorTextDark),
          titleTextStyle: TextStyle(
            fontFamily: 'PublicSans-Bold',
            fontSize: 18,
            color: AppColors.kColorTextDark,
          ),
        ),
      );
}
