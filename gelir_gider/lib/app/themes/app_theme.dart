import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';
import 'app_text_styles.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.tiffanyBlue,
        primary: AppColors.tiffanyBlue,
        secondary: AppColors.mint,
        tertiary: AppColors.hotPink,
        surface: AppColors.background,
      ),
      scaffoldBackgroundColor: AppColors.background,
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.tiffanyBlue,
        foregroundColor: Colors.white,
        elevation: 0,
        titleTextStyle: GoogleFonts.playfairDisplay(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.tiffanyBlue,
          foregroundColor: AppColors.textPrimary,
          elevation: 0,
          padding: const EdgeInsets.all(16),
          textStyle: GoogleFonts.playfairDisplay(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.hotPink,
          textStyle: GoogleFonts.playfairDisplay(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      cardTheme: CardThemeData(
        color: AppColors.cardBackground,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: AppColors.yellow.withAlpha(100)),
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: AppColors.hotPink,
        elevation: 0,
        indicatorColor: Colors.white.withAlpha(50),
        labelTextStyle: WidgetStatePropertyAll(
          GoogleFonts.playfairDisplay(
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: 12,
          ),
        ),
        iconTheme: WidgetStatePropertyAll(
          const IconThemeData(color: Colors.white),
        ),
      ),
      textTheme: AppTextStyles.lightTextTheme,
      dividerTheme: const DividerThemeData(
        color: AppColors.divider,
        thickness: 1,
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: AppColors.tiffanyBlue,
        foregroundColor: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: ColorScheme.fromSeed(
        brightness: Brightness.dark,
        seedColor: AppColors.darkTiffanyBlue,
        primary: AppColors.darkTiffanyBlue,
        secondary: AppColors.darkMint,
        tertiary: AppColors.darkHotPink,
        surface: AppColors.darkBackground,
      ),
      scaffoldBackgroundColor: AppColors.darkBackground,
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.darkTiffanyBlue,
        foregroundColor: Colors.white,
        elevation: 0,
        titleTextStyle: GoogleFonts.playfairDisplay(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.darkTiffanyBlue,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.all(16),
          textStyle: GoogleFonts.playfairDisplay(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.darkHotPink,
          textStyle: GoogleFonts.playfairDisplay(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      cardTheme: CardThemeData(
        color: AppColors.darkCardBackground,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: AppColors.darkYellow.withOpacity(0.1)),
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: AppColors.hotPink,
        elevation: 0,
        indicatorColor: Colors.white.withOpacity(0.2),
        labelTextStyle: MaterialStateProperty.all(
          GoogleFonts.playfairDisplay(
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: 12,
          ),
        ),
        iconTheme: MaterialStateProperty.all(
          const IconThemeData(color: Colors.white),
        ),
      ),
      textTheme: AppTextStyles.darkTextTheme,
      dividerTheme: const DividerThemeData(
        color: AppColors.darkDivider,
        thickness: 1,
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: AppColors.darkTiffanyBlue,
        foregroundColor: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    );
  }
}
