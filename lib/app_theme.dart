import 'package:flutter/material.dart';

/// Defines the main colors used by the application.
class AppColors {
  static const white = Color(0xFFFFFFFF);
  static const forestGreen = Color(0xFF224433);
  static const lightGrey = Color(0xFFF2F2F2);
  static const greyBorder = Color(0xFF696969);
}

/// Defines the visual themes used by the application.
class AppTheme {
  static ThemeData get lightTheme{
    return ThemeData(
      scaffoldBackgroundColor: AppColors.white,

      colorScheme: const ColorScheme(
          brightness: Brightness.light,
          primary: AppColors.white,
          onPrimary: AppColors.lightGrey,
          secondary: AppColors.forestGreen,
          onSecondary: AppColors.white,
          error: Colors.red,
          onError: AppColors.white,
          surface: AppColors.lightGrey,
          onSurface: Colors.black),

      textTheme: const TextTheme(
        titleLarge: TextStyle(
          fontSize: 32,
          color : AppColors.forestGreen
        ),
        titleMedium: TextStyle(
          fontSize: 18,
          color : AppColors.forestGreen
        ),
        bodyMedium: TextStyle(
          fontSize: 18,
          color: Colors.black
        )
      )

    );
}
}