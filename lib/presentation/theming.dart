import 'package:flutter/material.dart';
import 'package:rick_and_morty/helper/colors.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: AppColors.primaryColor,
      scaffoldBackgroundColor: AppColors.backgroundColor,
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: AppColors.textColor),
        bodyMedium: TextStyle(color: AppColors.subtitleTextColor),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.primaryColor,
        titleTextStyle: TextStyle(color: Colors.white),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      primaryColor: AppColors.primaryVariant,
      scaffoldBackgroundColor: AppColors.greyDark,
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: AppColors.greyLight),
        bodyMedium: TextStyle(color: AppColors.greyMedium),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.primaryVariant,
        titleTextStyle: TextStyle(color: AppColors.greyLight),
      ),
    );
  }

  static ThemeData get secondaryTheme {
    return ThemeData(
      primaryColor: AppColors.secondaryColor,
      scaffoldBackgroundColor: AppColors.surfaceColor,
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: AppColors.textColor),
        bodyMedium: TextStyle(color: AppColors.hintTextColor),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.secondaryColor,
        titleTextStyle: TextStyle(color: Colors.white),
      ),
    );
  }
}
