import 'package:flutter/material.dart';
import 'package:mythic_todo/common/app_colors.dart';

class AppThemes {
  AppThemes._();

  static final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.lightBackgroundColor,
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: AppColors.lightPrimaryColor,
      onPrimary: AppColors.lightOnPrimaryColor,
      secondary: AppColors.lightSecondaryColor,
      onSecondary: AppColors.lightOnSecondaryColor,
      error: AppColors.lightErrorColor,
      onError: AppColors.lightOnErrorColor,
      background: AppColors.lightBackgroundColor,
      onBackground: AppColors.lightOnBackgroundColor,
      surface: AppColors.lightSurfaceColor,
      onSurface: AppColors.lightOnSurfaceColor,
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.darkBackgroundColor,
    colorScheme: const ColorScheme(
      brightness: Brightness.dark,
      primary: AppColors.darkPrimaryColor,
      onPrimary: AppColors.darkOnPrimaryColor,
      secondary: AppColors.darkSecondaryColor,
      onSecondary: AppColors.darkOnSecondaryColor,
      error: AppColors.darkErrorColor,
      onError: AppColors.darkOnErrorColor,
      background: AppColors.darkBackgroundColor,
      onBackground: AppColors.darkOnBackgroundColor,
      surface: AppColors.darkSurfaceColor,
      onSurface: AppColors.darkOnSurfaceColor,
    ),
  );
}
