import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mythic_todo/common/app_colors.dart';
import 'package:mythic_todo/common/app_fonts.dart';

class AppTextStyle {
  AppTextStyle._();

  static final TextTheme lightTextTheme = TextTheme(
    titleMedium: GoogleFonts.fredoka(
        fontSize: AppFontSize.titleMedium,
        color: AppColors.lightOnBackgroundColor,
        fontWeight: AppFontWeight.medium),
    bodySmall: GoogleFonts.fredoka(
        fontSize: AppFontSize.bodySmall,
        color: AppColors.lightOnBackgroundColor,
        fontWeight: AppFontWeight.regular),
    titleSmall: GoogleFonts.fredoka(
        fontSize: AppFontSize.titleSmall,
        color: AppColors.lightOnNoteColor,
        fontWeight: AppFontWeight.medium),
  );

  static final TextTheme darkTextTheme = TextTheme(
    titleMedium: GoogleFonts.fredoka(
        fontSize: AppFontSize.titleMedium,
        color: AppColors.darkOnBackgroundColor,
        fontWeight: AppFontWeight.medium),
    bodySmall: GoogleFonts.fredoka(
        fontSize: AppFontSize.bodySmall,
        color: AppColors.darkOnBackgroundColor,
        fontWeight: AppFontWeight.regular),
    titleSmall: GoogleFonts.fredoka(
        fontSize: AppFontSize.titleSmall,
        color: AppColors.darkOnNoteColor,
        fontWeight: AppFontWeight.medium),
  );
}
