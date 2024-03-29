import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

class AppTextStyle {
  AppTextStyle._();

  static final TextTheme lightTextTheme = TextTheme(
    titleMedium: GoogleFonts.fredoka(
      // fontSize: AppFontSize.titleMedium,
      color: AppColors.lightOnBackgroundColor,
      // fontWeight: AppFontWeight.medium,
    ),
    bodySmall: GoogleFonts.fredoka(
      // fontSize: 12.sp,
      color: Colors.black54,
      // fontWeight: AppFontWeight.regular,
    ),
    titleSmall: GoogleFonts.fredoka(
      // fontSize: AppFontSize.titleSmall,
      color: AppColors.lightOnNoteColor,
      // fontWeight: AppFontWeight.medium,
    ),
    headlineMedium: GoogleFonts.fredoka(
      // fontSize: 18.sp,
      color: AppColors.lightOnPrimaryColor,
      // fontWeight: FontWeight.w500,
    ),
    bodyMedium: GoogleFonts.fredoka(
      // fontSize: 12.sp,
      color: AppColors.lightOnBackgroundColor,
    ),
  );

  static final TextTheme darkTextTheme = TextTheme(
    titleMedium: GoogleFonts.fredoka(
      // fontSize: AppFontSize.titleMedium,
      color: AppColors.darkOnBackgroundColor,
      // fontWeight: AppFontWeight.medium,
    ),
    bodySmall: GoogleFonts.fredoka(
      // fontSize: 12.sp,
      color: AppColors.darkOnBackgroundColor,
      // fontWeight: AppFontWeight.regular,
    ),
    titleSmall: GoogleFonts.fredoka(
      // fontSize: AppFontSize.titleSmall,
      color: AppColors.darkOnNoteColor,
      // fontWeight: AppFontWeight.medium,
    ),
    headlineMedium: GoogleFonts.fredoka(
      // fontSize: 18.sp,
      color: AppColors.darkOnPrimaryColor,
      // fontWeight: FontWeight.w500,
    ),
    bodyMedium: GoogleFonts.fredoka(
      // fontSize: 12.sp,
      color: AppColors.darkOnPrimaryColor,
    ),
  );
}
