import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTextStyles {
  // Light Theme Text Styles
  static TextTheme get lightTextTheme {
    return TextTheme(
      // Display styles
      displayLarge: GoogleFonts.playfairDisplay(
        fontSize: 57,
        fontWeight: FontWeight.w400,
        color: AppColors.textPrimary,
        letterSpacing: -0.25,
      ),
      displayMedium: GoogleFonts.playfairDisplay(
        fontSize: 45,
        fontWeight: FontWeight.w400,
        color: AppColors.textPrimary,
      ),
      displaySmall: GoogleFonts.playfairDisplay(
        fontSize: 36,
        fontWeight: FontWeight.w400,
        color: AppColors.textPrimary,
      ),

      // Headline styles
      headlineLarge: GoogleFonts.playfairDisplay(
        fontSize: 32,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      ),
      headlineMedium: GoogleFonts.playfairDisplay(
        fontSize: 28,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      ),
      headlineSmall: GoogleFonts.playfairDisplay(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      ),

      // Title styles
      titleLarge: GoogleFonts.playfairDisplay(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      ),
      titleMedium: GoogleFonts.playfairDisplay(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: AppColors.textPrimary,
        letterSpacing: 0.15,
      ),
      titleSmall: GoogleFonts.playfairDisplay(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: AppColors.textPrimary,
        letterSpacing: 0.1,
      ),

      // Body styles
      bodyLarge: GoogleFonts.playfairDisplay(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: AppColors.textSecondary,
        letterSpacing: 0.5,
      ),
      bodyMedium: GoogleFonts.playfairDisplay(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: AppColors.textSecondary,
        letterSpacing: 0.25,
      ),
      bodySmall: GoogleFonts.playfairDisplay(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: AppColors.textHint,
        letterSpacing: 0.4,
      ),

      // Label styles
      labelLarge: GoogleFonts.playfairDisplay(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: AppColors.textPrimary,
        letterSpacing: 0.1,
      ),
      labelMedium: GoogleFonts.playfairDisplay(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: AppColors.textPrimary,
        letterSpacing: 0.5,
      ),
      labelSmall: GoogleFonts.playfairDisplay(
        fontSize: 11,
        fontWeight: FontWeight.w500,
        color: AppColors.textHint,
        letterSpacing: 0.5,
      ),
    );
  }

  // Dark Theme Text Styles
  static TextTheme get darkTextTheme {
    return TextTheme(
      // Display styles
      displayLarge: GoogleFonts.playfairDisplay(
        fontSize: 57,
        fontWeight: FontWeight.w400,
        color: AppColors.darkTextPrimary,
        letterSpacing: -0.25,
      ),
      displayMedium: GoogleFonts.playfairDisplay(
        fontSize: 45,
        fontWeight: FontWeight.w400,
        color: AppColors.darkTextPrimary,
      ),
      displaySmall: GoogleFonts.playfairDisplay(
        fontSize: 36,
        fontWeight: FontWeight.w400,
        color: AppColors.darkTextPrimary,
      ),

      // Headline styles
      headlineLarge: GoogleFonts.playfairDisplay(
        fontSize: 32,
        fontWeight: FontWeight.w600,
        color: AppColors.darkTextPrimary,
      ),
      headlineMedium: GoogleFonts.playfairDisplay(
        fontSize: 28,
        fontWeight: FontWeight.w600,
        color: AppColors.darkTextPrimary,
      ),
      headlineSmall: GoogleFonts.playfairDisplay(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: AppColors.darkTextPrimary,
      ),

      // Title styles
      titleLarge: GoogleFonts.playfairDisplay(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        color: AppColors.darkTextPrimary,
      ),
      titleMedium: GoogleFonts.playfairDisplay(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: AppColors.darkTextPrimary,
        letterSpacing: 0.15,
      ),
      titleSmall: GoogleFonts.playfairDisplay(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: AppColors.darkTextPrimary,
        letterSpacing: 0.1,
      ),

      // Body styles
      bodyLarge: GoogleFonts.playfairDisplay(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: AppColors.darkTextSecondary,
        letterSpacing: 0.5,
      ),
      bodyMedium: GoogleFonts.playfairDisplay(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: AppColors.darkTextSecondary,
        letterSpacing: 0.25,
      ),
      bodySmall: GoogleFonts.playfairDisplay(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: AppColors.darkTextHint,
        letterSpacing: 0.4,
      ),

      // Label styles
      labelLarge: GoogleFonts.playfairDisplay(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: AppColors.darkTextPrimary,
        letterSpacing: 0.1,
      ),
      labelMedium: GoogleFonts.playfairDisplay(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: AppColors.darkTextPrimary,
        letterSpacing: 0.5,
      ),
      labelSmall: GoogleFonts.playfairDisplay(
        fontSize: 11,
        fontWeight: FontWeight.w500,
        color: AppColors.darkTextHint,
        letterSpacing: 0.5,
      ),
    );
  }
}
