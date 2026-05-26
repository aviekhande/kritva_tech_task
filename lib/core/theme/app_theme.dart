import 'package:flutter/material.dart';
import 'package:kritva_tech_task/core/theme/colors.dart';

class AppTheme {
  static ThemeData get theme => ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(seedColor: AppColors.kColorPrimary),
    radioTheme: RadioThemeData(
      fillColor: WidgetStateColor.resolveWith(
        (states) => AppColors.kColorPrimary,
      ),
    ),
    listTileTheme: const ListTileThemeData(horizontalTitleGap: 10),
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: AppColors.kColorPrimary,
      selectionHandleColor: AppColors.kColorPrimary,
    ),
  );
}
