import 'package:flutter/material.dart';
import '../app_theme.dart';

/// Helper class providing the date picker for measure creation and update.
class DatePickerHelper {

  DatePickerHelper._(); // private constructor since its a helper class

  /// Display a date picker
  ///
  /// Returns the selected date or null if the operation is cancelled.
  static Future<DateTime?> pickDate(
      BuildContext context, {
        DateTime? initialDate,
      }) {
    return showDatePicker(
      context: context,
      initialDate: initialDate ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.forestGreen,
              onPrimary: AppColors.white,
              onSurface: Colors.black,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: AppColors.forestGreen,
                textStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          child: child!,
        );
      },
    );
  }
}