import 'package:flutter/material.dart';
import '../../app_theme.dart';

class MeasureActionButton extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;
  final Color borderColor;

  const MeasureActionButton({
    super.key,
    required this.title,
    required this.onTap,
    this.borderColor = AppColors.forestGreen
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120,
      height: 36,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.lightGrey,
          foregroundColor: Colors.black,
          elevation: 0,
          side: BorderSide(color: borderColor),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: Text(title),
      ),
    );
  }
}