import 'package:flutter/material.dart';
import 'package:flutter_todo_list_app/core/theme/app_colors.dart';

class AppTheme {
  static ThemeData darkTheme = ThemeData(
    colorScheme: ColorScheme.dark(
      primary: AppColors.primary,
      secondary: AppColors.secondary,
      error: AppColors.error,
    ),
    scaffoldBackgroundColor: AppColors.backgroundDark,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.primary,
      foregroundColor: AppColors.black,
    ),
  );

  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.backgroundLigth,
    colorScheme: ColorScheme.light(
      primary: AppColors.primary,
      secondary: AppColors.secondary,
      error: AppColors.error,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.primary,
      foregroundColor: AppColors.black,
    ),
  );
}
