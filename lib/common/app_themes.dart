import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import 'app_colors.dart';
import 'app_text_styles.dart';

class AppThemes {
  AppThemes._();

  static final ThemeData lightTheme = ThemeData(
    appBarTheme: const AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark,
      ),
      centerTitle: true,
      iconTheme: IconThemeData(
        color: AppColors.lightSecondaryColor,
      ),
    ),
    scaffoldBackgroundColor: AppColors.lightBackgroundColor,
    primaryColor: AppColors.lightPrimaryColor,
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
    inputDecorationTheme: InputDecorationTheme(
      prefixIconColor: const Color(0XFF2F2E34),
      suffixIconColor: const Color(0XFF2F2E34),
      hintStyle: GoogleFonts.fredoka(
        fontSize: 12.sp,
      ),
      labelStyle: GoogleFonts.abel(
        color: Colors.black45,
        fontSize: 16.sp,
      ),
      border: const OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.black,
        ),
      ),
      enabledBorder: const UnderlineInputBorder(
        borderSide: BorderSide(
          color: Colors.black,
        ),
      ),
      focusedBorder: const UnderlineInputBorder(
        borderSide: BorderSide(
          color: Colors.black,
        ),
      ),
      contentPadding: const EdgeInsets.only(top: 15),
    ),
    textTheme: AppTextStyle.lightTextTheme,
  );

  static final ThemeData darkTheme = ThemeData(
    appBarTheme: const AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.black87,
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.light,
      ),
      centerTitle: true,
    ),
    primaryColor: AppColors.darkPrimaryColor,
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
    inputDecorationTheme: InputDecorationTheme(
      prefixIconColor: const Color(0XFFE9E7EF),
      suffixIconColor: const Color(0XFFE9E7EF),
      hintStyle: GoogleFonts.fredoka(
        fontSize: 12.sp,
      ),
      labelStyle: GoogleFonts.abel(
        color: Colors.black45,
        fontSize: 16.sp,
      ),
      border: const OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.black,
        ),
      ),
      enabledBorder: const UnderlineInputBorder(
        borderSide: BorderSide(
          color: AppColors.lightTurquoise,
        ),
      ),
      focusedBorder: const UnderlineInputBorder(
        borderSide: BorderSide(
          color: AppColors.lightTurquoise,
        ),
      ),
      contentPadding: const EdgeInsets.only(top: 15),
    ),
    textTheme: AppTextStyle.darkTextTheme,
  );
}
