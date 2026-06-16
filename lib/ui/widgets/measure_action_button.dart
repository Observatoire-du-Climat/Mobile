import 'package:flutter/material.dart';
import '../../app_theme.dart';

class MeasureActionButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const MeasureActionButton({
    super.key,
    required this.title,
    required this.onTap,
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
          side: const BorderSide(color: AppColors.forestGreen),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: Text(title),
      ),
    );
  }
}